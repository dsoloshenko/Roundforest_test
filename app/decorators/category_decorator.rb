class CategoryDecorator < Draper::Decorator
  delegate_all

  def category_image
    products = object.products.order(score: :desc)
    products.first.image unless products.first.blank?
  end

end