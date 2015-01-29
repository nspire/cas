class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
       # Foriegn key to refer to the admin under which this user is contained 
      t.string "username", :null => false, :limit => 15
      t.string "password", :null => false
      t.string "email", :null => false
      t.integer "user_limit", :default => 100
      t.timestamps
    end
  end
end
