require 'chefspec'
require 'chefspec/berkshelf'

describe 'java_wrapper::default' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  # it 'create directory structure' do
  #   expect(chef_run).to create_directory('/opt/java-wrapped-app/bin')
  # end
end
