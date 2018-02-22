class Category < ActiveRecord::Base
  has_many :products

  default_scope { order(:name) }

  validates :name, :presence => true
  validates :name, :uniqueness => true

end
