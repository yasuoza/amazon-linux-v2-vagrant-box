# How to create Amazon Linux Image for Vagrant

## TL;DR

```
make start_vm
ansible-playbook -i ansible/hosts.yml -l base ansible/tasks/1_kernel_update.yml
make insert_guest_iso
ansible-playbook -i ansible/hosts.yml -l base ansible/tasks/2_install_vbguest.yml
make box
```

## Create VirtualBox Image

```
make start_vm
```

## Install VirtualBox Guest Additions

Connect via ssh to guest machine.

```
wget https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant -O vagrant-private.key
chmod 600 vagrant-private.key
ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null localhost -p 8022 -l vagrant -i vagrant-private.key
sudo yum -y update kernel
```

Eject and reboot for kernel-header reloading.

```
$ sudo eject
$ sudo reboot now
```

Insert VBoxGuestAdditions.iso.

```
make insert_guest_iso
```

```
$ sudo mount -r -t iso9660 /dev/cdrom /media
$ sudo /media/VBoxLinuxAdditions.run
$ sudo umount /media
$ sudo eject
```

Create `/vagrant` directory for Vagrant.

```
$ sudo mkdir /vagrant
```

Clean up VM.

```
$ sudo yum clean all
$ sudo rm -rf /var/cache/yum
$ history -c
```

```
$ exit
```

```
make box
```

## FYI

https://dev.classmethod.jp/server-side/run-amazon-linux-2-on-vagrant/
