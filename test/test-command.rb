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
