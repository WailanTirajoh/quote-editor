class ApplicationController < ActionController::Base
  def ensure_authenticated!
    return nil if current_user

    render_unauthorized
  end

  def current_user
    @current_user = decode_token
  end

  def render_unauthorized
    render json: { error: 'User not authenticated' }, status: :unauthorized
  end

  private

  def decode_token
    token = cookies['auth.access_token']&.split(' ')&.last
    decoded_token = JWT.decode token, nil, false
    if decoded_token[0]['exp'].to_i > Time.now.to_i
      refresh_token
      token = cookies['auth.access_token']&.split(' ')&.last
    end
    result = KlgJwtAuth::Jwk.validate_token_asymmetric(token, ENV['SSO_CERBERUS_PUBLIC_KEY_BASE64'])
    result[:payload] unless result&.key?(:error)
  end

  def refresh_token
    url = 'https://api-sandbox-cerberus.klgsys.com/ldap/User/refresh_token_asymmetric'
    data = { "refreshToken": cookies['auth.refresh_token']&.split(' ')&.last }
    headers = { 'accept' => 'text/plain', 'Content-Type' => 'application/json-patch+json' }
    response = Faraday.post(url, data.to_json, headers)

    cookies.permanent['auth.access_token'] = JSON.parse(response.body)['data']['accessToken'];
  end
end
