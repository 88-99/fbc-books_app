# frozen_string_literal: true

class FollowsController < ApplicationController
  def create
    following = current_user.follow(params[:format])
    redirect_back fallback_location: users_path, notice: t('controllers.success.notice_follow')
  end

  def destroy
    following = current_user.unfollow(params[:id])
    redirect_back fallback_location: users_path, notice: t('controllers.success.notice_unfollow')
  end
end
