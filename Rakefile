# coding: utf-8
require 'bundler/gem_tasks'
require 'rubocop/rake_task'
require 'rspec/core/rake_task'

Rubocop::RakeTask.new
RSpec::Core::RakeTask.new

task default: [:rubocop, :spec]
