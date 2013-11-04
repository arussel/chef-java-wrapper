actions :create
default_action :create

attribute :app_name, :kind_of => String
attribute :app_long_name, :kind_of => String
attribute :app_dir, :kind_of => String
attribute :bin_dir, :kind_of => String
attribute :lib_dir, :kind_of => String
attribute :conf_dir, :kind_of => String
attribute :logs_dir, :kind_of => String
attribute :init_mem_MB, :kind_of => String, :default => "3"
attribute :max_mem_MB, :kind_of => String, :default => "64"
attribute :java_parameters, :kind_of => Array, :default => []
attribute :classpath, :kind_of => Array, :default => []
attribute :app_parameters, :kind_of => Array, :default => []
attribute :run_as_user, :kind_of => String, :default => "root"
attribute :java_wrapper_dir, :kind_of => String, :default => "java_wrapper"
attribute :wrapper_version, :kind_of => String, :default => "3.5.21"
attribute :wrapper_os, :kind_of => String, :default => "linux"
attribute :wrapper_cpu, :kind_of => String, :default => "x86"
attribute :wrapper_bit, :kind_of => String, :default => "64"
attribute :wrapper_extension, :kind_of => String, :default => "tar.gz"
attribute :wrapper_url, :kind_of => String

def initialize(*args)
  super
  @app_name ||= @name
  @app_dir ||= "/opt/#{@name}"
  @bin_dir ||= "#{@app_dir}/bin"
  @lib_dir ||= "#{@app_dir}/lib"
  @conf_dir ||= "#{@app_dir}/conf"
  @logs_dir ||= "/var/log/#{@name}"
  @wrapper_url ||= "http://wrapper.tanukisoftware.com/download/#{wrapper_version}/wrapper-#{wrapper_os}-#{wrapper_cpu}-#{wrapper_bit}-#{wrapper_version}.#{wrapper_extension}"
end