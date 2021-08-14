# IaC for Debian servers

This is an Ansible configuration for a Debian 10 server. I'll update it when I have to automate something or for refactoring.

Requirements:
 - for the gcloud role, we install the CLI and a `sa-key.json.gpg` (see [here](https://cloud.google.com/iam/docs/creating-managing-service-account-keys) how to generate a service account file) is expected in `./roles/gcloud/files`, so it gets copied into the host's `/root/.gcloud/credentials/sa-key.json.gpg`. Pass the encrypted file password as the `sa_key_password` extra var to your playbook, so the file can be decrypted on the remote host. You also need to create 

## How to...

### Run the playbook with all roles

```sh
ansible-playbook playbook.yml -i inventory -v
```

### Run a set of tasks

**Add a tag to your task(s)**

```yml
# ./roles/users/tasks/main.yml
- name: create users
user:
    name: "{{ item }}" 
    state: present
    password: "{{ default_user_password | password_hash('sha512', 'A512') }}"
    shell: "{% if users_credentials[item].shell is defined %}{{ users_credentials[item].shell }}{%else %}/bin/bash{% endif %}"
become: true
with_items: "{{ users + admins }}"
tags:
    - users_up
```

**Run the task(s)**

```sh
ansible-playbook playbook.yml -i inventory -v --tags users_up
```

## Pass data to the playbook

**How you'd consume an array**

```yml
# ./roles/users/tasks/main.yml
- name: delete users
user:
    name: "{{ item }}"
    state: absent
    remove: yes
become: true
tags:
    - users_down
with_items: "{{ users_to_delete }}"
```

**How you'd pass an array of strings**

```sh
ansible-playbook playbook.yml -i inventory -v --tags users_down --extra-vars='{"users_to_delete": ["user1"]}'
```
### Create a role

You group configuration in a role so that you can reuse it

**role structure**

```sh
mkdir -p roles/<my-role>/metadata
mkdir -p roles/<my-role>/tasks
mkdir -p roles/<my-role>/vars
```

**role reference**

```yml
# playbook.yml
- hosts: 
    - idealj
  roles:
    - role: tools
    - role: users
      default_user_password: TempPass4321
      users:
        - dummy
      admins:
        - admin
    - role: firewall
    - role: <my-role>
```
