# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.with_attached_avatar.order(:id).page(params[:page])
  end

  def show
    @user = set_user
  end

  def followings
    @users = set_user.followings
    render 'following_list'
  end

  def followers
    @users = set_user.followers
    render 'follower_list'
  end

  private

  def set_user
    User.find(params[:id])
  end
end
