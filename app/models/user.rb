class User < ActiveRecord::Base
	has_many :secrets
	has_many :likes, dependent: :destroy
	has_many :secrets_liked, through: :likes, source: :secrets
  has_secure_password
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false}, format: { with: EMAIL_REGEX }
  validates :password, confirmation: true

  before_save do
  	self.email.downcase!
  end
end
