#!/bin/sh

TAG=$1

ansible-playbook playbook.yml -i inventory.yml -v --tags $TAG
