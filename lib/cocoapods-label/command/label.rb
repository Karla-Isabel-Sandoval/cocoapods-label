require 'yaml'

module Pod

  class Command

    class Label < Command
      self.summary = 'annotate your podfile with descriptions for each pod .'


      def initialize(argv)
        super

        @config = Pod::Config.instance
      end

      def podfile_path
        @config.podfile_path_in_dir(Pathname.new(Dir.pwd))
      end

      def validate!
        super

        help! 'No Podfile found.' unless File.exist?(podfile_path)
      end

      def run

        podfile = Pod::Podfile.from_file(podfile_path)
        sources = podfile.sources.map { |src| Pod::SourcesManager.find_or_create_source_with_url(src) }
        sources = Pod::SourcesManager.all if sources.empty?

        File.unlink(podfile_path)
        File.open('CocoaPods.podfile.yaml', 'w') { |file| file.write(podfile.to_yaml) }
        content = File.read("CocoaPods.podfile.yaml")
        podfile.dependencies.each do |dependency|
          sources.each do |source|
            next if source.versions(dependency.name).nil?
            spec = source.set(dependency.name).specification
            content = content.gsub(/(^.*)(- #{spec.name})/, "\\1# #{spec.summary}\n\\1\\2")

          end
        end
        File.open('CocoaPods.podfile.yaml', 'w') { |file| file.write(content) }
      end
    end
  end
end
