#!/bin/sh

ansible-playbook playbook.yml -i inventory.yml -v --tags backups --extra-vars \
	"borg_encryption_passphrase=EtjvkTeI980cH+Y/FXyIL4HRH1ejgf/6XvNewEIWK3I \n
	borgmatic_cron_hour=0 \n
	borgmatIc_cron_minute=0"
