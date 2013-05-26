
actions :create

default_action :create

attribute :user,     :kind_of => String, :name_attribute => true, :required => true
attribute :username, :kind_of => String, :required => true
attribute :email,    :kind_of => String, :required => true

attr_accessor :exists
