class RelationsController < ApplicationController
  before_aciton :require_user_logged_in
  
  def create
    user = User.find(params[:follow_id])
    current_user.follow(user)
    flash[:success] = "ユーザーをフォローしました。"
    redirect_to user
  end

  def destroy
    user = User.find(params[:follow_id])
    curret_user.unfollow(user)
    flash[:success] = "ユーザーのフォロー解除しました。"
    redirect_to user
  end
end