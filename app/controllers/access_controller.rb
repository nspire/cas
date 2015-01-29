class AccessController < ApplicationController
  
  layout false

  def index
    # Displays the user
    if session[:user_id] = nil
      redirect_to(:action => "login")
    end
  end

  def login
    # Login form is presented
  end

  def attempt_login
    if params[:username].present? && params[:password].present?
      found_user = Admin.where(['username = ?', params[:username]]).first
      if found_user && found_user.password == params[:password]
        auth_user = found_user
      end
    end

    if auth_user
      puts "USER ID:" 
      puts auth_user.id
      session[:user_id] = auth_user.id
      session[:username] = auth_user.username
      flash[:notice] = "You are now logged in"
      redirect_to(:action => 'index')
    else
      flash[:notice] = "Invalid username/password"
      redirect_to(:action => 'login')
    end
  end

  def logout
    session[:user_id] = nil
    session[:username] = nil
    flash[:notice] = "Logged out"
    redirect_to(:action => "login")
  end
end