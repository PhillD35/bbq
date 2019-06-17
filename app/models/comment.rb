class Comment < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :body, presence: true

  validates :user_name, presence: true, unless: :user_present?

  def user_present?
    user.present?
  end

  def user_name
    if user_present?
      user.name
    else
      super
    end
  end
end
