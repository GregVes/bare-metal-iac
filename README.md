# Bare metal IAC

This is Ansible playbook for basic configuration of Debian bare metal server that hosts a Kubernetes cluster of KVM guests

## How to run tasks

```sh
# Wrapper around ansible-playbook command
sh run-tasks.sh <tag> <hosts-group> <optional-extra-vars>
```
### Create Linux users

Create regular users as well as admins who are added to sudo group, copy ssh authorized key and .vimrc, disable password at login and restart ssh daemon

```sh
sh run-tasks.sh users_up kvm_guests "default_password=helloworld"
```

### Setup zsh and ohmyzsh for Linux users

Install zsh, ohmyzsh and setup fancy plugins

```sh
sh run-tasks.sh zsh_up kvm_host
```

### Setup firewall

Install and enable `ufw` allow traffic on ports 80,443 and 22

```sh
sh run-tasks.sh firewall_up kvm_host
```

### Install sys packages

As the above title says

```sh
sh run-tasks.sh sys_pkgs_up kvm_host
```

## Install Prometheus/Grafana instances

Uses Docker compose

```sh
See roles/monitoring/defaults/main.yml before running this
sh run-tasks.sh monitoring_up kvm_host
```

## Install Drone instance

Uses Docker compose

```sh
See roles/drone/defaults/main.yml before running this
sh run-tasks.sh drone_up kvm_host
```

## Setup system backup

Use borg and borgmatic to daily back up system to BorgBase

```sh
See roles/backup/defaults/main.yml before running this
sh run-tasks.sh backup_up kvm_host
```

## Configure disk images for kvm guests

Download and configure Debian 10 images (hostname, password, some configs)

```sh
See roles/virtualization/defaults/main.yml before running this
sh run-tasks.sh virt_disks_create kvm_host "virt_root_password=<super-secured-pwd>"
```

## Install kvm guests VMs

Provision 3 kvm guests: master and two worker nodes

```sh
See roles/virtualization/defaults/main.yml before running this
sh run-tasks.sh virt_vm_create kvm_host
```

## Configure k8s in kvm guests

Install Docker stuff, kubeadm, kubectl and kubeadm. Init cluster in master node and make worker join this cluster.

```sh
See roles/virtualization/defaults/main.yml before running this
sh run-tasks.sh k8s_install kvm_guests
```