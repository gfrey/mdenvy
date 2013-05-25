user_home = "/home/gfrey"

## -----------------------------------------------------------------------------
## Create directory with all user related configuration.
directory "#{user_home}/usr/etc" do
  owner "gfrey"
  group "users"
  mode "0755"
  recursive true
  action :create
end

directory "#{user_home}/usr/bin" do
  owner "gfrey"
  group "users"
  mode "0755"
  action :create
end

## -----------------------------------------------------------------------------
## Setup zsh and configuration.
package 'zsh-beta'

git "#{user_home}/usr/etc/oh-my-zsh" do
  repository "https://github.com/gfrey/oh-my-zsh.git"
  revision "personal"
  user "gfrey"
  group "users"
  action :sync
end

link "#{user_home}/.zshrc" do
  to "#{user_home}/usr/etc/oh-my-zsh/custom/zshrc"
  owner "gfrey"
  group "users"
end

user 'gfrey' do
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
  user "gfrey"
  group "users"
  action :sync
end

link "#{user_home}/.emacs.d" do
  to "#{user_home}/usr/etc/prelude"
  owner "gfrey"
  group "users"
end

## -----------------------------------------------------------------------------
## Setup tmux.
package 'tmux'

package 'python-psutil'

git "#{user_home}/usr/etc/tmuxified" do
  repository "https://github.com/gfrey/tmuxified.git"
  revision "personal"
  user "gfrey"
  group "users"
  action :sync
end

link "#{user_home}/.tmux" do
  to "#{user_home}/usr/etc/tmuxified"
  owner "gfrey"
  group "users"
end

link "#{user_home}/.tmux.conf" do
  to "#{user_home}/.tmux/tmux.conf"
  owner "gfrey"
  group "users"
end

link "#{user_home}/usr/bin/basic-cpu-and-memory.tmux" do
  to "#{user_home}/.tmux/scripts/basic-cpu-and-memory.tmux"
  owner "gfrey"
  group "users"
end


## -----------------------------------------------------------------------------
## Configure git.
execute "configure git username" do
  command = "git config --global user.name 'Gereon Frey'"
end

execute "configure git user email address" do
  command = "git config --global user.email 'me@gereonfrey.de'"
end

execute "configure git colors" do
  command = "git config --global color.ui true"
end


## -----------------------------------------------------------------------------
## Install assorted packages.
package 'fonts-ubuntu-font-family-console'
