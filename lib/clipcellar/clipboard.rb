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

begin
  require "gtk2"
rescue Gtk::InitError
  # a window system is unnecessary.
end

module Clipcellar
  class Clipboard
    class << self
      def watch
        current_text = get
        GLib::Timeout.add(500) do
          text = get
          if current_text != text
            yield(text)
            current_text = text
          end
          true
        end

        begin
          Gtk.main
        rescue Interrupt => e
          $stderr.puts(e.message)
        end
      end

      def get
        if /darwin/ =~ RUBY_PLATFORM
          `pbpaste`
        else
          clipboard.wait_for_text
        end
      end

      def set(text)
        copy_to_clipboard(text)

        # workaround for CLI
        GLib::Timeout.add(1) do
          Gtk.main_quit
        end
        Gtk.main
      end

      def copy_to_clipboard(text)
        if /darwin/ =~ RUBY_PLATFORM
          require "tempfile"
          Tempfile.open(["clipcellar", "w"]) do |file|
            text.each_line do |line|
              file.puts(line)
            end
            file.flush
            system("pbcopy < #{file.path}")
          end
        else
          clipboard.text = text
        end
      end

      def clipboard
        Gtk::Clipboard.get(Gdk::Selection::CLIPBOARD)
      end
    end
  end
end
