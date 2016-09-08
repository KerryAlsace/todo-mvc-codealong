class ListsController < ApplicationController

  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  def create
    @list = List.new
    @list.name = params[:list][:name]
    @list.save

    redirect_to list_url(@list)
  end

end
