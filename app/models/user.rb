# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  before_create :create_digest
  has_many :events, { class_name: :Event, foreign_key: :creator_id }

  validates :email, uniqueness: true
  validates :password, length: { minimum: 3 }
  validates :email, :name, presence: true

  class << self
    def new_token
      SecureRandom.urlsafe_base64
    end

    def digest(token)
      Digest::SHA1.hexdigest(token.to_s)
    end
  end

  private

  def create_digest
    self.remember_token = User.digest(User.new_token)
  end
end