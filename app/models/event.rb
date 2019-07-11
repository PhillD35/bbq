class Event < ApplicationRecord
  belongs_to :user

  has_many :comments
  has_many :photos

  has_many :subscriptions
  has_many :subscribers, through: :subscriptions, source: :user

  validates :title, presence: true, length: { maximum: 255 }
  validates :address, presence: true
  validates :datetime, presence: true

  after_validation :strip_address

  def visitors
    (subscribers + [user]).uniq
  end

  def pincode_valid?(pin2chek)
    pincode == pin2chek
  end

  def strip_address
    self.address.strip!
  end
end
