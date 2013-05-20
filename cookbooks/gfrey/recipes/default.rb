user_home = "/home/gfrey"

node[:current_user] = "gfrey"

## -----------------------------------------------------------------------------
## Create directory with all user related configuration.
directory "#{user_home}/usr/etc" do
  owner "gfrey"
  group "users"
  mode "0755"
  recursive true
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
