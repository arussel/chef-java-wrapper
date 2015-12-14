package 'unzip'

include_recipe 'apt'
include_recipe 'java'

ark 'jetty' do
  url 'http://archive.eclipse.org/jetty/9.2.11.v20150529/dist/jetty-distribution-9.2.11.v20150529.tar.gz'
end

java_wrapper 'jetty' do
  app_parameters ['org.eclipse.jetty.start.Main']
  classpath ['/usr/local/jetty/start.jar']
  java_parameters ['-Djetty.home=/usr/local/jetty']
  wrapper_working_dir '/usr/local/jetty'
  log_file_name 'jetty.log'
  # wrapper_version '3.5.27' # override if you don't want the default 3.5.21
  action [:remove, :create, :enable, :start]
end
