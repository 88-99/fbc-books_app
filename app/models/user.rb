# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :active_follows, foreign_key: 'follower_id', class_name: 'Follow', dependent: :destroy, inverse_of: 'follower'
  has_many :passive_follows, foreign_key: 'followed_id', class_name: 'Follow', dependent: :destroy, inverse_of: 'followed'
  has_many :followings, through: :active_follows, source: :followed
  has_many :followers, through: :passive_follows, source: :follower
  has_one_attached :avatar

  def following?(user)
    followings.include?(user)
  end
end
