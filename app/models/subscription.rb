class Subscription < ApplicationRecord
  belongs_to :event, optional: true
  belongs_to :user, optional: true

  validates :event, presence: true, unless: :user_present?
  validates :user_email, presence: true, format: { with: /\A.+@.+\..+\z/ }, unless: :user_present?

  validates :user, uniqueness: {scope: :event_id}, if: :user_present?
  validates :user_email, uniqueness: {scope: :event_id}, unless: :user_present?

  validate :your_event
  validate :ensure_uniq_email, unless: :user_present?

  before_validation :email_downcase, unless: :user_present?

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

  private

  def email_downcase
    user_email.downcase! if user_email.present?
  end

  def your_event
    if user == event.user
      errors.add(:user_id, :owned)
    end
  end

  def ensure_uniq_email
    unless User.where(email: self.user_email).empty?
      errors.add(:user_email, :taken)
    end
  end
end
