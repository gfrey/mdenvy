user_home = "/home/#{node[:mdenvy][:user]}"

## Create the user.
user node[:mdenvy][:user] do
  uid 1020
  gid "users"
  home user_home
  supports :manage_home => true
  action :create
end

## Add user to the admins group (for sudo)
execute 'add user to admins group' do
  command "usermod -a -G admin #{node[:mdenvy][:user]}"
end

## Set up the ssh access using the given ssh public key.
directory "#{user_home}/.ssh" do
  owner node[:mdenvy][:user]
  group "users"
  mode "0700"
  action :create
end

file "#{user_home}/.ssh/authorized_keys" do
  owner node[:mdenvy][:user]
  group "users"
  mode "0600"
  content node[:mdenvy][:pub_ssh_key]
  action :create
end
