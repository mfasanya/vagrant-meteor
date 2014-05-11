vagrant-meteor
==============

Vagrant configuration for a VM that can run Meteor apps.

## How to use

Download this repository and move your meteor app into the `app` folder.

### Local smart packages

By default the packages folder of your app won't be copied to the VM.
If you have local smart packages that should be copied to the VM, add them in the Vagrantfile where it says
`# Add your local packages here`.

### Install additional things

You can modify the `scripts/bootstrap.sh` if you need additional things installed in you VM.
By default Vagrant will install:

* Node.js 0.10.x
* NPM
* Meteor
* Meteorite

## Install the VM

> __Note for Windows:__ You must install [Cygwin](http://www.cygwin.com/install.html)
> with the packages `openssh` and `rsync` and use it for running the vagrant commands.

1. Install the latest version of [Vagrant](http://www.vagrantup.com/downloads.html).
2. Run the command `vagrant up` in the project directory.

## Start your app

1. Start the VM with `vagrant up`.
2. Connect to the VM with `vagrant ssh`.
3. `cd /vagrant`
4. `npm start` (This will do `cd app && NODE_OPTIONS=--debug=5858 mrt` by default. See packages.json)
5. You can access the app on your host machine with `http://localhost:3000/`.

## File synchronisation

[Rsync](http://docs.vagrantup.com/v2/synced-folders/rsync.html) is used for file synchronisation.

### Mac OS and Linux

Install vagrant-gatling-rsync with `vagrant plugin install vagrant-gatling-rsync`.
It's less CPU intensive than rsync-auto.
Then run `vagrant gatling-rsync-auto` for automatic file synchronisation.

### Windows

Run `vagrant rsync-auto` for automatic file synchronisation.

## Debugging

Run `./scripts/vagrant-ssh-node.sh` on your host machine.
After this you can connect to the app with the IP 127.0.0.1 and the port 5858.
