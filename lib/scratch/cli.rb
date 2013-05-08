# encoding: utf-8

module Scratch
  DEFAILT_ACTION = :test

  ACTIONS        = [:init, :test, :publish]

  class CliParser
    def self.parse(args)
      opts = Slop.parse(args) do 
        command :init do
          
        end # command 'init' do
      end # Slop.parse(args)

      opts
    end # def self.parse

  end # class CliParser

  class ToAction
    def initialize(argv)
       @action = CliParser.parse(argv)
    end # def initialize

    def run 
       if @action.kind_of? Symbol
         # White list of actions. 
         # Do not allow non white list to execute - security risk
         if ACTIONS.include? @action
           Actions.send(@action)
         else
           $stderr.puts 'I\'llgal action'
           exit(-1)
         end # if ACTIONS.include? action
       elsif @action.kind_of? String
         puts @action
         exit(0)
       elsif @action.kind_of? NilClass
         # No action
         Actions.send(DEFAILT_ACTION)
       else
         $stderr.puts 'Unknown action was provided.'
         exit(-1)
       end # if action.kind_of? Symbol
    end # def run 

  end # class ToAction

end # module Scratch

