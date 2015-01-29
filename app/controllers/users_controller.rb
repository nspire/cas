class UsersController < ApplicationController
  
  layout false

  def index
    
  end

  def show
    respond_to do |format|
      format.html{
        @users = Admin.where(:username => session[:username]).first.users  
      }
      format.json{
        @users = Admin.where(:username => session[:username]).first.users  
        render json: @users
      }
    end
  end

  def new
  end

  def create
    # Do this with strong params instead
    puts
    if !params[:username].present? && !params[:password].present? && !params[:email].present?
      flash[:notice] = "Fill out the required information"
      redirect_to(:action => 'new')
    else
      user = User.new(:username => params[:username], :password => params[:password], :email => params[:email])
      user.save
      puts "Session ID: " + session[:username]
      admin = Admin.where(:username => session[:username]).first
      admin.users << user
      flash[:notice] = "User created"
      redirect_to(:controller => 'access', :action => 'index')
    end
  end

  def edit
  end

  def delete
    @user = User.find(params[:id])
  end

  def destroy
    user = User.find(params[:id]).destroy
    flash[:notice] = "User " + user.username + " was removed"
    redirect_to(:action => 'show')
  end
end

private
  def user_params
    params.require(:user).permit(:username, :password, :email)
  end

