class DropArticleCategoriestable < ActiveRecord::Migration
  def change
    drop_table :article_categories_tables
  end
end
