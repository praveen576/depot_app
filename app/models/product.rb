class Product < ActiveRecord::Base

  has_many :line_items
  has_many :orders, through: :line_items
  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :description, length: { minimum: 10 }
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true
  validates :title, length: { minimum: 10 }

  has_attached_file :image, styles: { small: "100*100>" },
    url: "/assets/products/:id/:style/:basename.:extension",
    path: ":rails_root/public/assets/products/:id/:style/:basename.:extension"
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  private

  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(base: 'Line Items present')
      return false
    end
  end
end

