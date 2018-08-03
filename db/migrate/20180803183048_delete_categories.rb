class DeleteCategories < ActiveRecord::Migration
  def up
  	drop_table :categories
  end

  def down
  	fail ActiveRecord::IrreversibleMigration
  end
end
