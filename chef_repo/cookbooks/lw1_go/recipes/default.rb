#
# Cookbook Name:: lw1_go
# Recipe:: default
#
# Copyright 2014, HiganWorks LLC
#
# All rights reserved - Do Not Redistribute
#

template '/etc/go/cruise-config.xml' do
  source 'cruise-config.xml.erb'
  variables ({
    :uuid => SecureRandom.uuid
  })
end

## create admin pass
require 'digest/sha1'
require 'base64'
admin_pw = '{SHA}' + Base64.encode64(Digest::SHA1.digest(node[:ec2][:instance_id])).chomp

file '/etc/go/passwd' do
  owner 'go'
  group 'go'
  content ['admin', admin_pw].join(':')
end


%w{go-server go-agent}.each do |svc|
  service svc do
    action [:start, :enable]
  end
end

# include_recipe 'lw1_go::seppuku'
