#!/bin/sh

set -e

ansible-playbook -t k8s_uninstall -i inventory.yml playbook.yml