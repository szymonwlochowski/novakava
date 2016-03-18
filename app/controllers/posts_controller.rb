class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :owned_post, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = 'You have successfully created a new post.'
      redirect_to root_path
    else
      flash.now[:alert] = 'An error occured. Your post has not been created.'
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = 'You have successfully updated your post.'
      redirect_to posts_path
    else
      flash.now[:alert] = 'An error occured. Your post has not been updated.'
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:success] = 'You have successfully deleted your post.'
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:image, :caption)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def owned_post
    if @post.user != current_user
      flash[:alert] = "You can't do anything with this post, dumbo."
      redirect_to root_path
    end
  end
end
