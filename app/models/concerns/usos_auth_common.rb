module UsosAuthCommon
  extend ActiveSupport::Concern

  def handle_request(access_token, access_token_secret, service_path)
    access_token = usos_authorizer.access_token(session, nil, access_token, access_token_secret)

    puts access_token

    response = access_token.get(service_path)
    JSON.parse(response.body)
  end

  private

  def usos_authorizer
    UsosAuthLib::UsosAuthorizer.new
  end
end
