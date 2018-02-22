require 'test_helper'
class CategoryTest < ActiveSupport::TestCase
  fixtures :categories

  test "category name must not be empty" do
    category = Category.new
    assert category.invalid?
    assert category.errors[:name].any?
  end

  test "category is not valid without a unique name" do
    category = Category.new(:name => categories(:category).name)
    assert !category.save
    assert_equal "has already been taken", category.errors[:title].join('; ')
  end
end