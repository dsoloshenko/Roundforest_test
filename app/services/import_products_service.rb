require 'json'

# Service for importing produacts and categories models from json files

class ImportProductsService

  CATEGORIES_URL = 'vendor/products/categories.json'
  PRODUCTS_URL = 'vendor/products/products.json'

  # Read jsom from files and parse it to @categories and @products
  def initialize
    categories_file = File.read(CATEGORIES_URL)
    products_file = File.read(PRODUCTS_URL)
    @categories = JSON.parse(categories_file)
    @products = JSON.parse(products_file)
  end

  def perform
    create_categories
    create_products
  end

  private

  def create_categories
    @categories.each do |catalog_name|
     Category.create(name: catalog_name) if Category.find_by_name(catalog_name).blank?
    end
  end

  def create_products
    @products.each do |product|
      # In case of case discrepancies in categories we transform it to lowercase
       category = Category.where('lower(name) = ?', product["category"].downcase).first
       # Check if category exists in Categories collection if no (in case of grammatical and other errors) save this case to the file
      if category.present?
        category.products.create(
                         name: product["name"],
                         image: product["image"],
                         score: product["score"],
                         price: product["price"],
                         url: product["url"]
        )
      else
        File.open('vendor/products/errors.txt', 'a+') { |file| file.write("||  Not found category: product name: #{product["name"]}, product  category:  #{product["category"]}") }
      end
    end
  end
end