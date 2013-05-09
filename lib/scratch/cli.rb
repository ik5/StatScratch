# encoding: utf-8

module Scratch
  module CLI

    class << self
      COLORS = {
        :reset     => "\e[0m",
        :bold      => "\e[1m",
        :italic    => "\e[3m",
        :underline => "\e[4m",
        :blink1    => "\e[5m",
        :blink2    => "\e[6m",
        :blinkoff  => "\e[25m",
        :black     => "\e[30;1m",
        :red       => "\e[31;1m",
        :green     => "\e[32;1m",
        :yellow    => "\e[33;1m",
        :blue      => "\e[34;1m",
        :magenta   => "\e[35;1m",
        :cyan      => "\e[36;1m",
        :white     => "\e[47;1m",
      }

      def to_color(str, color = :green )
        return COLORS[color] + str + COLORS[:reset] if COLORS.include? color
        # do we have a valid color ?
        str
      end

      def success(str, sign = :text)
        text = sign == :smybol ? '✓' : 'ok'
        "[#{to_color(text, :green)}] #{str}"
      end

      def info(str)
        "[#{to_color('info', :yellow)}] #{str}"
      end

      def error(str, sign = :text)
        text = sign == :smybol ? '✘' : 'error'
        "[#{to_color(text, :red)}] #{str}"
      end

      def color_v
        to_color('✓', :green)
      end

      def color_x
        to_color('✘', :red)
      end
    end # class << self

    DEFAILT_ACTION = :test

    ACTIONS        = [:init, :test, :publish]

    class CliParser
      def self.parse(argv)
        cmd = nil
        options = Slop.parse(argv) do 
          command 'init' do
            run do |opt, args|
              cmd = { action: :init, raw_args: args, args: nil}
            end # run do |opt, args|
          end # command :init do

          command :test do
            run do |opt, args|
              cmd = { action: :test, raw_args: args, args: nil}
            end # run do |opt, args|
          end # command :test do

          command :publish do
            run do |opt, args|
              cmd = { action: :publish, raw_args: args, args: nil}
            end # run do |opt, args|
          end # command :publish do
        end # Slop.parse(args)

        if cmd
          # add additional arguments that might exists
          # the argument is actually a hash
          args = options.to_hash(true)[cmd[:action]]
          cmd[:args] = args
        end

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
        if ACTIONS.include? @action[:action]
          puts CLI::info("Executing #{@action[:action]}.")
          Actions::Exec.send(@action[:action], @action[:raw_args], @action[:args]) 
        else # should never happen, because it should be :test
          $stderr.puts CLI::error("Invalid action \"#{@action[:action]}\".")
          exit(-2)
        end
      end # def run 

    end # class ToAction
  end # module CLI
end # module Scratch

