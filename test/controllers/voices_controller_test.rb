require 'test_helper'

class VoicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @voice = voices(:one)
  end

  test "should get index" do
    get voices_url
    assert_response :success
  end

  test "should get new" do
    get new_voice_url
    assert_response :success
  end

  test "should create voice" do
    assert_difference('Voice.count') do
      post voices_url, params: { voice: { contest_id: @voice.contest_id, converted_file: @voice.converted_file, email: @voice.email, name: @voice.name, original_file: @voice.original_file, status_id: @voice.status_id, surname: @voice.surname, upload_date: @voice.upload_date } }
    end

    assert_redirected_to voice_url(Voice.last)
  end

  test "should show voice" do
    get voice_url(@voice)
    assert_response :success
  end

  test "should get edit" do
    get edit_voice_url(@voice)
    assert_response :success
  end

  test "should update voice" do
    patch voice_url(@voice), params: { voice: { contest_id: @voice.contest_id, converted_file: @voice.converted_file, email: @voice.email, name: @voice.name, original_file: @voice.original_file, status_id: @voice.status_id, surname: @voice.surname, upload_date: @voice.upload_date } }
    assert_redirected_to voice_url(@voice)
  end

  test "should destroy voice" do
    assert_difference('Voice.count', -1) do
      delete voice_url(@voice)
    end

    assert_redirected_to voices_url
  end
end
