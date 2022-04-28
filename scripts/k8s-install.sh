#!/bin/sh

set -e

cd ..
ansible-playbook -t k8s_install -i inventory.yml playbook.yml