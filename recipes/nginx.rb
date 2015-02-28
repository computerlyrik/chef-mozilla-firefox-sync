#
# Cookbook Name:: mozilla-firefox-sync
# Recipe:: nginx
#
# Copyright 2015, computerlyrik, Christian Fischer
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'nginx'

certificate_manage 'mozilla-firefox-sync' do
  search_id node['mozilla-firefox-sync']['certificate_databag_id']
  cert_path '/etc/nginx/ssl'
  nginx_cert true
  not_if { node['mozilla-firefox-sync']['certificate_databag_id'].nil? }
end

template '/etc/nginx/sites-available/syncserver' do
  owner 'root'
  group 'root'
  mode '0644'
  source 'nginx.syncserver.erb'
  notifies :restart, 'service[nginx]'
  variables(
      server_name: node['fqdn'],
      ssl_certificate: node['mozilla-firefox-sync']['ssl_certificate'],
      ssl_certificate_key: node['mozilla-firefox-sync']['ssl_certificate_key']
  )
end

nginx_site 'syncserver' do
  enable true
end

# Disable default site
nginx_site 'default' do
  enable false
end

# program_path: node['mozilla-firefox-sync']['server']['path']

