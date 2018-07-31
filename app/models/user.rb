class User < ActiveRecord::Base
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  mount_uploader :avatar, AvatarUploader
  after_commit :remove_previously_stored_avatar, on: :update
  before_save {self.email = email.downcase}
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: {minimum: 3, maximum: 10}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {minimum: 5, maximum: 100}, uniqueness: { case_sensitive: false }, format: {with: VALID_EMAIL_REGEX}

  has_secure_password

end
