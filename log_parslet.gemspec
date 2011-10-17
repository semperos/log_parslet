# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "log_parslet/version"

Gem::Specification.new do |s|
  s.name        = "log_parslet"
  s.version     = LogParslet::VERSION
  s.authors     = ["Daniel Gregoire"]
  s.email       = ["dgregoire@bericotechnologies.com"]
  s.homepage    = ""
  s.summary     = %q{Simple Ruby parser for various log formats}
  s.description = %q{Ruby parser based on the Parslet PEG tool, designed to handle multiple common formats and allow for easy construction of new parsers based on component parts.}

  s.rubyforge_project = "log_parslet"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "guard"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "rb-fsevent"
  s.add_development_dependency "growl"
  s.add_development_dependency "rspec"
  s.add_runtime_dependency "parslet", "~> 1.2"
end
