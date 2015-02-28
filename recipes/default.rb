#
# Cookbook Name:: mozilla-firefox-sync
# Recipe:: default
#
# Copyright 2014, 2015 computerlyrik, Christian Fischer
#
# All rights reserved - Do Not Redistribute
#
require 'chef/shell_out'

include_recipe 'git'
include_recipe 'nodejs'

package 'python-dev'
package 'make'
package 'python-virtualenv'

directory node['mozilla-firefox-sync']['server']['path'] do
  recursive true
end

git node['mozilla-firefox-sync']['server']['path'] do
  repository node['mozilla-firefox-sync']['repository']
  revision node['mozilla-firefox-sync']['server']['version']
  action :checkout
  notifies :run, 'bash[build_source]', :immediately
end

bash 'build_source' do
  code 'make build'
  cwd node['mozilla-firefox-sync']['server']['path']
  action :nothing
  notifies :run, 'bash[install_gunicorn]', :immediately
end

bash 'install_gunicorn' do
  code './local/bin/easy_install gunicorn'
  cwd node['mozilla-firefox-sync']['server']['path']
  action :nothing
end

ruby_block 'create_random' do
  begin
    cmd = Mixlib::ShellOut.new('head -c 20 /dev/urandom | sha1sum  | rev | cut -c 4- | rev')
    cmd.run_command
    node.set_unless['mozilla-firefox-sync']['auth_secret'] = cmd.stdout
  end
  only_if { node['mozilla-firefox-sync']['auth_secret'].nil? }
end

template "#{node['mozilla-firefox-sync']['server']['path']}/syncserver.ini" do
  variables(
      public_url: "https://#{node['fqdn']}",
      db_dir: node['mozilla-firefox-sync']['target_dir'],
      secret: node['mozilla-firefox-sync']['auth_secret'],
      allow_new_users: node['mozilla-firefox-sync']['allow_new_users']
  )
  notifies :reload, 'service[sync]', :delayed
end

case node['platform']
when 'ubuntu'
  include_recipe 'mozilla-firefox-sync::init_ubuntu'
when 'debian'
  include_recipe 'mozilla-firefox-sync::init_ubuntu'
end

include_recipe 'mozilla-firefox-sync::nginx'
