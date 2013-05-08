#!/usr/bin/env ruby

require 'rubygems'
require 'optparse'
require 'bundler'

Bundler.require(:default)

require '../lib/scratch_all'

action = Scratch::ToAction.new
action.run

