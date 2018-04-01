require 'test_helper'

class ConvertMailerTest < ActionMailer::TestCase
  test "singup_confirmation" do
    mail = ConvertMailer.singup_confirmation
    assert_equal "Singup confirmation", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
