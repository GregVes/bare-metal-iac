#!/bin/sh

NODE=$1

if [ "$NODE" == "master" ]; then
    ssh $NODE_LINUX_USER@$MASTER_IP
elif [ "$NODE" == "worker-0" ]; then
    ssh $NODE_LINUX_USER@$WORKER_0_IP
elif [ "$NODE" == "worker-1" ]; then
    ssh $NODE_LINUX_USER@$WORKER_1_IP
else
    echo "Node ${NODE} does not exist"
fi