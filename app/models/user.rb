class User < ApplicationRecord
  validates_presence_of :email, message: "Please enter an email address"
  validates_uniqueness_of :email, message: "That email is taken, please use another"
end