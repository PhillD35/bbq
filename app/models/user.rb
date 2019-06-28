class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :events
  has_many :comments
  has_many :subscriptions

  validates :name, presence: true, length: { maximum: 35 }

  before_validation :set_name, on: :create

  after_commit :link_subscriptions, on: :create

  mount_uploader :avatar, AvatarUploader

  private

  def set_name
    self.name = "user #{rand(1000)}" if self.name.blank?
  end

  def link_subscriptions
    subscriptions = Subscription.where(user_id: nil, user_email: self.email)

    unless subscriptions.empty?
      self.update(name: subscriptions.last.user_name)
      subscriptions.update_all(user_id: self.id)
    end
  end
end
