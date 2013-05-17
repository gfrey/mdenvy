# mdenvy : My Dev Env

This is my test on an approach to easily set up the development
environment. Not only mine, but for all users of an
organization. There is a central repository with a vagrant file (used
to set up a virtual machine), a list of chef (solo) cookbooks for the
basic setup and especially a cookbook for every user with all the
required files.

When setting up the VM the user's (aka the value set in the "USER"
environment variable) cookbook is loaded and used.
