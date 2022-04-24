#!/bin/sh

set -e

ansible-playbook -t virt_vm_remove -i inventory.yml playbook.yml --extra-vars='{"vms_to_remove":["k8s-master", "k8s-worker-0","k8s-worker-1"]}'
sh run.sh virt_disks_remove
sh run.sh virt_disks_create "virt_root_password=helloworld"
sh run.sh virt_vm_create