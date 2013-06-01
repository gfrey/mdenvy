
def whyrun_supported?
  true
end

action :create do
  if @current_resource.exists
    Chef::Log.info "#{@new_resource} already exists - nothing to do."
  else
    converge_by("Create #{@new_resource}") do
      create_git_config
    end
  end
end

def load_current_resource
  @current_resource = Chef::Resource::MdenvyGitconfig.new(@new_resource.name)
  @current_resource.name(@new_resource.name)
  @current_resource.user(@new_resource.user)
  @current_resource.email(@new_resource.email)
  @current_resource.username(@new_resource.username)
  @current_resource.exists = ::File.exists?("home/#{@new_resource.user}/.gitconfig")
end

private

def create_git_config
  template "/home/#{new_resource.user}/.gitconfig" do
    cookbook "mdenvy"
    source "gitconfig.erb"
    owner new_resource.user
    group "users"
    variables({ email: new_resource.email,
                username: new_resource.username })
  end
end
