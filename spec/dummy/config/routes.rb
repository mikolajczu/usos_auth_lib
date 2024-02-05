Rails.application.routes.draw do
  mount UsosAuthLib::Engine => '/usos_auth_lib'
  namespace :usos_auth_lib do
    get 'authorize_user', to: 'usos#authorize_user'
    get 'callback', to: 'usos#callback'
  end

  get '/destroy_session', to: 'users#destroy_session'
  get '/home', to: 'users#home'
  get '/usos/callback', to: 'users#callback'
  get '/dashboard', to: 'users#dashboard'
  get '/grades', to: 'users#grades'
end
