name              'mozilla-sync'
maintainer        'computerlyrik, Christian Fischer'
maintainer_email  'chef-cookbooks@computerlyrik.de'
license           'All rights reserved'
description       'Installs/Configures sync-1.5'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           '0.1.0'

depends 'nginx'
depends 'certificate'

supports 'debian'
