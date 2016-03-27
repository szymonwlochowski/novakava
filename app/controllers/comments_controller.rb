class CommentsController < ApplicationController
  before_action :set_post

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      flash[:success] = 'You have successfully added a new comment.'
      redirect_to :back
    else
      flash.now[:alert] = 'An error occured. Your comment has not been added.'
      render root_path
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])

    @comment.destroy
    flash[:success] = 'You have successfully deleted your comment.'
    redirect_to root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
