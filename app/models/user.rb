class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :posal_code, length: { maximum: 7 }
  validates :address, length: { maximum: 40 }
  validates :profile, length: { maximum: 200 }

  paginates_per 5
end
