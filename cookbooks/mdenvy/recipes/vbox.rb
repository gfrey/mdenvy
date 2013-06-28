## Make sure guest-additions are installed.
package 'virtualbox-guest-utils'

## Set timezone to value specified
file "/etc/timezone" do
  content node[:mdenvy][:timezone]
end

execute 'set timezeone' do
  command "dpkg-reconfigure -f noninteractive tzdata"
end
