#
# Cookbook Name:: java_wrapper
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
def whyrun_supported?
  true
end

action :create do
  create_app_with_wrapper

  # My state has changed so I'd better notify observers
  new_resource.updated_by_last_action(true)
end
action :enable do
  deploy_app_with_wrapper

  # My state has changed so I'd better notify observers
  new_resource.updated_by_last_action(true)
end
action :start do
  start_app_with_wrapper

  # My state has changed so I'd better notify observers
  new_resource.updated_by_last_action(true)
end
action :remove do
  remove_app_with_wrapper

  # My state has changed so I'd better notify observers
  new_resource.updated_by_last_action(true)
end

def extract_native_lib
  # copy the native library to specified folder
  return if new_resource.native_library_dest_dir.empty?

  filename = case new_resource.wrapper_os
             when 'linux'
               'libwrapper.so'
             when 'windows'
               'wrapper.dll'
             when 'osx'
               'libwrapper.jnilib'
             end

  ark 'java_wrapper_native_lib' do
    url "http://download.tanukisoftware.com/wrapper/#{new_resource.wrapper_version}/wrapper-#{new_resource.wrapper_os}-"\
      "#{new_resource.wrapper_cpu}-#{new_resource.wrapper_bit}-#{new_resource.wrapper_version}.#{new_resource.wrapper_extension}"
    action :cherry_pick
    path new_resource.native_library_dest_dir
    creates "wrapper-#{new_resource.wrapper_os}-#{new_resource.wrapper_cpu}-#{new_resource.wrapper_bit}-"\
      "#{new_resource.wrapper_version}/lib/#{filename}"
  end
end

def create_conf_files
  template "#{new_resource.conf_dir}/#{new_resource.app_name}.conf" do
    source 'wrapper.conf.erb'
    cookbook 'java_wrapper'
    variables(
      init_mem_MB: new_resource.init_mem_MB,
      max_mem_MB: new_resource.max_mem_MB,
      java_parameters: new_resource.java_parameters,
      log_file_path: new_resource.logs_dir,
      log_file_name: new_resource.log_file_name,
      wrapper_working_dir: new_resource.wrapper_working_dir,
      classpath: new_resource.classpath,
      app_parameters: new_resource.app_parameters,
      daemonize: new_resource.daemonize,
      exit_timeout: new_resource.exit_timeout,
      startup_timeout: new_resource.startup_timeout,
      native_library_dest_dir: new_resource.native_library_dest_dir,
      console_flush: new_resource.console_flush,
      app_long_name: new_resource.app_long_name
    )
    owner new_resource.permissions_owner
    group new_resource.permissions_group
  end

  template "#{new_resource.bin_dir}/#{new_resource.app_name}" do
    source 'sh.script.erb'
    mode 0755
    cookbook 'java_wrapper'
    variables(
      app_name: new_resource.app_name,
      app_long_name: new_resource.app_long_name,
      java_wrapper_bin_dir: "#{node['ark']['prefix_root']}/#{new_resource.java_wrapper_dir}/bin",
      conf_dir: new_resource.conf_dir,
      run_as_user: new_resource.run_as_user,
      wrapper_version: new_resource.wrapper_version,
      bin_dir: new_resource.bin_dir
    )
    owner new_resource.permissions_owner
    group new_resource.permissions_group
  end
end

def create_app_with_wrapper
  [new_resource.bin_dir, new_resource.conf_dir, new_resource.lib_dir, new_resource.logs_dir].each do |dir|
    directory dir do
      owner new_resource.permissions_owner
      group new_resource.permissions_group
      mode 0755
      recursive true
      action :create
    end
  end

  ark 'java_wrapper' do
    url "http://download.tanukisoftware.com/wrapper/#{new_resource.wrapper_version}/wrapper-#{new_resource.wrapper_os}-"\
      "#{new_resource.wrapper_cpu}-#{new_resource.wrapper_bit}-#{new_resource.wrapper_version}.#{new_resource.wrapper_extension}"
  end

  create_conf_files

  extract_native_lib
end

def deploy_app_with_wrapper
  execute 'install app as service' do
    cwd new_resource.bin_dir
    user 'root'
    command "#{new_resource.bin_dir}/#{new_resource.app_name} install"
    creates '/etc/init.d/jetty'
  end
end

def remove_app_with_wrapper
  return unless Dir.exist?(new_resource.bin_dir)
  execute 'remove app from service' do
    cwd new_resource.bin_dir
    user 'root'
    command "#{new_resource.bin_dir}/#{new_resource.app_name} remove"
  end
end

def start_app_with_wrapper
  service new_resource.app_name do
    supports restart: true, status: true
    action :start
  end
end
