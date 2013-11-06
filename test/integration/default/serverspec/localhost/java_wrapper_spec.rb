require 'spec_helper'

describe 'Java wrapper' do
  it 'should have an init script' do
    expect(file('/etc/init.d/jetty')).to be_file
    expect(file('/etc/init.d/play')).to be_file
  end
  it 'should run as a service' do
    expect(service('jetty')).to be_enabled
    expect(service('jetty')).to be_running
    expect(service('play')).to be_enabled
    expect(service('play')).to be_running
  end
  it 'should be listening' do
    expect(port('8080')).to be_listening
    expect(port('9001')).to be_listening
  end
end