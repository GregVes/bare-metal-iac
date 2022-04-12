#!/bin/sh

set -x

echo "Installing ca-certificastes gnupg and lsb-release"
apt-get install -y ca-certificates gnupg lsb-release

curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "Installing Docker related packages"
apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io

apt-get update \
  && apt-get install -y apt-transport-https \
  && curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list

# k8s stuf
apt-get update && apt-get install -y kubelet kubeadm kubernetes-cni

# this fix 'connection refused' error when running kubeadm init
echo "Adding systemd as native.cgroupdriver in /etc/docker/daemon.json"
echo '{\n    "exec-opts": ["native.cgroupdriver=systemd"]\n}' > /etc/docker/daemon.json
echo "Reloading daemon-reload, docker and kubelet"
systemctl daemon-reload
systemctl restart docker
systemctl restart kubelet

echo "Worker node VM created. Get the token from the master node to join the cluster"
