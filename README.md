# Clipbocellar

Clipbocellar is a full-text searchable storage for clipboard.

Powered by [GTK+][] (via [Ruby/GTK3][]) and [Groonga][] (via [Rroonga][]).

[GTK+]:http://www.gtk.org/
[Ruby/GTK3]:http://ruby-gnome2.sourceforge.jp/
[Groonga]:http://groonga.org/
[Rroonga]:http://ranguba.org/

## Installation

Add this line to your application's Gemfile:

    gem 'clipbocellar'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install clipbocellar

## Usage

Show help

    $ clipbocellar

Set a text or a current clipboard

    $ clipbocellar set [TEXT]

Set texts from ARGF

    $ clipbocellar argf [FILE_OR_STDIN]

Show added texts (and set the latest text to clipboard)

    $ clipbocellar show

Full-text search (and set the latest text to clipboard)

    $ clipbocellar search WORD...

Watch clipboard (Ctrl+C to stop)

    $ clipbocellar watch

Delete database

    $ rm -r ~/.clipbocellar

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
