require 'rails_helper'

RSpec.describe UsosAuthLib::UsosController, type: :controller do
  let(:authorizer_instance) { instance_double(UsosAuthLib::UsosAuthorizer) }
  let(:authorization_url) { 'http://test.usosapi.com/authorize' }
  let(:access_token) { instance_double("OAuth::AccessToken", token: 'access_token', secret: 'access_token_secret') }
  let(:oauth_verifier) { 'verifier_code' }
  let(:user_data) { { 'id' => '123', 'first_name' => 'John', 'last_name' => 'Doe', 'email' => 'john.doe@example.com' } }

  before do
    UsosAuthLib.configure do |config|
      config.redirect_path = '/some_valid_path'
    end

    allow(UsosAuthLib::UsosAuthorizer).to receive(:instance).and_return(authorizer_instance)
  end

  describe 'GET #authorize_user' do
    it 'redirects to the authorization URL' do
      allow(authorizer_instance).to receive(:authorize).and_return(authorization_url)

      get :authorize_user

      expect(response).to redirect_to(authorization_url)
    end
  end

  describe 'GET #callback' do
    before do
      allow(authorizer_instance).to receive(:access_token).and_return(access_token)
      allow(access_token).to receive(:get).with('/services/users/user?fields=id|first_name|last_name|email').and_return(double(body: user_data.to_json))
    end

    it 'processes the callback and redirects to the configured path' do
      session[:oauth_verifier] = oauth_verifier

      get :callback, params: { oauth_verifier: oauth_verifier }

      expect(session[:user_data]).to eq(user_data)
      expect(session[:access_token]).to eq('access_token')
      expect(session[:access_token_secret]).to eq('access_token_secret')
      expect(response).to redirect_to(UsosAuthLib.configuration.redirect_path)
    end
  end
end
