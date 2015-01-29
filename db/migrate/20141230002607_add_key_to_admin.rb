class AddKeyToAdmin < ActiveRecord::Migration
  def up
    add_column("admins", "user_id", :integer)
    add_index("admins", "user_id")
  end
  def down
    remove_column("admins", "user_id")
  end
end
