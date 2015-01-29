class Admin < ActiveRecord::Base
  has_many :users
  
  scope :sorted, lambda { order("admins.username ASC") }
  scope :newest_first, lambda { order("admins.created_at DESC") }
  scope :search, lambda { |query|
    where (["name LIKE ?", "%#{query}%"])
  }

  def self.validData(data_hash)
    if Admin.notEmpty(data_hash) && Admin.notExist(data_hash)
      return true
    else
      return false
    end
  end

  # Check the hash for empty fields
  def self.notEmpty(data_hash)
    if data_hash[:password] != "" && data_hash[:username] != "" && data_hash[:fname] != "" && data_hash[:organization] != "" && data_hash[:email] != ""
      return true
    else
      return false
    end
  end

  # Check the hash for conflicting fields
  def self.notExist(data_hash)
    if Admin.where(["username = ?", data_hash[:username]]).empty? && Admin.where(["email = ?", data_hash[:email]]).empty?
      return true
    else
      return false
    end
  end
end
