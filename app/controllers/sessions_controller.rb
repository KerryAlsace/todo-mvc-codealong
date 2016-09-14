class SessionsController < ApplicationController

  def new
  end

  def create
    # raise cookies.inspect --> let's you check out the cookies
    user = User.find_by(email: params[:email])
    session[:user_id] = user.id

    redirect_to root_path
  end

end
