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

require "gtk3"
require "erb"

module Clipcellar
  class TreeView < Gtk::TreeView
    KEY_COLUMN, TEXT_COLUMN, TIME_COLUMN, STRFTIME_COLUMN, LINE_COLUMN, ESCAPED_TEXT_COLUMN = *0..5

    def initialize(records)
      super()
      @records = records
      @model = Gtk::ListStore.new(String, String, Time, String, String, String)
      create_tree(@model)
    end

    def next
      move_cursor(Gtk::MovementStep::DISPLAY_LINES, 1)
    end

    def prev
      move_cursor(Gtk::MovementStep::DISPLAY_LINES, -1)
    end

    def remove_selected_record
      @model.remove(selected_iter)
    end

    def get_text(path)
      @model.get_iter(path).get_value(TEXT_COLUMN)
    end

    def selected_key
      selected_iter.get_value(KEY_COLUMN)
    end

    def selected_text
      selected_iter.get_value(TEXT_COLUMN)
    end

    def selected_time
      selected_iter.get_value(TIME_COLUMN)
    end

    def selected_iter
      @model.get_iter(selected_path)
    end

    def selected_path
      selected = selection.selected
      @model.get_path(selected)
    end

    private
    def create_tree(model)
      set_model(model)
      self.search_column = TEXT_COLUMN
      self.enable_search = false
      self.rules_hint = true
      self.tooltip_column = ESCAPED_TEXT_COLUMN

      selection.set_mode(:browse)

      @records.each do |record|
        load_record(model, record)
      end

      column = Gtk::TreeViewColumn.new
      column.title = "Inserted Time"
      append_column(column)
      renderer = Gtk::CellRendererText.new
      column.pack_start(renderer, :expand => false)
      column.add_attribute(renderer, :text, STRFTIME_COLUMN)

      column = Gtk::TreeViewColumn.new
      column.title = "Part of a Text (the Full Text appears in a Tooltip)"
      append_column(column)
      renderer = Gtk::CellRendererText.new
      column.pack_start(renderer, :expand => false)
      column.add_attribute(renderer, :text, LINE_COLUMN)

      expand_all
    end

    def load_record(model, record)
      iter = model.append
      iter.set_value(KEY_COLUMN, record[:key])
      iter.set_value(TEXT_COLUMN, record[:text])
      iter.set_value(TIME_COLUMN, record[:time])
      iter.set_value(STRFTIME_COLUMN, record[:time].strftime("%Y-%m-%d %H:%M:%S"))
      iter.set_value(LINE_COLUMN, record[:text].gsub(/[\n\t]/, " "))
      escaped_text = ERB::Util.html_escape(record[:text])
      iter.set_value(ESCAPED_TEXT_COLUMN, escaped_text)
    end
  end
end
