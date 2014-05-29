# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "spvoice/version"

Gem::Specification.new do |s|
  s.name        = "spvoice"
  s.version     = SPVoice::VERSION
  s.authors     = ["Jordan Hackworth"]
  s.email       = ["spvoice@jordanhackworth.com"]
  s.homepage    = "https://github.com/Hackworth"
  s.summary     = %q{A Voice Automation Parser}
  s.description = %q{}

  s.files         = `git ls-files 2> /dev/null`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/* 2> /dev/null`.split("\n")
  s.executables   = `git ls-files -- bin/* 2> /dev/null`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.required_ruby_version = Gem::Requirement.new(">= 1.9.2")

  s.add_runtime_dependency "CFPropertyList", "=2.1.2"
  s.add_runtime_dependency "eventmachine"
  s.add_runtime_dependency "uuidtools"
  s.add_runtime_dependency "cora", "=0.0.4"
  s.add_runtime_dependency "bundler"
  s.add_runtime_dependency "rake"
  s.add_runtime_dependency "rubydns", "~> 0.6.0"
end
