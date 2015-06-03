require 'spec_helper'

describe 'Java wrapper' do
  it 'should have an init script' do
    expect(file('/opt/jetty/bin/jetty')).to be_file
  end
  it 'should run as a service' do
    expect(service('jetty')).to be_enabled
    expect(service('jetty')).to be_running
  end
  it 'should be listening' do
    expect(port('8080')).to be_listening
  end
end