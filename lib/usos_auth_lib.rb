require 'usos_auth_lib/version'
require 'usos_auth_lib/engine'
require 'oauth'
require 'singleton'

module UsosAuthLib
  class Configuration
    attr_accessor :api_key, :api_secret, :usos_base_url, :scopes, :redirect_path

    def initialize
      @api_key = nil
      @api_secret = nil
      @usos_base_url = nil
      @scopes = nil
      @redirect_path = nil
    end
  end

  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end
  end

  class UsosAuthorizer
    include Singleton

    def initialize
      config = UsosAuthLib.configuration
      @api_key = config.api_key
      @api_secret = config.api_secret
      @usos_base_url = config.usos_base_url
      @scopes = config.scopes
    end

    def authorize(session, request)
      callback_url = "#{request.protocol}#{request.host_with_port}/callback"
      request_token = consumer.get_request_token(
        { oauth_callback: callback_url },
        { scopes: @scopes }
      )
      session[:request_token] = request_token.token
      session[:request_token_secret] = request_token.secret

      request_token.authorize_url
    rescue StandardError => e
      Rails.logger.error "USOS Authorize Error: #{e.message}"
    end

    def access_token(session, verifier, access_token, access_token_secret)
      token = nil

      if verifier.nil?
        token = OAuth::AccessToken.new(
          consumer,
          access_token,
          access_token_secret
        )
      else
        request_token = OAuth::RequestToken.new(
          consumer,
          session.delete(:request_token),
          session.delete(:request_token_secret)
        )
        token = request_token.get_access_token(oauth_verifier: verifier)
      end

      token
    rescue StandardError => e
      Rails.logger.error "USOS Access Token Error: #{e.message}"
      nil
    end

    private

    def consumer
      OAuth::Consumer.new(
        @api_key,
        @api_secret,
        site: @usos_base_url,
        request_token_path: '/services/oauth/request_token',
        authorize_path: '/services/oauth/authorize',
        access_token_path: '/services/oauth/access_token'
      )
    rescue StandardError => e
      Rails.logger.error "USOS Consumer Error: #{e.message}"
    end
  end
end
