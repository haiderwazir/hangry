class ApplicationController < ActionController::API
  # protect_from_forgery with: :exception
  respond_to :json

  def check_moo
    render :json => {:error => 'Unauthorized', :message => 'Not authorized to perform the action.'}, status: 401 if current_user.is_moo? == false
  end

  private

	  def invalid_login_attempt
	    warden.custom_failure!
	    render :json => {:error => 'Unauthorized'}, status: 401
	  end

	  def authenticate_user_from_token!
	    user_email = request.headers['HTTP_EMAILADDRESS'].presence
	    @user = user_email && User.where(email: user_email).first
	    # Notice how we use Devise.secure_compare to compare the token
	    # in the database with the token given in the params, mitigating
	    # timing attacks.
	    if @user && Devise.secure_compare(@user.authentication_token, request.headers['HTTP_AUTHENTICATIONTOKEN'])
	      sign_in @user, store: false
	    else
	      invalid_login_attempt
	    end
	  end

end
