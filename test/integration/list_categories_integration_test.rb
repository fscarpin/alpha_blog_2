require "test_helper"

class ListCategoriesIntegrationTest < ActionDispatch::IntegrationTest

  def setup
    @category = Category.create(name: "books")
    @category2 = Category.create(name: "tech")
  end

  test "should show categories list" do
    # Test if the index.html.erb is showed after a get request to categories_path
    get categories_path
    assert_template "categories/index"

    # Make sure the links for both categories are showed
    assert_select "a[href=?]", category_path(@category), text: @category.name
    assert_select "a[href=?]", category_path(@category2), text: @category2.name
  end

end
