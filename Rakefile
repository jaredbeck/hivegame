#!/usr/bin/env rake

require 'bundler/gem_tasks'
require 'rake/dsl_definition'
require 'rake'
require 'rspec/core/rake_task'

task default: :spec

# Turn off rspec verbosity, so that the resultant rspec command,
# and all the spec names, are not echoed to stdout.
# See http://bit.ly/MoOoB3 -Jared 2012-07-19
if defined? RSpec
  task(:spec).clear
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.verbose = false
  end
end

