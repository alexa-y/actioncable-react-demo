Rails.application.routes.draw do
  root to: 'dashboard#index'
  get '/sign_in' => 'dashboard#sign_in', as: 'sign_in'
  post '/sign_in' => 'dashboard#confirm_sign_in'

  resources :messages, only: [:index]
end
