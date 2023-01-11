# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :posal_code, length: { maximum: 7, message: '7文字以内で入力(ハイフン不要)' }
  validates :address, length: { maximum: 40, message: '40文字以内で入力' }
  validates :profile, length: { maximum: 200, message: '200文字以内で入力' }

  paginates_per 5
end
