class SessionsController < ApplicationController

  def new
  end

  def create
    if auth_hash = request.env["omniauth.auth"]["info"] # they logged in via OAuth
      if user = User.find_by(email: auth_hash["email"]) # they've logged into my app before using oath
        session[:user_id] = user.id
        redirect_to root_path
      else # they're a new user logging in with oath
        user = User.create(email: auth_hash["email"], password: SecureRandom.hex)
        session[:user_id] = user.id
        redirect_to root_path
      end
    else # they logged in normally
      user = User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to root_path
      else
        render 'sessions/new'
      end
    end
  end

  def destroy
    reset_session
    redirect_to login_path
  end

end
