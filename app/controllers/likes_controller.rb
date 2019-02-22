class LikesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    current_user.fav(post)
    flash[:success] = "お気に入りに追加しました。"
    redirect_back(fallback_location: root_url)
  end

  def destroy
    post = Post.find(params[:post_id])
    current_user.unfav(post)
    flash[:success] = "お気に入りから削除しました。"
    redirect_back(fallback_location: root_url)
  end
end