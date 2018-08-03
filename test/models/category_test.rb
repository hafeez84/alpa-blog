require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
	
	def setup
		@cat = Category.new(name: "sports")
	end

	test "category should be valid" do
		assert @cat.valid?
	end

	test "name should be present" do
		@cat.name = ""
		assert_not @cat.valid?
	end

	test "name should be unique" do
		@cat.save
		cat2 = Category.new(name: "sports")
		assert_not cat2.valid?
	end

	test "name should not be too long" do
		@cat.name = "a"*26
		assert_not @cat.valid?
	end

	test "name should not be too short" do
		@cat.name = "aa"
		assert_not @cat.valid?
	end

end