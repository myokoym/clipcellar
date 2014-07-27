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

require "fileutils"
require "stringio"
require "clipcellar/version"
require "clipcellar/command"

class CommandTest < Test::Unit::TestCase
  class << self
    def startup
      @@tmpdir = File.join(File.dirname(__FILE__), "tmp", "database")
      FileUtils.rm_rf(@@tmpdir)
      FileUtils.mkdir_p(@@tmpdir)
      @@command = Clipcellar::Command.new
      @@command.instance_variable_set(:@database_dir, @@tmpdir)
    end

    def shutdown
      FileUtils.rm_rf(@@tmpdir)
    end
  end

  def test_version
    s = ""
    io = StringIO.new(s)
    $stdout = io
    @@command.version
    assert_equal("#{Clipcellar::VERSION}\n", s)
    $stdout = STDOUT
  end
end
