require "test_helper"

class CreateCategoriesIntegrationTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: "foo", password: "temp123", email: "foo@example.com", admin: true)
  end

  test "get new category form and create category" do
    login_as @user
    # Test if the new.html.erb is showed after a get request to new_category_path
    get new_category_path
    assert_template "categories/new"
    # Test if the Category.count was increased by one after saving a new category
    assert_difference "Category.count", 1 do
      post_via_redirect categories_path, category: {name: "sports"}
    end
    # Make sure the sports category is showed in the category list after the category was created
    assert_template "categories/index"
    assert_match "sports", response.body
  end

  test "invalid category submission should show flash errors" do
    login_as @user
    # Test if the new.html.erb is showed after a get request to new_category_path
    get new_category_path
    assert_template "categories/new"
    # Test if the Category.count doesn't change after trying o create a category with an empty name
    assert_no_difference "Category.count" do
      post categories_path, category: {name: " "}
    end
    # Make sure the alert is showed when the category name is empty
    assert_template "categories/new"
    assert_select "div.alert.alert-danger"
  end

end
