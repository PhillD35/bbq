class Subscription < ApplicationRecord
  EMAIL_FORMAT = /\A.+@.+\..+\z/

  belongs_to :event
  belongs_to :user, optional: true

  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email, presence: true, format: { with: EMAIL_FORMAT }, unless: -> { user.present? }

  validates :user, uniqueness: { scope: :event_id }, if: -> { user.present? }
  validates :user_email, uniqueness: { scope: :event_id }, unless: -> { user.present? }

  validate :email_taken, unless: -> { user.present? }

  def user_email
    return user.email if user.present?

    super
  end

  def user_name
    return user.name if user.present?

    super
  end

  private

  def email_taken
    errors.add(:user_email, :email_taken) if User.exists?(email: user_email)
  end
end
