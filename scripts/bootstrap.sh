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

# Install the rest with the vagrant user
su vagrant

# Meteor
curl https://install.meteor.com | /bin/sh

# Meteorite
npm install -g meteorite

##############################
# Instructions
##############################

echo "Finished installing. Next steps:"
echo "1. Use "vagrant ssh" to connect to the VM"
echo "2. Start the meteor app with: cd /vagrant && npm start"
