# mdenvy : My Dev Env

This is my test on an approach to easily set up the development
environment. Not only mine, but for all users of an project. There is
a central repository with a vagrant file (used to set up a virtual
machine), a list of chef (solo) cookbooks for the basic setup, the
project setup and especially a cookbook for every user.

The value of "USER" environment variable (aka the logged in user's
name) is used to create another user in the virtual machine (with the
same name), the logged in user's public rsa key (the one from
`~/.ssh/id_rsa.pub`) saved in `.ssh/authorized_keys` (to make logging
without passwords possible) and run the user's cookbook.


## Project Owner Guide

You should create a clone of this repository and add the cookbooks
required for your project. This includes checking out the code for the
user defined the `node[:mdenvy][:user]` variable.

For repository hygiene I'd recommend removing the example user (name
`gfrey`) and project cookbooks.


## User Guide

All you need to do is make sure your system has vagrant and VirtualBox
(which is a requirement of vagrant) installed. Afterwards run the
  `vagrant up`
command, that will provision the system for you. On the first run this
might take a while, as vagrant needs to download the virtual machine
image first. Future runs (if you decide to destroy your machine and
set up a fresh one) don't require this step.

After the machine was provisioned successfully log in to machine using
  `ssh -X ${USER}@172.24.1.20`
and enjoy your clean development environment. For further details on
where to find your code and stuff rely to your project's owner who set
up this humble mechanism.

If you ever find yourself in need for root access use the
  `vagrant ssh`
command to get administrative access.


# License

Copyright (C) 2013 Gereon Frey

Distributed under the [Eclipse Public License](http://www.eclipse.org/legal/epl-v10.html).
