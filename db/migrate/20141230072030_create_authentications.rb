class CreateAuthentications < ActiveRecord::Migration
  def up
    create_table :authentications do |t|
      t.string "admin_name"
      t.string "token"
      t.integer "usage", :default => 0
      t.timestamps
    end
  end

  def down
    drop_table :authentications
  end
end
