# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "speller/version"

Gem::Specification.new do |s|
  s.name        = "speller"
  s.version     = Speller::VERSION
  s.authors     = ["Adam Bray"]
  s.email       = ["adam.bray@gmail.com"]
  s.homepage    = ""
  s.summary     = "Gem to check spelling"
  s.description = "Gem to check spelling"

  s.rubyforge_project = "speller"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "ffi", "~>1.0.9"
end
