require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  test "login with invalid information" do
   get login_path
   assert_template 'sessions/new'
   post login_path, params: { session: { email: "", password: "" } }
   assert_template 'sessions/new'
   assert_not flash.empty?
   get root_path
   assert flash.empty?
  end

  test "good link or not in header" do
    User.new(first_name: 'Toto', last_name: 'To', email: 'toto@gmail.com', password: 'foobar').save
    get root_path
    session[:user_id] = 980190962
    if assert !User.find(session[:user_id]).nil?

    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", new_user_path
    assert_select "a[href=?]", root_path
end

  end
end
