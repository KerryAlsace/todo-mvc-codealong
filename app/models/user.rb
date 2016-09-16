class User < ApplicationRecord
  has_secure_password

  validates_presence_of :email, message: "Please enter an email address"
  validates_uniqueness_of :email, message: "That email is taken, please use another"

  def self.find_or_create_by_omniauth(auth_hash)
    self.where(email: auth_hash["email"]).first_or_create do |user|
      user.password = SecureRandom.hex
    end
  end

end
