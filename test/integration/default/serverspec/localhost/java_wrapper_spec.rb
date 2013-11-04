require 'spec_helper'

describe 'Java wrapper' do
  it 'should have an init script' do
    expect(file('/etc/init.d/jetty')).to be_file
  end
  it 'should run as a service' do
    expect(service('jetty')).to be_enabled
    expect(service('jetty')).to be_running
  end
end