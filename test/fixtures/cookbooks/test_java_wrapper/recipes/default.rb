package 'unzip'

include_recipe 'apt'
include_recipe 'java'

ark 'jetty' do
  url 'http://download.eclipse.org/jetty/stable-9/dist/jetty-distribution-9.2.11.v20150529.tar.gz'
end

java_wrapper 'jetty' do
  app_parameters ["org.eclipse.jetty.start.Main"]
  classpath ["/usr/local/jetty/start.jar"]
  java_parameters ["-Djetty.home=/usr/local/jetty"]
  native_library_dest_dir "/usr/local/java_wrapper/lib"
  action [:create, :enable, :start]
end

java_wrapper 'play' do
  classpath ["#{helloworld_dir}/target/staged/*"]
  app_parameters ["play.core.server.NettyServer", "#{helloworld_dir}"]
  java_parameters ["-Dhttp.port=9001"]
end
