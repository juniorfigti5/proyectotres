class AddUserIdToConstests < ActiveRecord::Migration[5.0]
  def change
    add_column :contests, :user_id, :integer
  end
end
