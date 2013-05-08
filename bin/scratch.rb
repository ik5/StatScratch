#!/usr/bin/env ruby
# encoding: utf-8

require 'rubygems'

# Adding to load path also our location. 
$BASE_PATH = File.expand_path(File.dirname(__FILE__) + '/..')
$LOAD_PATH.unshift($BASE_PATH + '/lib')

begin
  require 'bundler'
  ENV["BUNDLE_GEMFILE"] = $BASE_PATH + '/Gemfile'
  Bundler.require(:default)
rescue LoadError => e
  $stderr.puts "Could not load dependency: #{e.message}"
  exit(-1)
end

require 'scratch_all'

action = Scratch::CLI::ToAction.new(ARGV)
action.run

