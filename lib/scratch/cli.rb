

module Scratch
  DEFAILT_ACTION = :test

  ACTIONS        = [:init, :test, :publish]

  class CliParser
    def self.parse(args)
      opt_parser = OptionParser.new do |opts|
        opts.banner = 'Usage: scratch.rb [action]'
        opts.separtor ''
        opts.separtor 'Action:'

        opts.on('init', 'Create new project') do |act|
          return :init
        end

        opts.on('test', 'Test files on draft') do |act|
          return :test
        end

        opts.on('publish', 'Publish files on drafts that are set to false') do |act|
          return :publish
        end

        opts.on_tail('-h', 'help', 'Display help screen') do
          return opts
        end

        opts.on_tail('--version', 'Show version') do
          return VERSION
        end
      end # opt_parser

      opt_parser.parse!(args)
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

