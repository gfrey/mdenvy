# -*- mode: ruby -*-
# vi: set ft=ruby :

# Helper method to determine the ssh public key.
def get_ssh_public_key
  public_key = ['id_rsa.pub', 'id_dsa.pub']
    .map { |x| "#{ENV['HOME']}/.ssh/#{x}" }
    .select{ |x| File.exists?(x) }
    .first
  if public_key.nil?
    puts "No public key for ssh found! Create one using ssh-keygen in the standard location (~/.ssh/id_{dsa|rsa}.pub)."
    exit 42
  end
  File.open(public_key).read
end

Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "base"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://static.aldoborrero.com/vagrant/quantal64.box"

  # Boot with a GUI so you can see the screen. (Default is headless)
  # config.vm.boot_mode = :gui

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  config.vm.network :hostonly, "172.24.1.20"

  # Assign this VM to a bridged network, allowing you to connect directly to a
  # network using the host's network device. This makes the VM appear as another
  # physical device on your network.
  # config.vm.network :bridged

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  # config.vm.forward_port 80, 8080

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  # config.vm.share_folder "v-data", "/vagrant_data", "../data"

  config.ssh.forward_agent = true

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  #
  config.vm.provision :chef_solo do |chef|
    # Add base recipes.
    chef.add_recipe "base::hostname"
    chef.add_recipe "base::ssh-agent"
    chef.add_recipe "base::update"
    chef.add_recipe "base::packages"
    chef.add_recipe "base::user"

    # TODO: add your project's cookbooks. Make sure you check out code
    #       and make it available to the user that provisions the
    #       system.
    # chef.add_recipe "project"

    # Add user recipes.
    if chef.cookbooks_path.any? { |d| File.directory? "#{d}/#{ENV['USER']}" }
      chef.add_recipe ENV["USER"]
    end

    # Make user information available to chef.
    chef.json = { :mdenvy => { :user => ENV["USER"],
                               :pub_ssh_key => get_ssh_public_key,
                               :hostname => "sisyphos",
                               :ssh_servers => ["github.com"] } }
  end
end
