class Comment < ActiveRecord::Base
  belongs_to :article
  belongs_to :user
  validates :body, presence: true, length: {minimum: 3, maximum: 50}
end
