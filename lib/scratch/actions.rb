
module Scratch 

  module Actions

    require 'fileutils'

    def self.copy_templates(dest)

    end

    class Exec

      def self.init(raw_args, args)
        if raw_args.length != 1
          $stderr.puts CLI::error('No name was provided for the project')
          exit(-3)
        end

        project_name = raw_args[0]
        current_dir  = FileUtils.pwd

        begin
          FileUtils.mkdir(File.join(current_dir, project_name))
          puts CLI::success("Created #{project_name}")
        rescue Errno::EACCES
          $stderr.puts CLI::error("Can not create #{project_name}, permission denied")
          exit(-4)
        rescue Errno::EEXIST
          puts CLI::info("#{project_name} already exists, using it")
        rescue => e
          $stderr.puts CLI::error("Unknown error: #{e.message}")
          exit(-5)
        end

      end

      def self.test(raw_args, args)
      end

      def self.publish(raw_args, args)
      end

    end # class Exec

  end # module Actions

end # module Scratch
