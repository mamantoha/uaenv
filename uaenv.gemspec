# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "uaenv/version"

Gem::Specification.new do |s|
  s.name        = "uaenv"
  s.version     = Uaenv::VERSION
  s.authors     = ["Anton Maminov"]
  s.email       = ["anton.linux@gmail.com"]
  s.homepage    = "https://github.com/mamantoha/uaenv"
  s.summary     = %q{Simple processing of Ukrainian strings}
  s.description = %q{Simple processing of Ukrainian strings}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
