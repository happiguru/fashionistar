class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /posts
  def index
    @likes = Like.all
    @posts = Post.all.order('created_at DESC').includes(%i[user replies])
    @users = User.order('created_at DESC').includes(%i[followed_users followers replies posts])
    return unless current_user

    @post = current_user.posts.new
    @not_followed = User.all.order('created_at DESC') - current_user.followed_users
    @not_followed.delete(current_user)

    ids = current_user.followed_users.ids
    ids << current_user.id
    @followed_and_user_posts = @posts.where(user_id: ids)
  end

  # GET /posts/1
  def show
    @likes = Like.all
    @users = User.all
    @posts = Post.all.order('created_at DESC')
    return unless current_user

    @post = current_user.posts.new
    @not_followed = User.all.order('created_at DESC') - current_user.followed_users
    @not_followed.delete(current_user)
    @followed_and_user_posts = @posts.where(user_id: current_user.followed_users.pluck(:id))
  end

  # GET /posts/new
  def new
    @post = current_user.posts.build
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts
  
  def create
    @post = current_user.posts.build(post_params)
    # @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path, notice: 'Post was successfully created.' }

      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /posts/1
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to posts_path, notice: 'Post was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /posts/1
 
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:postcontent)
    end
end
