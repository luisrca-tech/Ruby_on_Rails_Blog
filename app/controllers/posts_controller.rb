class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
  end

  def my_posts
    @posts = current_user.posts.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    
    if @post.save
      redirect_to my_posts_path, notice: "Post created successfully"
    else
      flash.now[:alert] = "Error: #{@post.errors.full_messages.join(', ')}"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to my_posts_path, notice: "Post updated successfully"
    else
      flash.now[:alert] = "Error: #{@post.errors.full_messages.join(', ')}"
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @post.destroy
    redirect_to my_posts_path, notice: "Post deleted successfully"
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :body, :image)
  end

  def set_post
    @post = Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to posts_path, alert: "Post not found"
  end
end
