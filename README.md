# mdenvy : My Dev Env

This is my test on an approach to easily set up the development
environment. Not only mine, but for all users of an
organization. There is a central repository with a vagrant file (used
to set up a virtual machine), a list of chef (solo) cookbooks for the
basic setup and especially a cookbook for every user with all the
required files.

The value of "USER" environment variable (aka the logged in user's
name) is used to create another user in the virtual machine (with the
same name), the logged in user's public rsa key saved in
.ssh/authorized_keys (to make logging without passwords possible) and
run the user's cookbook.
