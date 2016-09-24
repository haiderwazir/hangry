module Tokenable
  extend ActiveSupport::Concern

  included do
    field :authentication_token, type: String
    field :authentication_token_created_at, type: Date

    before_save :ensure_authentication_token!
  end

  def ensure_authentication_token!
    return unless authentication_token.blank?
    self.authentication_token = generate_authentication_token
    self.authentication_token_created_at = Date.today
  end

  private

  def generate_authentication_token
    loop do
      token = SecureRandom.hex
      break token unless User.where(authentication_token: token).first
    end
  end
end
