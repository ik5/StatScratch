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
      :black     => "\e[30;1m",
      :red       => "\e[31;1m",
      :green     => "\e[32;1m",
      :yellow    => "\e[33;1m",
      :blue      => "\e[34;1m",
      :magenta   => "\e[35;1m",
      :cyan      => "\e[36;1m",
      :white     => "\e[47;1m",
    }

    def self.to_color(str, color = :green )
      return COLORS[color] + str + COLORS[:reset] if COLORS.include? color
      # do we have a valid color ?
      str
    end

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
          puts "[#{CLI::to_color('info', :yellow)}] Executing #{@action[:action]}."
          Actions::Exec.send(@action[:action], @action[:raw_args], @action[:args]) 
        else # should never happen, because it should be :test
          $stderr.puts "#{CLI::to_color('*', :red)} Invalid action \"#{@action[:action]}\"."
          exit(-1)
        end
      end # def run 

    end # class ToAction
  end # module CLI
end # module Scratch

