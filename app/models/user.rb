require 'bcrypt'
class User
  include Mongoid::Document
  has_many :portfolios
  # Allow us to hold a plain-text password in memory

  attr_accessor :password

  field :name, type: String
  field :username, type: String
  field :salt, type: String
  field :hashed_password, type: String

  validates :name, presence: true

  def authenticated? pwd
  	self.hashed_password ==
  	  BCrypt::Engine.hash_secret(pwd, self.salt)
  end

  before_save :hash_stuff

private
  def hash_stuff
  	self.salt = BCrypt::Engine.generate_salt
  	self.hashed_password =
  	  BCrypt::Engine.hash_secret self.password, self.salt
  	self.password = nil
  end
end
