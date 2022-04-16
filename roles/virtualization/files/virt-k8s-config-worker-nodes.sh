#!/bin/sh

set -e

echo "Installing ca-certificates gnupg and lsb-release"
apt update
apt install -y ca-certificates gnupg lsb-release

curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -


echo "Installing Docker related packages"
apt update
apt install -y docker-ce docker-ce-cli containerd.io

# k8s stuff

apt update
apt install -y apt-transport-https ca-certificates

echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list


cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system

curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list

apt update
apt install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl

# this fix 'connection refused' error when running kubeadm init
echo "Adding systemd as native.cgroupdriver in /etc/docker/daemon.json"
echo '{\n    "exec-opts": ["native.cgroupdriver=systemd"]\n}' > /etc/docker/daemon.json

echo "Reloading daemon-reload, docker and kubelet"
systemctl daemon-reload
systemctl restart docker
systemctl restart kubelet

echo "Worker node VM created. Get the token from the master node to join the cluster"
