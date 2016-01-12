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
      action: [:install]
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

  it 'creates /opt/jetty/conf/jetty.conf' do
    expect(chef_run).to create_template('/opt/jetty/conf/jetty.conf').with(
      owner: 'root',
      group: 'root',
      variables: {
        init_mem_MB: '3',
        max_mem_MB: '64',
        java_parameters: ['-Djetty.home=/usr/local/jetty'],
        log_file_path: '/var/log/jetty',
        log_file_name: 'jetty.log',
        wrapper_working_dir: '/usr/local/jetty',
        classpath: ['/usr/local/jetty/start.jar'],
        app_parameters: ['org.eclipse.jetty.start.Main'],
        daemonize: 'true',
        exit_timeout: '15',
        startup_timeout: '30',
        native_library_dest_dir: '',
        console_flush: 'TRUE',
        app_long_name: nil }
    )
  end

  it 'creates conf file /opt/jetty/bin/jetty' do
    expect(chef_run).to create_template('/opt/jetty/bin/jetty').with(
      owner: 'root',
      group: 'root'
    )
  end
end
