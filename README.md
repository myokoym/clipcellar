# Clipbocellar

Clipbocellar is a full-text searchable storage for clipboard.

Powered by GTK+ (via Ruby/GTK3) and Groonga (via Rroonga).

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

Register URL

    $ clipbocellar register http://example.net/rss

Import URL from OPML

    $ clipbocellar import registers.xml

Export registerd resources to OPML to STDOUT

    $ clipbocellar export

Show registers

    $ clipbocellar list

Collect feeds (It takes several minutes)

    $ clipbocellar collect

Word search from titles and descriptions

    $ clipbocellar search ruby

Rich view by curses (set as default since 0.4.0)

    $ clipbocellar search ruby --curses

    Keybind:
      j: down
      k: up
      f, ENTER: open the link on Firefox
      q: quit

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
