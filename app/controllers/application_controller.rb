class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def check_moo
    render nothing: true, status: :unauthorized if current_user.is_moo? == false
  end
end
