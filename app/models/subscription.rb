class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :event, presence: true, unless: :user_present?
  validates :user_email, presence: true, format: { with: /\A.+@.+\..+\z/ }, unless: :user_present?

  validates :user, uniqueness: {scope: :event_id}, if: :user_present?
  validates :user_email, uniqueness: {scope: :event_id}, unless: :user_present?

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

  def user_email
    if user_present?
      user.email
    else
      super
    end
  end
end
