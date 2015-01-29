class AuthenticationController < ApplicationController

  layout false

  # Request:
    # {
    #   "admin_name":<string>,
    #   "password":<string>
    # }
  # Response:
    # {
    #   "status":<"success" or "failure">,
    #   "token":<string>,
    #   "token_usage":<integer>
    # }
  def admin
    response_hash = Authentication.authenticateAdminAgainstPassword(params[:username], params[:password])
    render json: response_hash
  end

  # Request:
    # {
    #   "admin_name":<string>,
    #   "token":<string>
    # }
  # Response:
    # {
    #    "status": <"success" or "failure">,
    #    "token_usage": <integer>,
    #    "user_list": [ <user array> ]
    # }

  def getUsers
    response_hash = Authentication.getUserList(params[:admin_name], params[:token])
    render json: response_hash
  end

  # Request:
    # {
    #   "admin_name":<string>,
    #   "token":<string>
    #   "user_data":{
    #     "username":<string>,
    #     "password":<string>  
    #   }
    # }

  def validateUser
    response_hash = Authentication.isValidUser(params)
    render json: response_hash
  end


end