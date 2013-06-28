
actions :create

default_action :create

attribute :repository, :kind_of => String, :name_attribute => true, :required => true
attribute :user,       :kind_of => String, :required => true
attribute :path,       :kind_of => String
attribute :branch,     :kind_of => String

attr_accessor :exists
