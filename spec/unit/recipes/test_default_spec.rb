require 'chefspec'
require 'chefspec/berkshelf'

describe 'java_wrapper_test::default' do
  # context 'On ' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(step_into: ['java_wrapper']) do |node|
      node.set['a']['var']['here'] = ''
    end.converge(described_recipe)
  end

  it 'uses ark to download java wrapper archive' do
    expect(chef_run).to install_ark('java_wrapper').with(
      url: 'http://wrapper.tanukisoftware.com/download/3.5.21/wrapper-linux-x86-64-3.5.21.tar.gz',
      action: :install
    )
  end

  it 'creates directory structure' do
    %w(
      /opt/jetty/bin
      /opt/jetty/lib
      /opt/jetty/conf
      /var/log/jetty
    ).each do |dir|
      expect(chef_run).to create_directory(dir).with(
        owner: 'root',
        group: 'root',
        mode: 0755,
        recursive: true,
        action: [:create]
      )
    end
  end

  it 'creates app_name.conf' do
    %w(
      /opt/jetty/conf/jetty.conf
      /opt/jetty/bin/jetty
    ).each do |file|
      expect(chef_run).to create_template(file).with(
        owner: 'root',
        group: 'root'
      )
    end
  end
end
