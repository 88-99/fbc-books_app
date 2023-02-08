# frozen_string_literal: true

class FollowingsController < ApplicationController
  def create
    current_user.active_follows.create!(followed_id: params[:user_id])
    redirect_to user_path(params[:user_id]), notice: t('controllers.success.notice_follow')
  end

  def destroy
    following = current_user.active_follows.find_by!(followed_id: params[:user_id])
    following.destroy
    redirect_to user_path(params[:user_id]), notice: t('controllers.success.notice_unfollow')
  end
end
