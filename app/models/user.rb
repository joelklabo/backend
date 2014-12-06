require 'bcrypt'

class User < ActiveRecord::Base

  validates :name, presence: true, length: { minimum: 1 }
  validates :email, :email_format => {:message => 'invalid email'} 
  validates :password_hash, presence: true

  @@minimum_password_length = 8

  attr_accessor :name, :email, :password_hash

  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_hash = @password
  end

  def self.valid_password(password)
    password.length >= @@minimum_password_length 
  end
    
end
