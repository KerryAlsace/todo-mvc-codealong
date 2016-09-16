class User < ApplicationRecord
  has_secure_password

  validates_presence_of :email, message: "Please enter an email address"
  validates_uniqueness_of :email, message: "That email is taken, please use another"

  def self.find_or_create_by_omniauth(auth_hash)
    if user = User.find_by(email: auth_hash["email"])
      return user
    else
      user = User.create(email: auth_hash["email"], password: SecureRandom.hex)
    end
  end

end
