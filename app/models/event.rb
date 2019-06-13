class Event < ApplicationRecord
  validates :title, presence: true, length: { 255 }
  validates :title, presence: true
  validates :title, presence: true
end
