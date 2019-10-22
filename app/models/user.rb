class User < ApplicationRecord
  USER_ATTR = %i(name email password password_confirmation).freeze
  VALID_EMAIL_REGEX = Settings.validates_email_regex

  before_save{email.downcase!}

  validates :name, presence: true, length: {maximum: Settings.max_length_name}
  validates :email, presence: true,
                    length: {maximum: Settings.max_length_email},
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: true
  validates :password, presence: true,
                    length: {minimum: Settings.min_length_pass}
  has_secure_password
end
