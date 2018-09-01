class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :article_categories
  has_many :categories, through: :article_categories
  mount_uploader :image, ImageUploader
  after_commit :remove_previously_stored_image, on: :update
  validates :title, presence: true, length: {minimum: 3, maximum:20}
  validates :description, presence: true, length: {minimum: 10, maximum: 10000}
  validates :user_id, presence: true

  def self.search(p)
  	p.strip!
  	p.downcase!
  	res = where("title like ?", "%#{p}%")
  	return nil unless res
  	res
  end
  
end
