# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "dummy"


  ## AWS
  config.vm.provider :aws do |aws, override|
    aws.access_key_id = ENV['AWS_ACCESS_KEY']
    aws.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
    aws.keypair_name = ENV['AWS_EC2_KEYPAIR']

    aws.region = ENV['AWS_REGION']
    case ENV['AWS_REGION']
    when 'ap-northeast-1'
      aws.ami = 'ami-08842d60'  # Amazon Linux AMI 2014.09
    when 'us-east-1'
      aws.ami = 'ami-b66ed3de'  # Amazon Linux AMI 2014.09.1
    else
      raise "Unsupported region #{ENV['AWS_REGION']}"
    end
    aws.instance_type = 'c3.large'

    override.ssh.username = "ec2-user"
    override.ssh.private_key_path = ENV['AWS_EC2_KEYPASS']
  end

  config.ssh.pty = true
  config.vm.provision :shell, :path => "bootstrap.sh"

  ## Rsync settings
  ## It doesn't works fine? Todo: read source
#  config.vm.synced_folder ".", "/vagrant", type: "rsync",
#    rsync__exclude: ".git/"
    # rsync__exclude: [".git/", '.DS_Store', '*.swp', '*.swo']
end
