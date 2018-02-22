class Category < ActiveRecord::Base
  has_many :products

  scope :active, -> {(includes(:products).where.not(:products => { :id => nil })).order('lower("categories"."name")')}

  validates :name, :presence => true
  validates :name, :uniqueness => {:case_sensitive => false}

end
