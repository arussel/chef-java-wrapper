java_wrapper Cookbook
=====================

### Status
[![Build Status](https://travis-ci.org/gsaslis/chef-java-wrapper.svg?branch=master)](https://travis-ci.org/gsaslis/chef-java-wrapper)

Overview
========
This cookbook provides `java_wrapper`, a resource that wrap a java application
to be easily managed using start up scripts. It uses http://wrapper.tanukisoftware.com/.

Requirements
============
This cookbook has only be tested on linux system. Tanuki java wrapper works on
Windows system, but considering this cookbook has never been tested on Windows,
it most likely not work.

Attribute Parameters
----------
Customize the attributes to suit your need, the following attributes
have to be provided:

- `app_name`: the name of the application, if not provided, it uses the name of the resource.
- `classpath`: the classpath of the application
- `app_parameters`: the array of String that will be passed to the application
- `java_parameters`: The array of java parameters
- `log_file_name`: the file name where the logs will be stored. Use something relevant to your app_name, to make it clear what log you're readind.
- `wrapper_working_dir`: configuring the Working Directory.

This attributes can be used to further customize the application:
- `app_long_name`: the long name used for the daemon
- `app_dir`: the directory in which the application is deployed, it defaults to `/opt/#{app_name}`
- `bin_dir`: the bin directory for the wrapper, it defaults to `#{app_dir}/bin`
- `lib_idr`: the lib directory for the wrapper, it defaults to `#{app_dir}/lib`
- `conf_dir`: the conf directory for the wrapper, it defaults to `#{app_dir}/conf`
- `daemonize`: Spawns a fork of the Wrapper process as a detached non-session group leader. This means that the process will continue to run even after the console from which the Wrapper process was launched has been closed.
- `exit_timeout`: the timeout the wrapper allows to the app for termination, in seconds. (defaults to 15).
- `library_path`: an array of paths, where the wrapper will look for (Wrapper.DLL or libwrapper.so)
- `logs_dir`: the log directory for the wrapper, it defaults to `/var/log/#{name}`
- `init_mem_MB`: the mininum memory in MB for the JVM, defaults to 3
- `max_mem_MB`: the maximum memory in MB for the JVM, defaults to 64
- `native_library_dest_dir`: convenience parameter for copying the native library to this folder
- `console_flush`: Configures the output sent to the console to be completely flushed (TRUE / FALSE). False by default.
- `permissions_owner`: the system user who will be the owner of directories and files.
- `permissions_group`: the system group to which the directories and files will belong.
- `run_as_user`: the user running the wrapper, defaults to root
- `startup_timeout`: the timeout the wrapper allows between the time that the Wrapper launches the JVM process and the time that the JVM side of the Wrapper responds that the application has started. Setting this property value to "0" (zero) means never time out. The value is in seconds. (defaults to 30).
- `wrapper_version`: the version of the java wrapper, defaults to 3.5.21
- `wrapper_os`: the os for the java wrapper, defaults to linux
- `wrapper_cpu`: the cpu for the java wrapper, defaults to x86
- `wrapper_bit`: the architecture for the java wrapper, defaults to 64
- `wrapper_extension`: the extension for the java wrapper, defaults to tar.gz
- `wrapper_url`: the url to download the wrapper, defaults to "http://download.tanukisoftware.com/wrapper/#{wrapper_version}/wrapper-#{wrapper_os}-#{wrapper_cpu}-#{wrapper_bit}-#{wrapper_version}.#{wrapper_extension}"
- `file_logging_enabled`: cause file logging to be disabled if set to false. Boolean. True by default.

Usage
-----
You will find usage in the test recipe at https://github.com/arussel/chef-java-wrapper/blob/master/test/fixtures/cookbooks/java_wrapper_test/recipes/default.rb

java_wrapper 'jetty' do
  app_parameters ["org.mortbay.start.Main"]
  classpath ["/usr/local/jetty/start.jar"]
  java_parameters ["-Djetty.home=/usr/local/jetty"]
end

java_wrapper 'play' do
  classpath ["#{helloworld_dir}/target/staged/*"]
  app_parameters ["play.core.server.NettyServer", "#{helloworld_dir}"]
  java_parameters ["-Dhttp.port=9001"]
end

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Alexandre Russel, Yorgos Saslis
