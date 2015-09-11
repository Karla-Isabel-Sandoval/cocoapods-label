require File.expand_path('../../spec_helper', __FILE__)

module Pod
  describe Command::Label do
    describe 'CLAide' do
      it 'registers it self' do
        Command.parse(%w{ label }).should.be.instance_of Command::Label
      end
    end

    describe 'write labels to the podfile' do
    	it 'writes labels to Podfile' do
    	  FileUtils.cp Fixture_path + 'Podfile',
          Pathname.new(Dir.tmpdir) + 'Podfile'
        Dir.chdir(Dir.tmpdir)
        Command.parse(%w{ label }).run
        FileUtils.compare_file("CocoaPods.podfile.yaml",
          Fixture_path + "CocoaPods.podfile.yaml" ).should == true
      end
    end
  end
end
