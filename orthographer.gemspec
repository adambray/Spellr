# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "orthographer/version"

Gem::Specification.new do |s|
  s.name        = "orthographer"
  s.version     = Orthographer::VERSION
  s.authors     = ["Adam Bray"]
  s.email       = ["adam.bray@gmail.com"]
  s.homepage    = ""
  s.summary     = "Gem to check spelling"
  s.description = "Gem to check spelling"

  s.rubyforge_project = "orthographer"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "ffi", "~>1.0.9"
end
