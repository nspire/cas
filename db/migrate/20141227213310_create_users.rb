class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      # Foriegn key to refer to the admin under which this user is contained
      t.integer "admin_id" 
      t.string "username", :null => false, :limit => 15
      t.string "password", :null => false
      t.string "email", :null => false
      t.timestamps
    end
    add_index("users", "admin_id")
  end

  def down
    drop_table :users
  end

end
