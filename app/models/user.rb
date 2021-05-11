class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  EMAIL_FORMAT = /\A.+@.+\..+\z/

  has_many :events, dependent: :destroy

  validates :name, presence: true, length: { maximum: 35 }
end
