class Connection < ActiveRecord::Base
  validates_presence_of :name, :provider, :connection_string, :timeout
end
