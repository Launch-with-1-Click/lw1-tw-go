system('sudo install -o ubuntu -g ubuntu -m 0600 /etc/chef-server/admin.pem ~/.chef/')
system('sudo install -o ubuntu -g ubuntu -m 0600 /etc/chef-server/chef-validator.pem ~/.chef/')

require 'ohai'
ohai=Ohai::System.new
ohai.all_plugins

server_name = ohai.cloud[:public_ipv4]

log_level                :info
log_location             STDOUT
node_name                'admin'
client_key               '~/.chef/admin.pem'
validation_client_name   'chef-validator'
validation_key           '~/.chef/chef-validator.pem'
chef_server_url          "https://#{server_name}"
