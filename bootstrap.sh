#!/usr/bin/env bash
set -ex

sudo yum update -y
sudo yum install -y git java-1.7.0-openjdk gcc libxml2-devel libxslt-devel httpd-tools

## Install Chef-Client and nokogiri
curl -L https://www.getchef.com/chef/install.sh | sudo bash

## Setup hint for ec2
mkdir -p /etc/chef/ohai/hints
echo '{}' > /etc/chef/ohai/hints/ec2.json


## Install Go Packages
# CHEFSERVER_PKG="chef-server_11.0.11-1.ubuntu.12.04_amd64.deb"
TW_GO_VERSION='13.4.1'
TW_GOSERVER_PKG='go-server-13.4.1-18342.noarch.rpm'
TW_GOAGENT_PKG='go-agent-13.4.1-18342.noarch.rpm'
wget --progress=dot http://download01.thoughtworks.com/go/${TW_GO_VERSION}/ga/${TW_GOSERVER_PKG}
wget --progress=dot http://download01.thoughtworks.com/go/${TW_GO_VERSION}/ga/${TW_GOAGENT_PKG}

sudo rpm -i ${TW_GOSERVER_PKG}
sudo rpm -i ${TW_GOAGENT_PKG}

rm ${TW_GOSERVER_PKG}
rm ${TW_GOAGENT_PKG}


## Configure Go-Server
sudo service go-server stop
sudo chkconfig go-server off
sudo chkconfig go-agent off

echo "* soft nofile 1024" >> /etc/security/limits.conf
echo "* hard nofile 65535" >> /etc/security/limits.conf
echo "export SERVER_MEM=512m" >> /etc/default/go-server
echo "export SERVER_MAX_MEM=1024m" >> /etc/default/go-server

## prepare chef_repo
sudo rsync -a /vagrant/chef_repo/ /opt/lw1

## cron job for 1st boot
sudo install -o root -g root -m 0600 /vagrant/files/go_reboot.cron /etc/cron.d/go_reboot
