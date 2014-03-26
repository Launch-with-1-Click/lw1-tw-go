require 'ohai'
ohai=Ohai::System.new
ohai.all_plugins

server_name = ohai.cloud[:public_ipv4]
api_fqdn server_name
nginx['url'] = "https://#{server_name}"
nginx['server_name'] = server_name
lb['fqdn'] = server_name
bookshelf['vip'] = server_name

chef_server_webui['web_ui_admin_default_password'] = ohai.ec2[:instance_id]
