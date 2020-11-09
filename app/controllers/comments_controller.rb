class CommentsController < ApplicationController
  before_action :find_commentable
  before_action :find_comment, only: [:update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @comment = Comment.new
  end

  def create
    hotel_id = if params[:comment_id]
                  params[:comment][:hotel_id]
                else
                  params[:hotel_id]
                end
    if !@commentable
      flash[:danger] = t "error_parrent_comment_not_found"
      redirect_to hotel_url(hotel_id)
    else
      @comment = @commentable.comments.new comment_params
      if !@comment.save
        flash[:danger] = t "error_create_comment"
        redirect_to hotel_url(hotel_id)
      end
    end
  end

  def edit; end

  def update
    @comment.update_attributes body: params[:comment][:body]
  end

  def destroy
    return if @comment.destroy
    flash.now[:danger] = t "error_delete_comment"
  end

  private

  def comment_params
    params.require(:comment).permit :body, :user_id
  end

  def find_commentable
    @commentable = if params[:comment_id]
                     Comment.find_by id: params[:comment_id]
                   else
                     Hotel.find_by id: params[:hotel_id]
    end
  end

  def find_comment
    @comment = Comment.find_by id: params[:id]

    return if @comment
    flash.now[:danger] = t "error_comment_not_found"
    redirect_to hotels_url
  end

  def correct_user
    unless current_user.id == @comment.user.id || current_user.id == 1
      redirect_to hotels_url
    end
  end
end
