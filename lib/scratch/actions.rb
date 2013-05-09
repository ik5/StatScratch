
module Scratch 

  module Actions

    class FileActions
      require 'fileutils'

      @src = File.join($BASE_PATH, 'project_template')

      def self.scan_dir(path)
        tree = []
        Dir.foreach(path) do |f|
          next if f == '.' || f == '..'
          location = File.join(path, f)
          if File.directory?(location)
            tree << File.join(f, '') # add last slash
            tree += scan_dir(location)
          else
            tree << f
          end # if File.directory?(location)
        end # Dir.foreach(path) do |f|
      end # def scan_dir(path)

      def self.copy_templates
        dest = Dir.pwd


        # logic goes here

        Dir.chdir(dest) # return to dest when done
      end # self.copy_templates

      def self.copy_file(src, dest)
        FileUtils.cp(src, dest)
        true
      rescue Errno::ENOENT => e
        $stderr.puts CLI::error("Could not copy file: #{e.message}")
        return false
      rescue Errno::EACCES => e
        $stderr.puts CLI::error("Problem with permission while trying to copy #{e.message}")
        return false
      rescue ArgumentError
        $stderr.puts CLI::error('Could not copy source to itself')
        return false
      rescue => e
        $stderr.puts CLI::error("Unknown error while trying to copy file: #{e.message}")
        return false
      end # def self.copy_file(src, dest)

      def self.generate_project_dir(project_path)

        return [0] if File.exists?(project_path)

        FileUtils.mkdir(project_path)
        return [1] # just to see it clear
      rescue Errno::EACCES
        return [-4]
      rescue Errno::EEXIST # should never happen, but just in case
        return [0]
      rescue => e
        return [-5, e]
      end

    end # class FileActions

    class Exec

      def self.init(raw_args, args)
        if raw_args.length != 1
          $stderr.puts CLI::error('No name was provided for the project')
          exit(-3)
        end

        project_name = raw_args[0]
        project_path = File.join(Dir.pwd, project_name)

        result = FileActions.generate_project_dir(project_path)
        if result[0] == 0 || result[0] == 1
          Dir.chdir(project_path) 
        end

        case result[0]
        when 0 
          puts CLI::info("#{project_name} already exists, using it")
        when 1 
          puts CLI::success("Created #{project_name}")
        when -4  
          $stderr.puts CLI::error("Can not create #{project_name}, permission denied")
        when -5
          $stderr.puts CLI::error("Unknown error: #{result[1].message}")
        end # case result
        
        exit(result[0]) if result[0] < 0
      end

      def self.test(raw_args, args)
      end

      def self.publish(raw_args, args)
      end

    end # class Exec

  end # module Actions

end # module Scratch
