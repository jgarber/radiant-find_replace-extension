namespace :radiant do
  namespace :extensions do
    namespace :find_replace do
      
      desc "Runs the migration of the Find And Replace extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          FindReplaceExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          FindReplaceExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Find And Replace to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        puts "Copying assets from FindReplaceExtension"
        Dir[FindReplaceExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(FindReplaceExtension.root, '')
          directory = File.dirname(path)
          mkdir_p RAILS_ROOT + directory, :verbose => false
          cp file, RAILS_ROOT + path, :verbose => false
        end
      end  
    end
  end
end
