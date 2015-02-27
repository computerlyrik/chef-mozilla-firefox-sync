#
# Cookbook Name:: mozilla-sync
# Atributes:: default
#
# Copyright 2014, computerlyrik, Christian Fischer
#
# All rights reserved - Do Not Redistribute
#

default['mozilla-firefox-sync']['server']['path'] = '/srv/fx/sync-server'
default['mozilla-firefox-sync']['server']['version'] = 'c4c0fa033aeb08646008e4969519619178d4a12b'

default['mozilla-firefox-sync']['repository'] = 'https://github.com/mozilla-services/syncserver'

default['mozilla-firefox-sync']['auth_secret'] = nil
default['mozilla-firefox-sync']['certificate_databag_id'] = 'wildcard'
default['mozilla-firefox-sync']['ssl_certificate'] = "/etc/nginx/ssl/certs/#{node['fqdn']}.pem"
default['mozilla-firefox-sync']['ssl_certificate_key'] = "/etc/nginx/ssl/private/#{node['fqdn']}.key"

default['mozilla-firefox-sync']['logfile'] = '/var/log/mozilla-sync.log'
default['mozilla-firefox-sync']['allow_new_users'] = false


