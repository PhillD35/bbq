class Event < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 255 }
  validates :title, presence: true
  validates :title, presence: true
end
