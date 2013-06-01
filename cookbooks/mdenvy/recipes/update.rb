## Update the APT package cache
execute "update the apt package cache and upgrade installed packages" do
  command "apt-get update && apt-get upgrade -y"
  only_if do
    (! File.exists?('/var/lib/apt/periodic/update-success-stamp')) ||
       File.mtime('/var/lib/apt/periodic/update-success-stamp') < Time.now - 86400
  end
end
