#
# Cookbook Name:: sync-1.5
# Atributes:: default
#
# Copyright 2014, computerlyrik, Christian Fischer
#
# All rights reserved - Do Not Redistribute
#

default['sync-1.5']['repository'] = "https://github.com/mozilla-services/syncserver"

default['sync-1.5']['target_dir'] = "/sync-1.5"
default['sync-1.5']['auth_secret'] = nil
default['sync-1.5']['certificate_databag_id'] = "wildcard"
default['sync-1.5']['ssl_certificate'] = "/etc/nginx/ssl/certs/#{node['fqdn']}.pem"
default['sync-1.5']['ssl_certificate_key'] = "/etc/nginx/ssl/private/#{node['fqdn']}.key"

