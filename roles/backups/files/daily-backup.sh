#!/bin/sh

BORG_REPO=$1
GCLOUD_BUCKET=$2

/usr/local/bin/borgmatic --log-file /var/log/borgmatic/borgmatic.log -c /etc/borgmatic/config.yaml

gsutil -m rsync $BORG_REPO gs://$GCLOUD_BUCKET