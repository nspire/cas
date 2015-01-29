class AlterAdmins < ActiveRecord::Migration
  def up
    add_column("admins", "fname", :string, :limit => 25)
    add_column("admins", "lname", :string, :limit => 25, :after => "fname")
    add_column("admins", "organization", :string, :limit => 25, :after => "lname")
    add_index("admins", "fname")
  end

  def down
    remove_index("admins", "fname")
    add_column("admins", "lname")
    add_column("admins", "organization")
    add_column("admins", "fname")
  end
end
