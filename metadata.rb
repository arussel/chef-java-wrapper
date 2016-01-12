name 'java_wrapper'
maintainer 'Alexandre Russel'
maintainer_email 'alexandre@russel.fr'
license 'Apache 2.0'
description 'Library cookbook that exposes the java_wrapper LWRP for Installing / Configuring java_wrapper on a server.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.2.0'
depends 'ark'

supports 'ubuntu', '= 12.04'
supports 'ubuntu', '= 14.04'
supports 'opensuse', '= 13.1'
supports 'opensuse', '= 13.2'
