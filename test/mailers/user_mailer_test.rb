require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "delete_notification" do
    mail = UserMailer.delete_notification
    assert_equal "Delete notification", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
