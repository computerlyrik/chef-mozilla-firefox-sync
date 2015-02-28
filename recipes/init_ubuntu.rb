#
# Cookbook Name:: mozilla-firefox-sync
# Recipe:: init_ubuntu
#
# Copyright 2015 computerlyrik, Christian Fischer
#
# All rights reserved - Do Not Redistribute
#
template '/etc/init/fx-sync-server.conf' do
  source 'upstart-sync-server.conf.erb'
end

service 'fx-sync-server' do
  action [:start, :enable]
end
