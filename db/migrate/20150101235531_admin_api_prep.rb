class AdminApiPrep < ActiveRecord::Migration
  def up
    # token should not be used as a lookup. If you do want that ability, 
    # then an index should be added to the token column to increase lookup speed
    add_column("admins", "token", :string, :null => false)
    add_column("admins", "token_usage", :integer, :default => 0)
  end
  def down
    remove_column("admins", "token_usage")
    remove_column("admins", "token")
  end
end
