class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(post_id: params[:post_id])
    @posts = Post.all.order('created_at DESC').includes(%i[user replies])

    if @like.save
      redirect_to request.referrer, notice: 'You liked a post.'
    else
      redirect_to request.referrer, alert: 'You cannot like this post twice.'
    end
  end

  def destroy
    like = Like.find_by(id: params[:id], user: current_user, post_id: params[:post_id])
    if like
      like.destroy
      redirect_to request.referrer, notice: 'You disliked a post'
    else
      redirect_to request.referrer, alert: 'You cannot dislike a post that you did not like before'
    end
  end
end
