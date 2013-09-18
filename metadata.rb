name             'java-wrapper'
maintainer       'Alexandre Russel'
maintainer_email 'alexandre@russel.fr'
license          'Apache 2.0'
description      'Installs/Configures java-wrapper'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.1'

attribute 'java-wrapper/app_name',
  :display_name => "Name of the application",
  :description  => "The name of the application (use to create a directory)",
  :type         => "string",
  :required     => "required"

attribute 'java-wrapper/libs_dir',
  :display_name => "Libraries directory",
  :description  =>  "A directory that contains all the libraries for the application",
  :type         => "string",
  :required     => "required"
