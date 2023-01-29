# frozen_string_literal: true

class FollowsController < ApplicationController
  def create
    following = current_user.follow(params[:format])
    redirect_to request.referer, notice: 'ユーザーをフォローしました' if following.save
  end

  def destroy
    following = current_user.unfollow(params[:id])
    redirect_to request.referer, notice: 'ユーザーのフォローを解除しました' if following.destroy
  end
end
