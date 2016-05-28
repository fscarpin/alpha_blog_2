require "test_helper"

class SignUpIntegrationTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: "foo", password: "temp123", email: "foo@example.com", admin: true)
  end

  test "get new category form and create category" do
    login_as @user
    # New Article
    get new_article_path
    assert_template "articles/new"
    # Create a new article
    assert_difference "Article.count", 1 do
      post_via_redirect articles_path, article: {title: "This is a new title", description: "This is a new description"}
    end
    # Make sure the right page is showing up
    assert_template "articles/show"
    assert_match "This is a new title", response.body
  end

end
