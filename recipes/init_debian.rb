#
# Cookbook Name:: mozilla-firefox-sync
# Recipe:: init_debian
#
# Copyright 2015 computerlyrik, Christian Fischer
#
# All rights reserved - Do Not Redistribute
#
cmd = "#{node['mozilla-firefox-sync']['server']['path']}/local/bin/pserve #{node['mozilla-firefox-sync']['server']['path']}/syncserver.ini"
start_cmd = "#{cmd} --daemon --log-file=#{node['mozilla-firefox-sync']['logfile']}"
stop_cmd = "#{cmd} --stop-daemon"

service 'fx-sync-server' do
  start_command start_cmd
  stop_command stop_cmd
  reload_command "#{cmd} --reload"
  restart_command "#{stop_cmd} || true && #{start_cmd}"
  supports start: true, stop: true, reload: true
  action :start
end
