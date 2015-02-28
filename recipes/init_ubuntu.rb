#
# Cookbook Name:: mozilla-firefox-sync
# Recipe:: init_ubuntu
#
# Copyright 2015 computerlyrik, Christian Fischer
#
# All rights reserved - Do Not Redistribute
#
template '/etc/init/fx-sync-server.conf' do
  source 'upstart.conf.erb'
  variables(
      program_path: node['mozilla-firefox-sync']['server']['path']
  )
end

service 'fx-sync-server' do
  action [:start, :enable]
end
