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
    end # def run 

  end # class ToAction

end # module Scratch

