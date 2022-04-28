#!/bin/sh

set -e

TAG=$1
HOSTS=$2
EXTRA_ARGS=$3

if [ -z "${TAG}" ]; then
    echo "Missing TAG. Example sh run-host-tasks.sh create_users"
    exit 0
fi

if [ -z "${EXTRA_ARGS}" ]; then
    ansible-playbook -t $TAG -i inventory.yml playbook.yml --limit=$HOSTS
else
    ansible-playbook -t $TAG -i inventory.yml playbook.yml --extra-vars $2 --limit=$HOSTS
fi