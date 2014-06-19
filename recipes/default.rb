#
# Cookbook Name:: sync-1.5
# Recipe:: default
#
# Copyright 2014, computerlyrik, Christian Fischer
#
# All rights reserved - Do Not Redistribute
#
require "chef/shell_out"

package 'python-dev'
package 'make'
package 'git-core'
package 'python-virtualenv'



git node['sync-1.5']['target_dir'] do
  repository node['sync-1.5']['repository']
  action :checkout
  notifies :run, "bash[build_source]", :immediately
end

bash "build_source" do
  code 'make build'
  cwd node['sync-1.5']['target_dir']
  action :nothing
  notifies :run, "bash[install_gunicorn]", :immediately
end

bash 'install_gunicorn' do
  code 'local/bin/easy_install gunicorn'
  cwd node['sync-1.5']['target_dir']
  action :nothing
end

ruby_block 'create_random' do
  begin
	  cmd = Chef::ShellOut.new('head -c 20 /dev/urandom | sha1sum  | rev | cut -c 4- | rev')
    cmd.run_command
    node.set['sync-1.5']['auth_secret'] = cmd.stdout
  end
  only_if { node['sync-1.5']['auth_secret'].nil? }
end

template "#{node['sync-1.5']['target_dir']}/syncserver.ini" do
  variables(
      public_url: "http://#{node['fqdn']}:5000",
      secret: node['sync-1.5']['auth_secret'],
  )
end

include_recipe 'nginx'

certificate_manage 'sync-1.5' do
  search_id node['sync-1.5']['certificate_databag_id']
  cert_path '/etc/nginx/ssl'
  nginx_cert true
  not_if { node['sync-1.5']['certificate_databag_id'].nil? }
end

template '/etc/nginx/sites-available/syncserver' do
  owner 'root'
  group 'root'
  mode '0644'
  source 'nginx.syncserver.erb'
  notifies :restart, 'service[nginx]'
  variables(
      server_name: node['fqdn'],
      ssl_certificate: node['sync-1.5']['ssl_certificate'],
      ssl_certificate_key: node['sync-1.5']['ssl_certificate_key'],
  )
end

=begin
command_dir = "#{node['sync-1.5']['target_dir']}/local/bin"
bash "pserve syncserver.ini" do
  cwd command_dir
end
=end

