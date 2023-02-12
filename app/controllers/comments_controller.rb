# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :comment_params
  before_action :set_commentable

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.save!
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

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id)
  end
end
