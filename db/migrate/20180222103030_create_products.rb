class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :image
      t.string :url
      t.decimal :score
      t.integer :category_id
      t.decimal :price, :precision => 8, :scale => 2

      t.timestamps null: false
    end
    add_index :products, :category_id
    add_foreign_key :categories
  end
end
