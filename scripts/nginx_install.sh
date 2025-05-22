#!/bin/bash

# Install nginx
sudo yum update -y
sudo yum install nginx -y

# Enable and start nginx
sudo systemctl enable --now nginx
