class CreateArticleCategoriesTable < ActiveRecord::Migration
  def change
    create_table :article_categories_tables do |t|
      t.integer :article_id
      t.integer :category_id
    end
  end
end
