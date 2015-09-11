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
    		FileUtils.cp fixture_path + 'Podfile', Dir.tmpdir() + 'Podfile'
    	end
    end
  end
end

