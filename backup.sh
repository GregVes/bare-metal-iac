#!/bin/sh

TAG=$1

ansible-playbook playbook.yml -i inventory.yml -vv --tags $TAG --extra-vars \
	"borg_encryption_passphrase=EtjvkTeI980cH+Y/FXyIL4HRH1ejgf/6XvNewEIWK3I"
