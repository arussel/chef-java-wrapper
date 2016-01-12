java-wrapper CHANGELOG
======================

This file is used to list changes made in each version of the java-wrapper cookbook.

1.2.1
-----
- Fixed Travis Build

1.2.0
-----
- Added cookbook attribute that disables file logging ( arussel/chef-java-wrapper#10 )
- Fixed warning about version incompatibility (arussel/chef-java-wrapper#9)

1.1.0
-----
- Added LWRP parameter for wrapper.console.flush

1.0.1
-----
- Fixed broken tests (due to changed URL for jetty download)
- Fixed native_library extraction feature (wrong predicate)
- Added chefspec unit tests

1.0.0
-----
- Build passes on Travis CI, using Test Kitchen with kitchen-ec2 driver for IT tests using serverspec.
- fixed rubocop and foodcritic warnings

0.6.0
-----
- Made test kitchen pass again, on both ubuntu 12.04 and ubuntu 14.04
- separated enable & start actions for resource
- Fixed missing run_as_user attribute

0.5.0
-----
- @gsaslis - Added configurable exit.timeout and startup.timeout. Also added .use_system_time=false and .request_thread_dump_on_failed_jvm_exit=TRUE as hard-coded values for now.

0.4.0
-----
- @gsaslis - Added support for wrapper.daemonize and parameterizable console name

0.3.0
-----
- @gsaslis - Bugfix: remove hard-coded path of /etc/init.d as location of executable wrapper file
- @gsaslis - Add new capability of being able to extract native library as well upon setting an extra option


0.2.0
-----
- @gsaslis - Separated Create & Enable Actions, so you can now create, without enabling the service.
- @gsaslis - Added a customizable log file name
- @gsaslis - The wrapper.conf file name will now match your app name, so you can have multiple instances of the java wrapper configs, even in the same directory.
- @gsaslis - The wrapper_url ignored version, so I've made it parameterizable, meaning you can now choose what wrapper version to install.
- @gsaslis - Added owner and group attributes for filesystem permissions to the files & dirs


0.0.1
-----
- arussel - Initial release of java-wrapper

- - -
Check the [Markdown Syntax Guide](http://daringfireball.net/projects/markdown/syntax) for help with Markdown.

The [Github Flavored Markdown page](http://github.github.com/github-flavored-markdown/) describes the differences between markdown on github and standard markdown.
