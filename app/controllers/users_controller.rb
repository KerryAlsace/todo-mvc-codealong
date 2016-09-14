class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    # raise params.inspect -- always do first to double check that the form is correctly submitting data to the controller
    @user = User.new
    @user.email = params[:user][:email]
    if @user.save
      redirect_to root_path
    else
      render :new
    end
  end

end
