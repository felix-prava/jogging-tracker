require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:Felix)
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "Felix Felix",
                                              email: "felix24@yahoo.com",
                                              password: "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal @user.name, "Felix Felix" 
    assert_equal @user.email, "felix24@yahoo.com"
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "This will not be edited",
                                              email: "email@wrong",
                                              password: "abc",
                                              password_confirmation: "def" } }
    assert_not_equal @user.name, "This will not be edited"
    assert_not_equal @user.email, "email@wrong"
    assert_template 'users/edit'
  end
end
