VM := Amazon Linux 2
BASE_VDI := amzn2-virtualbox-2.0.20200602.0-x86_64.xfs.gpt.vdi
VDI := $(patsubst %.vdi,%.copy.vdi,$(BASE_VDI))
BOX_NAME := amazonlinux2

help:
	@echo "make open_dl"
	@echo "make clean"
	@echo "make seed"
	@echo "make start_vm"
	@echo "make insert_guest_iso"
	@echo "make box"

open_dl:
	open 'https://cdn.amazonlinux.com/os-images/latest/virtualbox/'

clean:
	rm -rf seed.iso
	rm -rf $(VDI)
	rm -rf package.box
	VBoxManage unregistervm "$(VM)" --delete

seed:
	hdiutil makehybrid -o seed.iso -hfs -joliet -iso -default-volume-name cidata seedconfig/

start_vm: seed
	cp $(BASE_VDI) $(VDI)
	VBoxManage createvm --name "$(VM)" --ostype "RedHat_64" --register
	VBoxManage storagectl "$(VM)" --name "SATA Controller" --add "sata" --controller "IntelAHCI"
	VBoxManage storagectl "$(VM)" --name "IDE Controller" --add "ide"
	VBoxManage storageattach "$(VM)" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium $(VDI)
	VBoxManage storageattach "$(VM)" --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium seed.iso
	VBoxManage modifyvm "$(VM)" --natpf1 "ssh,tcp,127.0.0.1,8022,,22" --memory 1024 --vram 8 --audio none --usb off
	VBoxManage startvm "$(VM)" --type headless
	@echo "next: ansible-playbook -i ansible/hosts.yml -l base ansible/tasks/1_kernel_update.yml"

insert_guest_iso:
	VBoxManage storageattach "$(VM)" --storagectl 'IDE Controller' \
		--port 0 --device 0 --type dvddrive \
		--medium '/Applications/VirtualBox.app/Contents/MacOS/VBoxGuestAdditions.iso'
	@echo "next: ansible-playbook -i ansible/hosts.yml -l base ansible/tasks/2_install_vbguest.yml"

vagrant:
	ansible-playbook -i ansible/hosts.yml ansible/tasks/1_kernel_update.yml
	@make insert_guest_iso
	ansible-playbook -i ansible/hosts.yml ansible/tasks/2_install_vbguest.yml
	@make box
	@make clean

box:
	vagrant package --base "$(VM)"
	vagrant box add --name $(BOX_NAME) --force package.box
	@echo "Finish boxing Amazon Linux 2"
	@echo "next(optional): make clean"
