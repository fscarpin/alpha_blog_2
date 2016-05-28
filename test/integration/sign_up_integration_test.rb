require "test_helper"

class SignUpIntegrationTest < ActionDispatch::IntegrationTest

  test "sign up user" do
    # Go to the sign up page
    get signup_path
    assert_template "users/new"
    #Signup the new user
    assert_difference "User.count", 1 do
      post_via_redirect users_path, user: {username: "foo", email: "foo@example.com", password: "password",
                                           confirm_your_password: "password"}
    end
    # Welcome user
    assert_template "users/show"
    assert_match "Welcome to foo's page", response.body
  end

end
