# deployments attributes
default["java_wrapper"]["app_name"]      = "java-wrapped-app"
default["java_wrapper"]["app_long_name"] = "#{node['java_wrapper']['app_name']}"
default["java_wrapper"]["install_dir"]   = "/opt/#{node['java_wrapper']['app_name']}"
default["java_wrapper"]["bin_dir"]       = "#{node['java_wrapper']['install_dir']}/bin"
default["java_wrapper"]["conf_dir"]      = "#{node['java_wrapper']['install_dir']}/conf"
default["java_wrapper"]["lib_dir"]       = "#{node['java_wrapper']['install_dir']}/lib"
default["java_wrapper"]["tmp_dir"]       = "#{node['java_wrapper']['install_dir']}/tmp"
default["java_wrapper"]["logs_dir"]      = "/var/log/#{node['java_wrapper']['app_name']}"

# wrapper configuration attributes
default["java_wrapper"]["init_mem_MB"] = "3"
default["java_wrapper"]["max_mem_MB"] = "64"
default["java_wrapper"]["java_parameters"] = []
default["java_wrapper"]["app_parameters"] = []
default["java_wrapper"]["classpath"] = []
default['java_wrapper']['run_as_user'] = "root"

