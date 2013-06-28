
def whyrun_supported?
  true
end

action :create do
  if @current_resource.exists
    Chef::Log.info "#{@new_resource} already exists - nothing to do."
  else
    converge_by("Create #{@new_resource}") do
      checkout_repo
    end
  end
end

def load_current_resource
  @current_resource = Chef::Resource::MdenvyGit.new(@new_resource.repository)
  @current_resource.name(@new_resource.name)
  @current_resource.repository(@new_resource.repository)
  @current_resource.branch(@new_resource.branch)
  @current_resource.path(@new_resource.path)
  @current_resource.user(@new_resource.user)
  @current_resource.exists = ::File.directory?("/home/#{@new_resource.user}/development/{@new_resource.path}")
end

private

def checkout_repo
  user_home = "/home/#{new_resource.user}"
  repo_path = "#{user_home}/development/#{new_resource.path}"

  directory repo_path do
    mode "0755"
    recursive true
    action :create
  end

  git repo_path do
    repository new_resource.repository
    revision new_resource.branch unless new_resource.branch.nil?
    action :sync
  end

  execute "change ownership" do
    command "chown -R #{new_resource.user}:users #{user_home}/development"
  end
end
