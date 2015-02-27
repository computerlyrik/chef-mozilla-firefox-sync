#
# Cookbook Name:: mozilla-sync
# Atributes:: default
#
# Copyright 2014, computerlyrik, Christian Fischer
#
# All rights reserved - Do Not Redistribute
#

default['mozilla-sync']['repository'] = 'https://github.com/mozilla-services/syncserver'

default['mozilla-sync']['target_dir'] = '/mozilla-sync'
default['mozilla-sync']['auth_secret'] = nil
default['mozilla-sync']['certificate_databag_id'] = 'wildcard'
default['mozilla-sync']['ssl_certificate'] = "/etc/nginx/ssl/certs/#{node['fqdn']}.pem"
default['mozilla-sync']['ssl_certificate_key'] = "/etc/nginx/ssl/private/#{node['fqdn']}.key"

default['mozilla-sync']['logfile'] = '/var/log/mozilla-sync.log'
default['mozilla-sync']['allow_new_users'] = false

default['mozilla-firefox-sync']['server']['path'] = '/srv/fx/sync-server'
default['mozilla-firefox-sync']['server']['version'] = 'c4c0fa033aeb08646008e4969519619178d4a12b'
