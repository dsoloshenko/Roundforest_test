require 'test_helper'
class CategoryTest < ActiveSupport::TestCase
  fixtures :categories
  fixtures :products

  test "category name must not be empty" do
    category = Category.new
    assert category.invalid?
    assert category.errors[:name].any?
  end

  test "category is not valid without a unique name" do
    category = Category.new(:name => categories(:category).name)
    assert !category.save
    assert_equal "has already been taken", category.errors[:name].join('; ')
  end

  test "category active scope sorted by first letter in name" do
    assert_equal Category.active.pluck(:name).uniq, Category.all.pluck(:name).sort_by(&:downcase)
  end

  test "category active scope does not return categories without products" do
    category = Category.new(:name => "Tomatos", :id => 100)
    assert category.save
    assert_not_equal Category.active.active.pluck(:name).uniq, Category.order("lower(name) ASC").all.pluck(:name)
    product = Product.new(:name => "Tomato", :id => 11, :category_id => 100, :price => 22, :image => "long.png")
    assert product.save
    assert_equal Category.active.active.pluck(:name).uniq, Category.order("lower(name) ASC").all.pluck(:name)
  end

end