class Authentication < ActiveRecord::Base

  def self.authenticateAdminAgainstPassword(username, password)
    # Verifies the current user and token pair against the database
    response_hash = {}
    response_hash[:status] = "failure"
    response_hash[:token] = nil
    
    admin_found = Admin.where(:username => username).first

    if admin_found != nil && admin_found.password == password

      token = admin_found.token
      token_usage = admin_found.token_usage
      response_hash[:token] = token
      response_hash[:token_usage] = token_usage
      response_hash[:status] = "success"

    end    
    return response_hash
    # @TODO: Increase the token usage counter
  end

  def self.getUserList(username, token)
    response_hash = {}
    response_hash[:status] = "failure"
    response_hash[:user_list] = []
    found_admin = Admin.where(:username => username).first

    if found_admin != nil && found_admin.token == token

      user_list = found_admin.users
      response_hash[:status] = "success"
      response_hash[:user_list] = user_list
      response_hash[:token_usage] = found_admin.token_usage + 1
      found_admin[:token_usage] = found_admin[:token_usage] + 1
      found_admin.save

    end
    return response_hash
  end

  # {
    #   "admin_name":<string>,
    #   "token":<string>
    #   "user_data":{
    #     "username":<string>,
    #     "password":<string>  
    #   }
  # }
  def self.isValidUser(request_hash)
    response_hash = {}
    response_hash[:status] = "failure"
    if adminExists(request_hash[:admin_name]) && getAdmin(request_hash[:admin_name]).token == request_hash[:token]
      if userExists(request_hash[:user_data][:username]) && getSingleUser(request_hash[:user_data][:username]).password == request_hash[:user_data][:password]
        response_hash[:status] = "success"
        response_hash[:user_data] = getSingleUser(request_hash[:user_data][:username])
      end
    end
    response_hash[:token_usage] = increaseTokenUsage(request_hash[:admin_name])
    return response_hash
  end

  private 

  def self.increaseTokenUsage(username)
    if !adminExists(username)
      return 0
    end
    admin = getAdmin(username)
    admin.token_usage = admin.token_usage + 1
    admin.save
    return admin.token_usage
  end

  def self.authenticateAdminAgainstToken(username, token)
    return getAdmin(username) != nil && getAdmin(username).token = token
  end

  # Returns the admin
  def self.getAdmin(username)
    return Admin.where(:username => username).first
  end

  # Returns whether the Admin exists
  def self.adminExists(username)
    return Admin.where(:username => username).size != 0
  end

  # Returns the array of users for the admin
  def self.getUsers(adminName)
    if getAdmin(adminName) == nil
      return []
    end
    return getAdmin(adminName).users
  end

  def self.getSingleUser(username)
    return User.where(:username => username).first
  end

  def self.userExists(username)
    return User.where(:username => username).size != 0
  end

end


