#!/bin/sh

TAG=$1
EXTRA_VARS=$2

if [ -z "$TAG" ]; then
    echo "Missing TAG. Example sh run.sh create_users"
    exit 1
fi

if [ -z "$EXTRA_VARS" ]; then
    ansible-playbook -t $1 -i inventory.yml playbook.yml
else
    ansible-playbook -t $1 -i inventory.yml playbook.yml --extra-vars $2
fi
