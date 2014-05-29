#!/bin/sh

# This script must run with root privileges!
# Vagrant will do this automatically for provisioning.

apt-get update
apt-get upgrade

##############################
# Install common packages and useful tools
##############################

apt-get -y install curl imagemagick git python-software-properties

##############################
# Configure package repositories
##############################

# Node.js
add-apt-repository ppa:chris-lea/node.js

apt-get update

##############################
# Install packages
##############################

# Node.js
apt-get -y install nodejs

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list

sudo apt-get update
sudo apt-get install mongodb-10gen

# Install the rest with the vagrant user
su vagrant

# Meteor
curl https://install.meteor.com | /bin/sh

# Meteorite
npm install -g meteorite

mkdir -p /data/db
service mongodb restart
MONGO_URL=mongodb://localhost:27017

##############################
# Instructions
##############################

echo "Finished installing. Next steps:"
echo "1. Use "vagrant ssh" to connect to the VM"
echo "2. Start the meteor app with: cd /vagrant && npm start"
