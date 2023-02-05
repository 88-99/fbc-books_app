# frozen_string_literal: true

class FollowsController < ApplicationController
  def create
    current_user.follow(params[:format])
    redirect_to user_path(params[:format]), notice: t('controllers.success.notice_follow')
  end

  def destroy
    current_user.unfollow(params[:id])
    redirect_to user_path(params[:id]), notice: t('controllers.success.notice_unfollow')
  end
end
