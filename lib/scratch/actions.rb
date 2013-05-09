
module Scratch 

  module Actions

    require 'fileutils'

    def self.copy_templates(dest)
    end

    class Exec

      def self.init(raw_args, args)
        if raw_args.length != 1
          $stderr.puts CLI::error("No name was provided for the project")
          exit(-3)
        end
        
      end

      def self.test(raw_args, args)
      end

      def self.publish(raw_args, args)
      end

    end # class Exec

  end # module Actions

end # module Scratch
