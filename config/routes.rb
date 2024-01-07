UsosAuthLib::Engine.routes.draw do
  post '/authorize_user', to: 'usos#authorize_user'
  post '/callback', to: 'usos#callback'
  post '/handle_request', to: 'usos#handle_request'
end
