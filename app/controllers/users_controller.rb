# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.with_attached_avatar.order(:id).page(params[:page])
  end

  def show
    @user = set_user
  end

  def followings
    @users = set_user.followings.with_attached_avatar
  end

  def followers
    @users = set_user.followers.with_attached_avatar
  end

  private

  def set_user
    User.find(params[:id])
  end
end
