# frozen_string_literal: true

class FollowingsController < ApplicationController
  def create
    following = current_user.active_follows.build(followed_id: params[:user_id])
    following.save
    redirect_to user_path(params[:user_id]), notice: t('controllers.success.notice_follow')
  end

  def destroy
    following = current_user.active_follows.find_by!(followed_id: params[:user_id])
    following.delete
    redirect_to user_path(params[:user_id]), notice: t('controllers.success.notice_unfollow')
  end
end
