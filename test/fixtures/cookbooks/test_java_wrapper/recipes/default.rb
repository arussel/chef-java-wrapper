package 'unzip'

include_recipe 'apt'
include_recipe 'java'

ark 'jetty' do
  url 'http://central.maven.org/maven2/org/mortbay/jetty/jetty/6.1.3/jetty-6.1.3.jar'
end

include_recipe 'play2'

#normally, we would fetch a dist zipped from somewhere
#and unzip it. To test we're just building a sample project
#from play directory
helloworld_dir = "/usr/local/play/play-2.1.3/samples/scala/helloworld"
bash "create play project" do
  cwd "#{helloworld_dir}"
  user 'root'
  code "/usr/local/play/play-2.1.3/play stage"
end

java_wrapper 'jetty' do
  app_parameters ["org.mortbay.start.Main"]
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
