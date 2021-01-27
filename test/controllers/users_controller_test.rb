require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:Felix)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { email: "user@invalid",
                                        name: "",
                                        password: "abc",
                                        password_confirmation: "abc"} }
    end
    
    #assert_redirected_to users_url
    assert_template 'users/new'
  end

  test "should create user" do
    get signup_path
    assert_difference('User.count') do
      post users_path, params: { user: { name: @user.name, email: "testee_test@yahoo.com", password: "password", password_confirmation: "password" } }
    end
    
    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_path(@user), params: { user: { name: @user.name, email: @user.email, password: "password", password_confirmation: "password" } }
    assert_redirected_to user_path(@user)
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
