# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{stalk-boss}
  s.version = "0.1.11"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Dew"]
  s.date = %q{2011-01-14}
  s.description = %q{A wrapper for adding hot reloading to Stalker}
  s.email = %q{ryan@delorum.com}
  s.executables = ["stalk_boss", "bossed_stalk"]
  s.extra_rdoc_files = [
    "README"
  ]
  s.files = [
    "README",
    "Rakefile",
    "VERSION",
    "bin/bossed_stalk",
    "bin/stalk_boss",
    "lib/stalk_boss.rb"
  ]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{A wrapper for adding hot reloading to Stalker.}
  s.test_files = [
    "spec/stalk_boss_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<stalker>, [">= 0"])
    else
      s.add_dependency(%q<stalker>, [">= 0"])
    end
  else
    s.add_dependency(%q<stalker>, [">= 0"])
  end
end

