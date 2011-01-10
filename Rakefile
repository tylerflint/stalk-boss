require 'rubygems'
require 'rspec/core/rake_task'
require 'jeweler'

Jeweler::Tasks.new do |s|
	s.name = "stalk_boss"
	s.summary = "A wrapper for adding hot reloading to Stalker."
	s.description = "A wrapper for adding hot reloading to Stalker"
	s.author = "Ryan Dew"
	s.email = "ryan@delorum.com"
	s.executables = [ "stalk_boss", "bossed_stock" ]

	s.add_dependency 'stalker'

	s.files = FileList["[A-Z]*", "{bin,lib}/**/*"]
end

RSpec::Core::RakeTask.new(:test)