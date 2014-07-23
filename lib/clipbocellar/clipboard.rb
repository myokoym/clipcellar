require "gtk3"

module Clipbocellar
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
        Gtk.main
      end

      def get
        clipboard.wait_for_text
      end

      def set(text)
        clipboard.text = text
        GLib::Timeout.add(1) do
          Gtk.main_quit
        end
        Gtk.main
      end

      def clipboard
        Gtk::Clipboard.get(Gdk::Selection::CLIPBOARD)
      end
    end
  end
end
