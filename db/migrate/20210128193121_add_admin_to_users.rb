class AddAdminToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :admin, :boolean, default: false
    change_column :users, :manager, :boolean, default: false
  end
end
