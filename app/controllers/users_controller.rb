class UsersController < ApplicationController
  #before_action :authenticate_user!
  def index
    @users = User.all
    #.includes(%i[replies posts likes followed_users followers])
    # @followed_and_user = current_user.followed_users
  end

  def new

  end

  def edit; end

  # PATCH/PUT /posts/1
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_path, notice: 'User Profile was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order('created_at DESC')
  end
end
