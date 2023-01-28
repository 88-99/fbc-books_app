# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :active_follows, foreign_key: 'follower_id', class_name: 'Follow', dependent: :destroy
  has_many :passive_follows, foreign_key: 'followed_id', class_name: 'Follow', dependent: :destroy
  has_many :following, through: :active_follows, source: :followed
  has_many :followers, through: :passive_follows, source: :follower
  has_one_attached :avatar

  def follow(user_id)
    active_follows.create(followed_id: user_id)
  end

  def unfollow(user_id)
    active_follows.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    following.include?(user)
  end
end
