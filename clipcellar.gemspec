# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'clipcellar/version'

Gem::Specification.new do |spec|
  spec.name          = "clipcellar"
  spec.version       = Clipcellar::VERSION
  spec.authors       = ["Masafumi Yokoyama"]
  spec.email         = ["myokoym@gmail.com"]
  spec.summary       = %q{Full-Text Searchable Storage for Clipboard}
  spec.description   = %q{Clipcellar is a full-text searchable storage for clipboard by GTK+ (via Ruby/GTK3) and Groonga (via Rroonga).}
  spec.homepage      = "https://github.com/myokoym/clipcellar"
  spec.license       = "LGPLv2.1 or later"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) {|f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency("gtk3")
  spec.add_runtime_dependency("rroonga")
  spec.add_runtime_dependency("thor")

  spec.add_development_dependency("test-unit")
  spec.add_development_dependency("test-unit-notify")
  spec.add_development_dependency("test-unit-rr")
  spec.add_development_dependency("bundler", "~> 1.6")
  spec.add_development_dependency("rake")
end
