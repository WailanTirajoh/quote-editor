class ApplicationController < ActionController::Base
  # def ensure_authenticated!
  #   return nil if current_user

  #   render_unauthorized
  # end

  # def current_user
  #   decode_token
  # end

  # def render_unauthorized
  #   render json: { error: 'User not authenticated' }, status: :unauthorized
  # end

  # private

  # def decode_token
  #   token = request.headers['Authorization']&.split(' ')&.last

  #   result = KlgJwtAuth::Jwk.validate_token_asymmetric(
  #     token, ENV['SSO_CERBERUS_PUBLIC_KEY_BASE64']
  #   )

  #   result[:payload] unless result&.key?(:error)
  # end
end
