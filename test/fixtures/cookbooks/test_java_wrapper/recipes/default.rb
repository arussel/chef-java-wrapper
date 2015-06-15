package 'unzip'

include_recipe 'apt'
include_recipe 'java'

ark 'jetty' do
  url 'http://download.eclipse.org/jetty/9.2.11.v20150529/dist/jetty-distribution-9.2.11.v20150529.tar.gz'
end

java_wrapper 'jetty' do
  app_parameters ['org.eclipse.jetty.start.Main']
  classpath ['/usr/local/jetty/start.jar']
  java_parameters ['-Djetty.home=/usr/local/jetty']
  wrapper_working_dir '/usr/local/jetty'
  log_file_name 'jetty.log'
  native_library_dest_dir '/usr/local/java_wrapper/lib'
  action [:remove, :create, :enable, :start]
end
