class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :posal_code, :integer
    add_column :users, :address, :string
    add_column :users, :profile, :string
  end
end
