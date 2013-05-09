
module Scratch 

  module Actions

    module FileActions
      require 'fileutils'
       @src = File.join($BASE_PATH, 'project_template')

      class << self
        def scan_dir(path)
          tree = []
          Dir.foreach(path) do |f|
            next if f == '.' || f == '..'
            location   = File.join(path, f)
            loc_suffix = location[@src.length..-1]
            if File.directory?(location)
              tree << File.join(loc_suffix, '') # add last slash
              tree += scan_dir(location)
            else
              tree << loc_suffix
            end # if File.directory?(location)
          end # Dir.foreach(path) do |f|
          tree
        end # def scan_dir(path)

        def copy_templates
          dest = Dir.pwd
          tree = scan_dir(@src)
          dirs = tree.select { |a| a.end_with?(File::SEPARATOR) }
          tree.delete_if { |a| a.end_with?(File::SEPARATOR) }

          # where to take the files from
          src_files  = tree.map { |f| File.join(@src, f) }
          # where to place the files
          dest_files = tree.map { |f| File.join(dest, f) }
          # directories to create
          dest_dirs  = dirs.map  { |d| File.join(dest, d) }

          result = mkdir(dest_dirs)
          return result unless result[0] == 1
          puts CLI::success('Created/Updated skelaton directories')

          src_files.each_with_index do |file, i|
            file_name = file[@src.length..-1]
            # TODO: Check if a file is a template, and work with it
            if File.exists?(dest_files[i])
              puts CLI::info("#{file_name} exists, no touching") 
              next
            end
            result = copy_file(file, dest_files[i])
            return if result[0] < 0
            
            puts CLI::success("generated #{file_name}") 
          end
          
          return [1] # generated template
        end # self.copy_templates

        def mkdir(dirs)
          FileUtils.mkdir_p(dirs)
          [1]
        rescue Errno::EACCES => e
          return [Scratch::NO_PREMISSION_ERROR, e]
        rescue => e
          $stderr.puts CLI::error("Unknown error while trying to copy file: #{e.message}")
          return [Scratch::UNKNOWN_ERROR, e]
        end # def self.mkdir(dirs)

        def copy_file(src, dest)
          FileUtils.cp(src, dest)
          [1]
        rescue Errno::ENOENT => e
          return [Scratch::FILE_NOT_FOUND, e]
        rescue Errno::EACCES => e
          return [Scratch::NO_PREMISSION_ERROR, e]
        rescue ArgumentError => e
          return [Scratch::SELF_COPY_FILE, e]
        rescue => e
          return [Scratch::UNKNOWN_ERROR, e]
        end # def self.copy_file(src, dest)

        def generate_project_dir(project_path)

          return [0] if File.exists?(project_path)

          Dir.mkdir(project_path)
          return [1] # just to see it clear
        rescue Errno::EACCES
          return [Scratch::NO_PREMISSION_ERROR]
        rescue Errno::EEXIST # should never happen, but just in case
          return [0]
        rescue => e
          return [Scratch::UNKNOWN_ERROR, e]
        end # generate_project_dir(project_path)

      end # class << self

    end # module FileActions

    class Exec

      def self.init(raw_args, args)
        if raw_args.length != 1
          $stderr.puts CLI::error('No name was provided for the project')
          exit(Scratch::NO_PROJECT_NAME)
        end

        project_name = raw_args[0]
        project_path = File.join(Dir.pwd, project_name)

        result = Actions::FileActions.generate_project_dir(project_path)
        if result[0] == 0 || result[0] == 1
          begin
            Dir.chdir(project_path) 
          rescue Errno::EACCES 
            $stderr.puts CLI::error('Could not access project directory, permission denied, aborting', :symbol)
            exit(Scratch::NO_PREMISSION_ERROR)
          end
        end

        case result[0]
        when 0 
          puts CLI::info("#{project_name} already exists, using it")
        when 1 
          puts CLI::success("Created #{project_name} directory")
        when Scratch::NO_PREMISSION_ERROR
          $stderr.puts CLI::error("Can not create #{project_name}, permission denied")
        when Scratch::UNKNOWN_ERROR
          $stderr.puts CLI::error("Unknown error: #{result[1].message}")
        end # case result
        
        exit(result[0]) if result[0] < 0

        result = Actions::FileActions.copy_templates
        case result[0]
          when 0,1
            puts CLI::info("#{project_name} is ready for you. Enjoy")
            exit(0)
          when Scratch::NO_PREMISSION_ERROR
            $stderr.puts CLI::error("Permission Error, aborting", :symbol)
          when Scratch::UNKNOWN_ERROR
            $stderr.puts CLI::error("Unknown error: #{result[1].message}, aborting", :symbol)
          when Scratch::FILE_NOT_FOUND
            $stderr.puts CLI::error("Template file was not found, aborting", :smybol)
          when Scratch::SELF_COPY_FILE
            $stderr.puts CLI::error("Cannot copy file to itself, aborting", :smybol)
        end

        exit(result[0])
      end

      def self.test(raw_args, args)
      end

      def self.publish(raw_args, args)
      end

    end # class Exec

  end # module Actions

end # module Scratch
