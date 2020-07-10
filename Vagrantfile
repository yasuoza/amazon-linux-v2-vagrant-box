# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
  config.vm.box = "amazonlinux2"

  # config.vm.provider "virtualbox" do |vb|
  #   vb.cpus = 2
  #   vb.memory = 1024
  # end

  config.vm.provision "shell", inline: <<-SHELL
    sudo timedatectl set-timezone Asia/Tokyo
  SHELL

  # Install docker and docker-compose
  # config.vm.provision "shell", inline: <<~SHELL
  #   amazon-linux-extras install -y docker
  #   curl --silent -L \
  #     "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
  #     -o /usr/local/bin/docker-compose
  #   chmod +x /usr/local/bin/docker-compose
  #   systemctl enable docker
  #   systemctl start docker
  #   usermod -a -G docker vagrant
  # SHELL
end
