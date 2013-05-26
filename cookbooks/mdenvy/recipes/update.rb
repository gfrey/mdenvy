## Change the apt mirror
execute "change apt mirrors to generic one" do
  command "sed -i 's|http://us.archive.ubuntu.com/ubuntu/|mirror://mirrors.ubuntu.com/mirrors.txt|' /etc/apt/sources.list"
end

## Update the APT package cache
execute "update the apt package cache and upgrade installed packages" do
  command "apt-get update && apt-get upgrade -y"
end
