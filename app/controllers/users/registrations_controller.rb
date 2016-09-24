class Users::RegistrationsController < Devise::RegistrationsController
before_action :configure_sign_up_params, only: [:create]
respond_to :json

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
