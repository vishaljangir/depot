require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
	setup do
		@user = users(:one)
	end
  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
  	# debugger
  	assert_difference('User.count') do
  		post users_url, params: { user: { name: 								'sam',
  																			password: 						'secret',
  																			password_confirmaion: 'secret' }}
  	assert_redirected_to users_url

  	end
  end

  test "should update user" do
  		# debugger
  		patch user_url(@user), params: { user: { name: 								 @user.name,
				  																		 password: 						 'secret',
				  																		 password_confirmaion: 'secret' }}
  	# end
  	# debugger
  	assert_redirected_to login_url
  end

end
