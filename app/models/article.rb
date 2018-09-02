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
  	res1 = ( User.where("username like ?", "%#{p}%") + Article.where("title like ?", "%#{p}%") )
  	return nil unless res1
  	res1
  end
  
end
