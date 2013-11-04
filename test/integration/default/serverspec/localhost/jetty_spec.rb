require 'spec_helper'

describe 'Jetty installed' do
  it 'should have a jetty directory' do
    expect(file('/usr/local/jetty')).to be_directory
  end
end