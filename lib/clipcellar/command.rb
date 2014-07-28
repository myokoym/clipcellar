# Copyright (C) 2014  Masafumi Yokoyama <myokoym@gmail.com>
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

require "thor"
require "fileutils"
require "clipcellar/version"
require "clipcellar/groonga_database"
require "clipcellar/groonga_searcher"
require "clipcellar/clipboard"
require "clipcellar/window"

module Clipcellar
  class Command < Thor
    map "-v" => :version
    map "-a" => :set
    map "-A" => :input
    map "-s" => :show
    map "-S" => :search
    map "-W" => :watch

    def initialize(*args)
      super
      @base_dir = File.join(File.expand_path("~"), ".clipcellar")
      @database_dir = File.join(@base_dir, "db")
    end

    desc "version", "Show version number."
    def version
      puts Clipcellar::VERSION
    end

    desc "set [TEXT]", "Add a text (or clipboard) to data store"
    def set(text=nil)
      text = Clipboard.get unless text
      return unless text
      Clipboard.set(text)
      add(text)
    end

    desc "input [FILE]...", "Add a text from files (or stdin)"
    def input(*files)
      ARGV.shift
      text = ""
      while line = ARGF.gets
        text << line
      end
      Clipboard.set(text)
      add(text)
    end

    desc "watch", "Watch clipboard to add clipboard to data store"
    def watch
      Clipboard.watch do |text|
        add(text)
      end
    end

    desc "show", "Show added texts in data store"
    option :gui, :type => :boolean, :desc => "GUI mode"
    def show
      records = []
      GroongaDatabase.new.open(@database_dir) do |database|
        database.clipboards.each do |clipboard|
          record = {}
          record[:key] = clipboard._key
          record[:text] = clipboard.text
          record[:time] = clipboard.created_at
          records << record
        end
      end

      if options[:gui]
        records.reverse!
        window = Window.new(records)
        window.run
      else
        records.each do |record|
          text = record[:text]
          date = record[:time].strftime("%Y-%m-%d %H:%M:%S")
          puts "#{date} #{text.gsub(/\n/, ' ')}"
        end
      end
    end

    desc "search WORD...", "Search texts from data store"
    option :gui, :type => :boolean, :desc => "GUI mode"
    def search(*words)
      records = []
      GroongaDatabase.new.open(@database_dir) do |database|
        sorted_clipboards = GroongaSearcher.search(database, words, options)

        sorted_clipboards.each do |clipboard|
          record = {}
          record[:key] = clipboard._key
          record[:text] = clipboard.text
          record[:time] = clipboard.created_at
          records << record
        end
      end

      if options[:gui]
        window = Window.new(records)
        window.run
      else
        text = nil
        records.each do |record|
          text = record[:text]
          date = record[:time].strftime("%Y-%m-%d %H:%M:%S")
          puts "#{date} #{text.gsub(/\n/, ' ')}"
        end
        Clipboard.set(text) if text
      end
    end

    desc "destroy", "Delete data store and all added texts"
    def destroy
      FileUtils.rm(Dir.glob(File.join(@database_dir, "clipcellar.db*")))
      FileUtils.rmdir(@database_dir)
    end

    private
    def add(text)
      date = Time.now
      id = date.strftime("%Y%m%d%H%M%S%L")
      GroongaDatabase.new.open(@database_dir) do |database|
        database.add(id, text, date)
      end
    end
  end
end
