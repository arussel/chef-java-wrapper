java_wrapper 'jetty' do
  native_library_dest_dir '/usr/local/java_wrapper/lib'
  # wrapper_version '3.5.27' # override if you don't want the default 3.5.21
  action [:create]
end
