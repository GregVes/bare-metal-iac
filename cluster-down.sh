#!/bin/sh

# delete vms and disks

ansible-playbook -t virt_vm_remove -i inventory.yml playbook.yml --extra-vars='{"vms_to_remove":["k8s-master", "k8s-worker-0","k8s-worker-1"]}'
ansible-playbook -t virt_disks_remove -i inventory.yml playbook.yml --limit kvm_host