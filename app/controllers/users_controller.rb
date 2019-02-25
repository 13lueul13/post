class UsersController < ApplicationController
  before_action :require_user_logged_in, except: [:new, :create]
  before_action :correct_user, only: [:edit, :update]
  
  def index
    @users = User.where.not(id: 1).page(params[:page])
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order("created_at DESC").page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "登録しました。"
      redirect_to @user
    else
      flash[:danger] = "登録に失敗しました。"
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      flash[:success] = "変更しました。"
      redirect_to @user
    else
      flash.now[:danger] = "変更に失敗しました。"
      render :edit
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    
    flash[:success] = "退会処理が完了しました。"
    redirect_to root_url
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def likes
    @user = User.find(params[:id])
    @like_posts = @user.like_posts.order('created_at DESC').page(params[:page])
    counts(@user)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :email_confirmation, :password, :password_confirmation, :date_of_birth, :comment)
  end
  
  def correct_user
    @user = User.find(params[:id])
    unless current_user == @user
      redirect_to root_url
    end
  end
end
