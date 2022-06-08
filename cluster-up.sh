#!/bin/sh


# delete vms and disks

ansible-playbook -t virt_disks_create -i inventory.yml playbook.yml --extra-vars "virt_root_password=${SERVER_USER_PASSWORD}" --limit=kvm_host
ansible-playbook -t virt_vm_create -i inventory.yml playbook.yml --limit=kvm_host

sleep 3

ssh-keyscan -H 51.83.150.197 >> ~/.ssh/known_hosts
ssh-keyscan -H 51.83.147.42 >> ~/.ssh/known_hosts
ssh-keyscan -H 51.83.179.16 >> ~/.ssh/known_hosts

sleep 3

# install base pkgs
ansible-playbook -t sys_pkgs_up -i inventory.yml playbook.yml --limit=kvm_guests

# create users
ansible-playbook -t users_up -i inventory.yml playbook.yml --extra-vars="default_password=${SERVER_USER_PASSWORD}" --limit 'kvm_guests'
ansible-playbook -t zsh_up -i inventory.yml playbook.yml --limit 'kvm_guests'

# install k8s components and start cluster
ansible-playbook -t k8s_install -i inventory.yml playbook.yml

# install openebs components
ansible-playbook -t openebs_install -i inventory.yml playbook.yml