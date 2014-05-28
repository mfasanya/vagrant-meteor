vagrant-meteor
==============

[Vagrant](http://www.vagrantup.com/) configuration for a [virtual machine](http://en.wikipedia.org/wiki/Virtual_machine)
that can run [Meteor](https://www.meteor.com/) apps.

## How to use

### Additional step for Windows

You must install [Cygwin](http://www.cygwin.com/install.html) with the packages `openssh` and `rsync`.
You can and use the Cygwin shell for running the vagrant commands.
If you want to use the Windows shell instead, you must add the cygwin/bin folder to your [PATH](http://geekswithblogs.net/renso/archive/2009/10/21/how-to-set-the-windows-path-in-windows-7.aspx).

### Synchronisation

__Important:__ The folder is synchronised two times. It is necessary because Meteor don't likes the shared folders of
Virtualbox that are usually used.

1. __/vagrant:__ One way synchronisation from the host to the guest with rsync. __It must be used to start the app.__
2. __/meteor:__ Two way synchronisation with a Virualbox shared folder. __Use it when you create or edit files in the guest.__

### Installation

1. [Download](https://github.com/Sanjo/vagrant-meteor/archive/master.zip) this repository and unpack the downloaded zip file.
2. Install the latest version of [Vagrant](http://www.vagrantup.com/downloads.html) (1.6.1 or newer is recommended).
3. Open a shell and change the directory to the unpacked `vagrant-meteor-master` folder.
4. Run the command `vagrant up` and wait until the installation finished. This will create the virtual machine.
5. Run the command `vagrant ssh` to connect to the virtual machine. The `vagrant-meteor` folder is mounted to `/vagrant`.

### Vagrant 101

You will only need a few vagrant command that you should remember.

* `vagrant up`: Starts your virtual machine or creates it if it doesn't exist.
* `vagrant ssh`: Opens a SSH connection to the virtual machine.
* `vagrant suspend`: Pauses the virtual machine. It will save the current state to the disk.

You can find more commands and info in the [Vagrant documentation](http://docs.vagrantup.com/v2/cli/index.html).

### Create a new app

1. Change the directory to `/meteor` (with `cd /meteor`)
2. Create a new app with `mrt create <name>` (see [Meteorite documentation](https://github.com/oortcloud/meteorite/)).
   You can also use the `meteor` tool if you want.

### Use an existing app

Move your app folder into the downloaded `vagrant-meteor-master` folder.

### File synchronisation

[Rsync](http://docs.vagrantup.com/v2/synced-folders/rsync.html) is used for file synchronisation.
By default the files will only be copied to the virtual machine,
when you start the virtual machine with `vagrant up` or reload it with `vagrant reload`.

`vagrant rsync-auto` will watch your files and automatically copy changes to the virtual machine.
You have to run the command in a separate shell. The command is not perfect (yet).
I recommend to read [the documentation](http://docs.vagrantup.com/v2/cli/rsync-auto.html) about it.

#### Better alternative for Mac OS and Linux

There is a better plugin for `vagrant rsync-auto` that is more efficient and less CPU intensive.
Install it with `vagrant plugin install vagrant-gatling-rsync`.
Then run `vagrant gatling-rsync-auto` for automatic file synchronisation instead of `vagrant rsync-auto`.

### Start your app

1. Connect to the virtual machine with `vagrant ssh`.
1. Change to the app directory in the virtual machine (`cd /vagrant/<MY_APP>`)
2. Start your app with `mrt` (or `meteor`).
5. You can access the app on your host machine with `http://localhost:3000/`.

### Local smart packages

By default the packages folder of your app won't be copied to the virtual machine. Meteorite will install the packages inside the virtual machine.
If you have local smart packages that should be copied, add them in the Vagrantfile where it says
`# Add your local packages here` by adding a line `"+ /<MY_APP>/packages/<MY_PACKAGE>/***",` for each package under the comment.

__Example__: My package is in the folder `vagrant-meteor/myApp/packages/myPackage/`. I would add the line `"+ /myApp/packages/myPackage/***"`.

### Debugging

1. Run `./scripts/vagrant-ssh-node.sh` on your host machine. On Windows you must use the Cygwin shell to run it.
2. Start your app with `NODE_OPTIONS=--debug=5858 mrt`.
3. After this you can connect to the app with the IP 127.0.0.1 and the port 5858.

### Install additional things

You can modify the `scripts/bootstrap.sh` if you need additional things installed in you VM.
By default Vagrant will install:

* Node.js 0.10.x
* NPM
* Meteor
* Meteorite
