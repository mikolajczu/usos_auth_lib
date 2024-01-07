Rails.application.routes.draw do
  mount UsosAuthLib::Engine => "/usos_auth_lib"
end
