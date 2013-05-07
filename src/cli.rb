

module Scratch
  DEFAILT_ACTION = :test
  class CliParser
    def self.parse(args)
      opt_parser = OptionParser.new do |opts|
        opts.banner = 'Usage: scratch.rb [action]'
        opts.separtor ''
        opts.separtor 'Action:'

        opts.on('init', String, 'Create new project') do |act|
          return :init
        end

        opts.on('test', String, 'Test files on draft') do |act|
          return :test
        end

        opts.on('publish', String, 'Publish files on drafts that are set to false') do |act|
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
end # module Scratch

