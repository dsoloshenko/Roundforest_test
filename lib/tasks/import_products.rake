# Run service that import products and categories from json files to corresponding models
namespace :roundforest_store do
  desc "importing products and categories from files to DB"
  task import_products: :environment do
    ImportProductsService.new.perform
  end
end