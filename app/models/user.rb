class User < ApplicationRecord
  attr_accessor :remember_token
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

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update remember_digest: User.digest(remember_token)
  end

  def authenticated? remember_token
    return false unless remember_digest

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update remember_digest: nil
  end
end
