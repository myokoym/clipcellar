# Clipcellar

Clipcellar is a full-text searchable storage for clipboard.

Powered by [GTK+][] (via [Ruby/GTK3][]) and [Groonga][] (via [Rroonga][]).

[GTK+]:http://www.gtk.org/
[Ruby/GTK3]:http://ruby-gnome2.sourceforge.jp/
[Groonga]:http://groonga.org/
[Rroonga]:http://ranguba.org/

## Installation

Add this line to your application's Gemfile:

    gem 'clipcellar'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install clipcellar

## Usage

Show help

    $ clipcellar

Add a text (or clipboard) to storage

    $ clipcellar set [TEXT]

Add a text from files (or stdin)

    $ clipcellar input [FILE]...

Show added texts in storage

    $ clipcellar show

Full-text search (and set a text to clipboard)

    $ clipcellar search WORD...

Watch clipboard (Ctrl+C to stop)

    $ clipcellar watch

Delete database

    $ rm -r ~/.clipcellar

## License

Copyright (c) 2014 Masafumi Yokoyama `<myokoym@gmail.com>`

LGPLv2.1 or later.

See 'license/lgpl-2.1.txt' or 'http://www.gnu.org/licenses/lgpl-2.1' for details.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
