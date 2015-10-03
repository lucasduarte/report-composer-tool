class AddForeignKeyToSimpleSql < ActiveRecord::Migration
  def change
      add_foreign_key :simple_sqls, :connections
      add_foreign_key :simple_sqls, :users
  end
end
