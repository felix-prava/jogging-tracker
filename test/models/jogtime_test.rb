require "test_helper"

class JogtimeTest < ActiveSupport::TestCase
  def setup
    @user = users(:Felix)
    # This code is not idiomatically correct.
    @jogtime = @user.jogtimes.build(minutes: 65, distance: 1.5, weekday: 2021-01-29)
  end

  test "should be valid" do
    assert @jogtime.valid?
  end

  test "user id should be present" do
    @jogtime.user_id = nil
    assert_not @jogtime.valid?
  end
    
end
