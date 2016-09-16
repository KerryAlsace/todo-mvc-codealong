Rails.application.routes.draw do
  get '/auth/:provider/callback' => 'sessions#create'

  get '/login' => 'sessions#new'
  post '/sessions' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  resources :users, only: [:new, :create]

  resources :lists do
    resources :items
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'lists#index'
end
