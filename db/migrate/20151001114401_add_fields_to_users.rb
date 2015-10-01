class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :login, :string, limit: 30
    add_index :users, :login, :unique => true
  end
end
