package 'samba'

execute 'configure samba' do
  command 'printf "[homes]\n  browseable=no\n  read only=no\n  valid users=%s\n" >> /etc/samba/smb.conf'
  not_if { system('grep "^\[homes\]$" /etc/samba/smb.conf') }
end

execute 'add samba user' do
  command 'printf "vagrant\nvagrant\n" | smbpasswd -a -s ' + node[:mdenvy][:user]
  not_if { system("pdbedit -L | grep \"^#{node[:mdenvy][:user]}\" > /dev/null") }
end

service 'smbd' do
  action :restart
end

service 'nmbd' do
  action :restart
end
