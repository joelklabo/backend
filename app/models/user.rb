require 'bcrypt'

class User < ActiveRecord::Base

  validates :name, presence: true, length: { minimum: 1 }
  validates :email, presence: true, uniqueness: true
  validates :email, :email_format => {:message => 'invalid email'}
  validates :password_hash, :presence => {:message => 'invalid password'}

  @@minimum_password_length = 8

  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(new_password)
    unless new_password.length < @@minimum_password_length
      @password = BCrypt::Password.create(new_password)
      self.password_hash = @password
    end
  end

end
