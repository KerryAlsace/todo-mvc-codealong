class ListsController < ApplicationController

  def index
    # raise session[:user_id].inspect
    if session[:user_id].present?
      @list = List.new
      @lists = List.all
    else
      redirect_to root_path
    end
  end

  def show
    @list = List.find(params[:id])
    @item = Item.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to list_url(@list)
    else
      @lists = List.all
      render :index
    end
  end

  private
    def list_params
      params.require(:list).permit(:name)
    end

end
