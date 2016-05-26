class DropArticleCategoriesTable < ActiveRecord::Migration
  def down
    drop_table :article_categories_tables
  end
end
