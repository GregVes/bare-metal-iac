#!/bin/sh

set -e

ansible-playbook -t virt_vm_remove -i inventory.yml playbook.yml --extra-vars='{"vms_to_remove":["k8s-master", "k8s-worker-0","k8s-worker-1"]}' --limit=kvm_host
ansible-playbook -t virt_disks_remove -i inventory.yml playbook.yml --limit=kvm_host

ansible-playbook -t virt_disks_create -i inventory.yml playbook.yml --extra-vars "virt_root_password=helloworld" --limit=kvm_host

ansible-playbook -t virt_vm_create -i inventory.yml playbook.yml --limit=kvm_host

sleep 10
ansible-playbook -t k8s_install -i inventory.yml playbook.yml --limit=kvm_guests