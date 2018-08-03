class RemoveArticleCategories < ActiveRecord::Migration
  def up	
  	drop_table :article_categories
  end

  def down
  	fail ActiveRecord::IrreversibleMigration
  end
end
