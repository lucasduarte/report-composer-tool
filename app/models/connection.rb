class Connection < ActiveRecord::Base
  validates_presence_of :name, :provider, :connection_string, :timeout

  has_many :simple_sql

  CONNECTORS = ['MySQL', 'SQL Server', 'Oracle', 'PostgreSQL']

  def to_s
    self.name
  end
end
