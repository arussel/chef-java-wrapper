actions :create
default_action :create

attribute :app_name, :kind_of => String
attribute :app_long_name, :kind_of => String
attribute :app_dir,  :kind_of => String
attribute :bin_dir,  :kind_of => String
attribute :lib_dir,  :kind_of => String
attribute :conf_dir, :kind_of => String
attribute :logs_dir, :kind_of => String
attribute :init_mem_MB, :kind_of => String, :default => "3"
attribute :max_mem_MB, :kind_of => String, :default => "64"
attribute :java_parameters, :kind_of => Array, :default => []
attribute :log_file_path, :kind_of => String
attribute :classpath, :kind_of => Array, :default => []
attribute :app_parameters, :kind_of => Array, :default => []
attribute :run_as_user, :kind_of => String, :default => "root"

def initialize(*args)
  super
  @app_name ||= @name
  @app_dir  ||= "/opt/#{@name}"
  @bin_dir  ||= "#{@app_dir}/bin"
  @lib_dir  ||= "#{@app_dir}/lib"
  @conf_dir ||= "#{@app_dir}/conf"
  @logs_dir ||= "/var/log/#{@name}"
end