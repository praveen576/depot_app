class Product < ActiveRecord::Base

  has_many :line_items
  has_many :orders, through: :line_items
  belongs_to :category
  has_many :reviews, dependent: :destroy

  before_destroy :ensure_not_referenced_by_any_line_item
  after_destroy :remove_from_redis
  after_create :add_to_redis
  after_update :update_on_redis

  validates :title, :description, length: { minimum: 10 }
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true
  validates :title, length: { minimum: 10 }

  has_attached_file :image, styles: { small: "100*100>" },
    url: "/assets/products/:id/:style/:basename.:extension",
    path: ":rails_root/public/assets/products/:id/:style/:basename.:extension",
    default_url: '/assets/products/default/missing.png'
  

  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]


  def add_to_redis
    $redis.hset('product', "#{self.id}", { id: "#{self.id}", title: "#{self.title}", description: "#{self.description}", price: "#{self.price}", image_url: "#{self.image.url(:small)}" })
  end

  def remove_from_redis
    $redis.hdel('product', "#{self.id}")
  end
  
  def update_on_redis
    add_to_redis
  end

  def self.search(key)
    Product.where("title LIKE ?", "%#{key}%")
  end

  private
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors[:base] << 'Line Items present'
      return false
    end
  end
end
