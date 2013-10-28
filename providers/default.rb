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
  deploy_app_with_wrapper
end

def deploy_app_with_wrapper
  [new_resource.bin_dir, new_resource.conf_dir, new_resource.lib_dir, new_resource.logs_dir].each do |dir|
    directory "#{dir}" do
      recursive true
      action :create
    end
  end

  remote_file "/tmp/wrapper-linux-x86-64-3.5.20.tar.gz" do
    action :create_if_missing
    source "http://sourceforge.net/projects/wrapper/files/wrapper/Wrapper_3.5.20_20130625/wrapper-linux-x86-64-3.5.20.tar.gz/download"
  end

  bash "untar wrapper" do
    cwd "/tmp"
    creates "/tmp/wrapper-linux-x86-64-3.5.20"
    code "tar xzf wrapper-linux-x86-64-3.5.20.tar.gz"
  end

  bash "cp wrapper files" do
    cwd "#{new_resource.app_dir}"
    code <<-EOH
  cp /tmp/wrapper-linux-x86-64-3.5.20/bin/wrapper #{new_resource.bin_dir}
  cp /tmp/wrapper-linux-x86-64-3.5.20/lib/* #{new_resource.lib_dir}
    EOH
  end

  template "#{new_resource.conf_dir}/wrapper.conf" do
    source "wrapper.conf.erb"
    cookbook "java_wrapper"
    variables ({
        :init_mem_MB => new_resource.init_mem_MB,
        :max_mem_MB => new_resource.max_mem_MB,
        :java_parameters => new_resource.java_parameters,
        :log_file_path => new_resource.log_file_path,
        :classpath => new_resource.classpath,
        :app_parameters => new_resource.app_parameters
    })
  end

  template "/etc/init.d/#{new_resource.app_name}" do
    source "sh.script.erb"
    mode 0744
    cookbook "java_wrapper"
    variables ({
        :app_name => new_resource.app_name,
        :app_long_name => new_resource.app_long_name,
        :bin_dir => new_resource.bin_dir,
        :conf_dir => new_resource.conf_dir,
        :run_as_user => new_resource.run_as_user
    })
  end
  service "#{new_resource.app_name}" do
    action [:enable, :start]
  end

end
