module UsosAuthLib
  class UsosController < ActionController::Base
    def authorize_user
      authorization_url = usos_authorizer.authorize(session, request)

      redirect_to authorization_url, allow_other_host: true
    end

    def callback
      verifier = params[:oauth_verifier]
      access_token = usos_authorizer.access_token(session, verifier, nil, nil)

      response = access_token.get('/services/users/user?fields=id|first_name|last_name|email')
      parsed_response = JSON.parse(response.body)

      redirect_path = UsosAuthLib.configuration.redirect_path

      url = url_for(redirect_path)
      url << "?id=#{parsed_response['id']}&email=#{parsed_response['email']}"
      url << "&first_name=#{parsed_response['first_name']}&last_name=#{parsed_response['last_name']}"
      url << "&token=#{access_token.token}&secret=#{access_token.secret}"

      redirect_to url, allow_other_host: true
    end

    def handle_request(access_token, access_token_secret, service_path)
      access_token = usos_authorizer.access_token(session, nil, access_token, access_token_secret)

      response = access_token.get(service_path)
      render json: JSON.parse(response.body)
    end

    private

    def usos_authorizer
      UsosAuthLib::UsosAuthorizer.new
    end
  end
end
