# Clipcellar

Clipcellar is a full-text searchable data store for clipboard.

Powered by [GTK+][] (via [Ruby/GTK2][]) and [Groonga][] (via [Rroonga][]).

[GTK+]:http://www.gtk.org/
[Ruby/GTK2]:http://ruby-gnome2.sourceforge.jp/
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

### Show help

    $ clipcellar

### Add a text (or clipboard) to data store

    $ clipcellar set [TEXT]

### Add a text from files (or stdin)

    $ clipcellar input [FILE]...

### Show added texts in data store

    $ clipcellar show [--lines=N] [--gui]

### Full-text search (and set a text to clipboard)

    $ clipcellar search WORD... [--gui]

### Watch clipboard (Ctrl+C to stop)

    $ clipcellar watch

### Delete duplicated texts from data store

    $ clipcellar uniq

### Delete data store and all added texts

    $ clipcellar destroy

## License

Copyright (c) 2014 Masafumi Yokoyama `<myokoym@gmail.com>`

LGPLv2.1 or later.

See LICENSE.txt or http://www.gnu.org/licenses/lgpl-2.1 for details.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
