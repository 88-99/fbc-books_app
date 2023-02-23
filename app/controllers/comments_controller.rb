# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable, only: %i[create]
  before_action :set_comment, only: %i[destroy]
  before_action :correct_user, only: %i[destroy]

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.save!
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @comment.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def set_commentable
    @commentable =
      if params.key?('report_id')
        Report.find_by!(id: params[:report_id])
      elsif params.key?('book_id')
        Book.find_by!(id: params[:book_id])
      end
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id)
  end

  def correct_user
    redirect_to root_path, notice: t('controllers.common.notice_unauthorized') if @comment.user != current_user
  end
end
