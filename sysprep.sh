#!/bin/bash
# Extra point, if you smile looking at file name ;)
# This file prepares the system to run Docker containers

# Run a yum update
sudo yum -y update

# Install Docker
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce
systemctl start docker

#Map Log volume to /logs
mkfs -t ext4 /dev/xvdf
mkdir /mongologs
mount /dev/xvdf /mongologs
echo /dev/xvdf  /mongologs ext4 defaults 0 0 >> /etc/fstab

# Deploy MongoDB container
# The following code is a quick way to get mongo up and running,
# but will not create a Mongo cluster
# docker run -d -p 27017:27017 -p 28017:28017 -e MONGODB_USER="user" -e MONGODB_DATABASE="mydatabase" -e MONGODB_PASS="mypass" --name mongo-3.4 dubc/mongodb --logpath /mongologs/mongod.log