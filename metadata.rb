name             'java_wrapper'
maintainer       'Alexandre Russel'
maintainer_email 'alexandre@russel.fr'
license          'Apache 2.0'
description      'Installs/Configures java_wrapper'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.5.0'
depends			 'ark'

recipe "java_wrapper", "Wrap a java application"
