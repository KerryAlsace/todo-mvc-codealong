class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.create(email: params[:email])
    session[:user_id] = user.id

    redirect_to root_path
  end

  def destroy
    reset_session
    redirect_to login_path
  end

end
