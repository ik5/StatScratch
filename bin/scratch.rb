#!/usr/bin/env ruby

require 'rubygems'
require 'optparse'
require 'bundler'

Bundler.require(:default)

require 'cli'
require 'actions'
require 'version'

action = Scratch::ToAction.new
action.run

