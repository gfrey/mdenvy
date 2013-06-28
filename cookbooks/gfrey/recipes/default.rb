user_home = "/home/#{node[:mdenvy][:user]}"

## -----------------------------------------------------------------------------
## Create directory with all user related configuration.
directory "#{user_home}/usr/etc" do
  owner node[:mdenvy][:user]
  group "users"
  mode "0755"
  recursive true
  action :create
end

directory "#{user_home}/usr/bin" do
  owner node[:mdenvy][:user]
  group "users"
  mode "0755"
  action :create
end

## Fix bug with with git 1.8.1.2 (fixed in 1.8.3)
directory '/root' do
  mode 0755
end

## -----------------------------------------------------------------------------
## Setup zsh and configuration.
package 'zsh-beta'

git "#{user_home}/usr/etc/oh-my-zsh" do
  repository "https://github.com/gfrey/oh-my-zsh.git"
  revision "personal"
  user node[:mdenvy][:user]
  group "users"
  action :sync
end

link "#{user_home}/.zshrc" do
  to "#{user_home}/usr/etc/oh-my-zsh/custom/zshrc"
  owner node[:mdenvy][:user]
  group "users"
end

user node[:mdenvy][:user] do
  shell '/usr/bin/zsh'
  action :modify
end

## -----------------------------------------------------------------------------
## Setup emacs.
package 'emacs24'

package 'aspell'
package 'aspell-en'
package 'aspell-de'

git "#{user_home}/usr/etc/prelude" do
  repository "https://github.com/gfrey/prelude.git"
  revision "personal"
  user node[:mdenvy][:user]
  group "users"
  action :sync
end

link "#{user_home}/.emacs.d" do
  to "#{user_home}/usr/etc/prelude"
  owner node[:mdenvy][:user]
  group "users"
end

## -----------------------------------------------------------------------------
## Setup tmux.
package 'tmux'

package 'xsel'
package 'python-psutil'

git "#{user_home}/usr/etc/tmuxified" do
  repository "https://github.com/gfrey/tmuxified.git"
  revision "personal"
  user node[:mdenvy][:user]
  group "users"
  action :sync
end

link "#{user_home}/.tmux" do
  to "#{user_home}/usr/etc/tmuxified"
  owner node[:mdenvy][:user]
  group "users"
end

link "#{user_home}/.tmux.conf" do
  to "#{user_home}/.tmux/tmux.conf"
  owner node[:mdenvy][:user]
  group "users"
end

link "#{user_home}/usr/bin/basic-cpu-and-memory.tmux" do
  to "#{user_home}/.tmux/scripts/basic-cpu-and-memory.tmux"
  owner node[:mdenvy][:user]
  group "users"
end


## -----------------------------------------------------------------------------
## Configure git.
mdenvy_gitconfig node[:mdenvy][:user] do
  username "Gereon Frey"
  email "me@gereonfrey.de"
end

## -----------------------------------------------------------------------------
## Install assorted packages.
package 'tig'
package 'fonts-ubuntu-font-family-console'
