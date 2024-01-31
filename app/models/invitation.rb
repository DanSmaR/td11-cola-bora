class Invitation < ApplicationRecord
  belongs_to :project

  validates :profile_email, presence: true
  validates :expiration_days, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validate :check_pending_invitation, on: :create
  validate :check_member, on: :create
  validate :days_to_date, on: :create

  enum status: { pending: 0, accepted: 1, declined: 2, cancelled: 3, expired: 4, removed: 5 }

  def pending!; end

  def cancelled!
    super if pending?
  end

  def expired!
    super if pending?
  end

  def accepted!
    super if pending?
  end

  def declined!
    super if pending?
  end

  def validate_expiration_days
    return unless expiration_date

    expired! if pending? && (Time.zone.today.after? expiration_date)
  end

  private

  def days_to_date
    self.expiration_date = expiration_days.days.from_now.to_date if expiration_days
  end

  def check_pending_invitation
    return unless Invitation.exists?(project:, profile_id:, status: :pending)

    errors.add(:base, I18n.t('invitations.create.pending_invitation'))
  end

  def check_member
    return unless project.member?(invitation_user)

    errors.add(:base, I18n.t('invitations.already_member'))
  end

  def invitation_user
    User.find_by(email: profile_email)
  end
end
