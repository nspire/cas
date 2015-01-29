class AdminsController < ApplicationController
  
  layout false
  
  def index
    @admins = Admin.sorted
  end

  def show
    respond_to do |format|
      format.html{
        @admin = Admin.find_by_id(params[:id])  
      }
      format.json{
        @admin = Admin.find_by_id(params[:id])  
        render json: @admin
      }
    end
  end

  def new
    @admin = Admin.new
  end

  def create
    # Instantiate the object
    # generate a random token. 
    # @TODO: check if the token already exists
    token = SecureRandom.base64
    # token_usage is automatically set to 0
    @admin = Admin.new(admin_params)
    @admin[:token] = token
    # Data validation: @TODO Ensure that valid data is entered
    # Save
    if Admin.validData(@admin) && @admin.save
      # Redirect
      flash[:notice] = "Admin created successfully"
      redirect_to(:action => 'index')
    else
      # Failed Save
      flash[:error] = "Form parameters do not meet requirements!"
      render('new')
    end
  end

  def edit
    @admin = Admin.find(params[:id])
  end

  def update
    # Find the admin from the db
    @admin = Admin.find(params[:id])
    if @admin.update_attributes(admin_params)
      flash[:notice] = "Admin updated"
      redirect_to(:action => 'index')
    else
      flash[:error] = "Could not finish update request"
      render('edit')
  end

  def delete
    @admin = Admin.find(params[:id])
  end

  def delete_user
    # Delete the user
    admin = Admin.find(params[:id]).destroy
    flash[:notice] = "Admin #{admin.fname} #{admin.lname} was deleted"
    redirect_to(:action => 'index')
  end

end

private
  def admin_params
    params.require(:admin).permit(:fname, :lname, :username, :email, :organization, :password, :user_limit, :token)
  end
end
