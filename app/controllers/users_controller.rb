class UsersController < ApplicationController
  def index
    @uses = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end
  
  def destroy
  end
end
