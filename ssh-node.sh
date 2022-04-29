#!/bin/sh

NODE=$1

if [ "$NODE" == "master" ]; then
    ssh -i ~/.ssh/id_rsa.idealj $NODE_LINUX_USER@$MASTER_IP
elif [ "$NODE" == "worker-0" ]; then
    ssh -i ~/.ssh/id_rsa.idealj $NODE_LINUX_USER@$WORKER_0_IP
elif [ "$NODE" == "worker-1" ]; then
    ssh -i ~/.ssh/id_rsa.idealj $NODE_LINUX_USER@$WORKER_1_IP
else
    echo "Worker node ${NODE} does not exist"
fi