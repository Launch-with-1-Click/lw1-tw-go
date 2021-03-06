#!/usr/bin/env bash

set -ex

sudo yum clean all

sudo rm -rf /tmp/*
sudo rm -f /etc/ssh/ssh_host_*
cd /var/log
sudo find /var/log/ -type f -name '*.log' -exec sudo cp /dev/null {} \;
sudo cp /dev/null /var/log/syslog

sudo rm -f /home/ec2-user/go_reboot
sudo rm -f /home/ec2-user/ulimit_go.conf

yes | sudo cp /dev/null /root/.ssh/authorized_keys
yes | sudo cp /dev/null /root/.bash_history
if [ -d /home/ec2-user ]; then
  yes | cp /dev/null /home/ec2-user/.ssh/authorized_keys
  yes | cp /dev/null /home/ec2-user/.bash_history
fi
history -c

