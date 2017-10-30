require 'chefspec'
require 'chefspec/berkshelf'

describe 'java_wrapper_test::native_lib' do
  # context 'On ' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(step_into: ['java_wrapper']) do |node|
      node.set['a']['var']['here'] = ''
    end.converge(described_recipe)
  end

  it 'extracts native library' do
    expect(chef_run).to cherry_pick_ark('java_wrapper_native_lib').with(
      url: 'http://download.tanukisoftware.com/wrapper/3.5.21/wrapper-linux-x86-64-3.5.21.tar.gz',
      action: [:cherry_pick],
      path: '/usr/local/java_wrapper/lib',
      creates: 'wrapper-linux-x86-64-3.5.21/lib/libwrapper.so'
    )
  end
  # end
end
