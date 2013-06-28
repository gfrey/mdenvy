# mdenvy : My Dev Env

This is my test on an approach to easily set up the development
environment. Not only mine, but for all users of an project. There is
a central repository with a vagrant file (used to set up a virtual
machine using vagrant), a list of chef (solo) cookbooks for the basic
and project setup and especially a cookbook for every user.

The value of the "USER" environment variable (aka the logged in user's
name) is used to create another user in the virtual machine (with the
same name), the logged in user's public rsa key (the one from
`~/.ssh/id_rsa.pub`) saved in `.ssh/authorized_keys` (to make logging
without passwords possible) and run the user's cookbook.

The benefits from this approach are manifold. First and foremost setup
of the development environment is standardized and automatic, i.e. new
project team members will be able to have the "correct" environment
ready and running in no time. Additionally development and deployment
environments could be created from the same mechanism and thereby
being equivalent. Only dedicated people will need to know how to set
up a database and more fundamental stuff.


## Project Owner Guide

You should create a clone of this repository and add the cookbooks
required for your project. This includes checking out the code for the
user defined in the `node[:mdenvy][:user]` variable.

For repository hygiene I'd recommend removing the example user (name
`gfrey`) and the sample project cookbooks.

Please note that handling private git repositories during provisioning
is kind of difficult because ssh agent forwarding breaks when changing
the user (using the git resource in combination with a different
user). The virtual machine's root user is configured to have access to
the forwarded ssh agent (see the `base::ssh-agent` recipe), adding the
appropriate fingerprints to the known_hosts file and hijacking the
ssh-agent connection.

I'd suggest cloning as root and afterwards change the ownership of the
cloned repositories to the correct user.


## User Guide

All you need to do is make sure your system has vagrant and VirtualBox
(which is a requirement of vagrant) installed. Afterwards run the
`vagrant up` command, that will provision the system for you. On the
first run this might take a while, as vagrant needs to download the
virtual machine image first. Future runs (if you decide to destroy
your machine and set up a fresh one) don't require this step.

After the machine was provisioned successfully log in to machine using
`ssh -X 172.24.1.20` and enjoy your clean development environment. For
further details on where to find your code and stuff rely to your
project's owner who set up this humble mechanism.

If you ever find yourself in need for root access use the `vagrant
ssh` command to get administrative access.


# License

Copyright (C) 2013 Gereon Frey

Distributed under the [Eclipse Public License](http://www.eclipse.org/legal/epl-v10.html).
