
module Scratch 

  module Actions

    class FileActions
      require 'fileutils'

      @src = File.join($BASE_PATH, 'project_template')

      def self.scan_dir(path)
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

      def self.copy_templates
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
        puts CLI::success('Created skelaton directories')

      end # self.copy_templates

      def self.mkdir(dirs)
        FileUtils.mkdir_p(dirs)
        [1]
      rescue Errno::EACCES => e
        return [Scratch::NO_PREMISSION_ERROR, e]
      rescue => e
        $stderr.puts CLI::error("Unknown error while trying to copy file: #{e.message}")
        return [Scratch::UNKNOWN_ERROR, e]
      end # def self.mkdir(dirs)

      def self.copy_file(src, dest)
        FileUtils.cp(src, dest)
        [1]
      rescue Errno::ENOENT => e
        #$stderr.puts CLI::error("Could not copy file: #{e.message}")
        return [Scratch::FILE_NOT_FOUND, e]
      rescue Errno::EACCES => e
        #$stderr.puts CLI::error("Problem with permission while trying to copy #{e.message}")
        return [Scratch::NO_PREMISSION_ERROR, e]
      rescue ArgumentError => e
        #$stderr.puts CLI::error('Could not copy source to itself')
        return [Scratch::SELF_COPY_FILE, e]
      rescue => e
        #$stderr.puts CLI::error("Unknown error while trying to copy file: #{e.message}")
        return [Scratch::UNKNOWN_ERROR, e]
      end # def self.copy_file(src, dest)

      def self.generate_project_dir(project_path)

        return [0] if File.exists?(project_path)

        Dir.mkdir(project_path)
        return [1] # just to see it clear
      rescue Errno::EACCES
        return [Scratch::NO_PREMISSION_ERROR]
      rescue Errno::EEXIST # should never happen, but just in case
        return [0]
      rescue => e
        return [Scratch::UNKNOWN_ERROR, e]
      end

    end # class FileActions

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
          Dir.chdir(project_path) 
        end

        case result[0]
        when 0 
          puts CLI::info("#{project_name} already exists, using it")
        when 1 
          puts CLI::success("Created #{project_name}")
        when Scratch::NO_PREMISSION_ERROR
          $stderr.puts CLI::error("Can not create #{project_name}, permission denied")
        when Scratch::UNKNOWN_ERROR
          $stderr.puts CLI::error("Unknown error: #{result[1].message}")
        end # case result
        
        exit(result[0]) if result[0] < 0

        Actions::FileActions.copy_templates
      end

      def self.test(raw_args, args)
      end

      def self.publish(raw_args, args)
      end

    end # class Exec

  end # module Actions

end # module Scratch
