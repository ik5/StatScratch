#!/usr/bin/env ruby
# encoding: utf-8

require 'rubygems'
require 'optparse'

begin
  require 'bundler'
  Bundler.require(:default)
rescue LoadError > e
  $stderr.puts "Could not load dependency: #{e.message}"
  exit(-2)
end

# Adding to load path also our location. 
$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + '/../lib'))

require 'scratch_all'

action = Scratch::ToAction.new
action.run

