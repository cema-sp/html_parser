Rails.application.routes.draw do
  resources :requests, only: [:index, :show, :create]
end
