#
# Cookbook Name:: java-wrapper
# Recipe:: default
#
# Copyright 2013, Alexandre Russel
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

["#{node['java_wrapper']['bin_dir']}", "#{node['java_wrapper']['conf_dir']}", "#{node['java_wrapper']['lib_dir']}", "#{node['java_wrapper']['logs_dir']}", "#{node['java_wrapper']['tmp_dir']}"].each do |dir|
  directory "#{dir}" do
    recursive true
    action :create
  end
end

remote_file "#{node['java_wrapper']['tmp_dir']}/wrapper-linux-x86-64-3.5.20.tar.gz" do
  source "http://sourceforge.net/projects/wrapper/files/wrapper/Wrapper_3.5.20_20130625/wrapper-linux-x86-64-3.5.20.tar.gz/download"
end

bash "untar wrapper" do
  cwd "#{node['java_wrapper']['tmp_dir']}"
  code <<-EOH
  tar xzf #{node['java_wrapper']['tmp_dir']}/wrapper-linux-x86-64-3.5.20.tar.gz
  cp #{node['java_wrapper']['tmp_dir']}/wrapper-linux-x86-64-3.5.20/bin/wrapper #{node['java_wrapper']['bin_dir']}
  cp #{node['java_wrapper']['tmp_dir']}/wrapper-linux-x86-64-3.5.20/lib/wrapper.jar #{node['java_wrapper']['lib_dir']}
  EOH
end

template "#{node['java_wrapper']['conf_dir']}/wrapper.conf" do
  source "wrapper.conf.erb"
  variables ({
    :initMemMB => node["java_wrapper"]["initMemMB"],
    :maxMemMB  => node["java_wrapper"]["maxMemMB"],
    :javaParameters => node["java_wrapper"]["javaParameters"],
    :logFilePath => node["java_wrapper"]["logs_dir"]
  })
end

