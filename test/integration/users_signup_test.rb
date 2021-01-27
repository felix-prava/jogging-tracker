require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
=begin
    test "valid signup information" do
        get signup_path
        assert_difference 'User.count', 1 do
        post users_path, params: { user: { name: "Felix-Mihai",
                                            email: "felix@yahoo.com",
                                            password: "password",
                                            password_confirmation: "password" } }
        end
    end
=end
    test "invalid signup information" do
        get signup_path
        assert_no_difference 'User.count' do
        post users_path, params: { user: { name: "",
                                            email: "user@invalid",
                                            password: "abc",
                                            password_confirmation: "def" } }
        end
        assert_template 'users/new'
    end

end