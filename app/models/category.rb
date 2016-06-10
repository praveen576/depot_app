class Category < ActiveRecord::Base
  has_many :products

  validates :name, presence: true

  accepts_nested_attributes_for :products, reject_if: :all_blank, allow_destroy: true
end
