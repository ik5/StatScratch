# encoding: utf-8

module Scratch
  module CLI

    COLORS = {
      :reset     => "\e[0m",
      :bold      => "\e[1m",
      :italic    => "\e[3m",
      :underline => "\e[4m",
      :blink1    => "\e[5m",
      :blink2    => "\e[6m",
      :blinkoff  => "\e[25m",
      :black     => "\e[30m",
      :red       => "\e[31m",
      :green     => "\e[32m",
      :yellow    => "\e[33m",
      :blue      => "\e[34m",
      :magenta   => "\e[35m",
      :cyan      => "\e[36m",
      :white     => "\e[47m",
    }

    DEFAILT_ACTION = :test

    ACTIONS        = [:init, :test, :publish]

    class CliParser
      def self.parse(argv)
        cmd = nil
        Slop.parse(argv) do 
          command :init do
            run do |opt, args|
              cmd = { action: :init, args: args }
            end # run do |opt, args|
          end # command :init do

          command :test do
            run do |opt, args|
              cmd = { action: :test, args: args }
            end # run do |opt, args|
          end # command :test do

          command :publish do
            run do |opt, args|
              cmd = { action: :publish, args: args }
            end # run do |opt, args|
          end # command :publish do
        end # Slop.parse(args)

        cmd 
      end # def self.parse

    end # class CliParser

    class ToAction
      def initialize(argv)
         @action = CliParser.parse(argv)

         # if action is nil, set the default action
         @action = { action: DEFAILT_ACTION, args: [] } unless @action
      end # def initialize

      def run 
        case @action[:action]
          when :init
          when :test
          when :publish
        end
      end # def run 

    end # class ToAction
  end # module CLI
end # module Scratch

