require 'yaml'

module Pod
  class Command
    # This is an example of a cocoapods plugin adding a top-level subcommand
    # to the 'pod' command.
    #
    # You can also create subcommands of existing or new commands. Say you
    # wanted to add a subcommand to `list` to show newly deprecated pods,
    # (e.g. `pod list deprecated`), there are a few things that would need
    # to change.
    #
    # - move this file to `lib/pod/command/list/deprecated.rb` and update
    #   the class to exist in the the Pod::Command::List namespace
    # - change this class to extend from `List` instead of `Command`. This
    #   tells the plugin system that it is a subcommand of `list`.
    # - edit `lib/cocoapods_plugins.rb` to require this file
    #
    # @todo Create a PR to add your plugin to CocoaPods/cocoapods.org
    #       in the `plugins.json` file, once your plugin is released.
    #
    class Label < Command
      self.summary = 'Short description of cocoapods-label.'

      self.description = <<-DESC
        Longer description of cocoapods-label.
      DESC

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

        podfile.dependencies.each do |dependency|
          sources.each do |source|
            next if source.versions(dependency.name).nil?
            spec = source.set(dependency.name).specification
            puts spec.name + ' ' + spec.summary
          end
        end

        File.open(podfile_path, 'w') { |file| file.write(podfile.to_yaml) }
      end
    end
  end
end
