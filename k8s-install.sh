#!/bin/sh

set -e

ansible-playbook -t k8s_install -i inventory.yml playbook.yml