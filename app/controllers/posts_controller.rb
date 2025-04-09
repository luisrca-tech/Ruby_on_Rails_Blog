class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy	]

  def index
    @posts = Post.all
  end

  def my_posts
    @posts = current_user.posts
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save!
      redirect_to my_posts_path, notice: "Post created successfully"
    else
      render :new, alert: "Post not created"
    end
  end

  def edit
    set_post
  end

  def update
    if @post.update(post_params)
      redirect_to my_posts_path, notice: "Post updated successfully"
    else
      render :edit, alert: "Post not updated"
    end
  end

  def destroy
    if @post.destroy
      redirect_to my_posts_path, notice: "Post deleted successfully"
    else
      render :my_posts, alert: "Post not deleted"
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :description)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
