# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable, only: %i[create]
  before_action :set_comment, only: %i[destroy]

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.save!
    redirect_back(fallback_location: root_path)
  end

  def destroy
    correct_user(@comment) and return
    @comment.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def set_commentable
    type, id = request.path.split('/')[1, 2]
    @commentable =
      case type
      when 'reports'
        Report.find_by! id: id
      when 'books'
        Book.find_by! id: id
      end
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id)
  end
end
