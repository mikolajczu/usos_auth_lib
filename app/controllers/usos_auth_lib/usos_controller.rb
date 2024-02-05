module UsosAuthLib
  class UsosController < ActionController::Base
    def authorize_user
      authorization_url = usos_authorizer.authorize(session, request)

      redirect_to authorization_url, allow_other_host: true
    rescue StandardError => e
      Rails.logger.error "USOS Authorize User Error: #{e.message}"
    end

    def callback
      verifier = params[:oauth_verifier]
      access_token = usos_authorizer.access_token(session, verifier, nil, nil)

      response = access_token.get('/services/users/user?fields=id|first_name|last_name|email')
      parsed_response = JSON.parse(response.body)

      session[:user_data] = parsed_response
      session[:access_token] = access_token.token
      session[:access_token_secret] = access_token.secret

      redirect_to UsosAuthLib.configuration.redirect_path, allow_other_host: true
    rescue StandardError => e
      Rails.logger.error "USOS Callback Error: #{e.message}"
    end

    private

    def usos_authorizer
      UsosAuthLib::UsosAuthorizer.instance
    end
  end
end
