class DropComment < ActiveRecord::Migration
	def up
		drop_table :comments	
	end

	def down
		fail ActiveRecord::IrreversibleMigration
	end

end
