class Product < ActiveRecord::Base

  attr_accessible :id, :image, :score, :name, :price, :url, :category_id

  belongs_to :category, class_name: 'Category', foreign_key: 'category_id'

  validates :name, :presence => true
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :image, format: {with: /\.(png|jpg|gif)\Z/i}

  default_scope { order(:score) }

end
