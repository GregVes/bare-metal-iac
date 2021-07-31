#!/bin/sh

# Be sure it is first disable
sudo ufw disable

# default
sudo ufw default deny incoming
sudo ufw default allow outgoing

# ssh
sudo ufw allow ssh

# web
sudo ufw allow 80
sudo ufw allow 443

echo y | sudo ufw enable
