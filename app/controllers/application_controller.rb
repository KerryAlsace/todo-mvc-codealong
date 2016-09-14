class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authentication_required
    if !logged_in?
      redirect_to login_path
    end
  end

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    # @current_user ||= this part is to make sure you don't have to query your database every time, that you save the current user and can reuse it while it's still the same user
  end

  # methods built in controllers do not permeate to action view, must add this as a helper method to use in view

  helper_method :current_user

end
