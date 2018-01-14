Rails.application.routes.draw do
  get 'users/new'

  get 'sessions/new'
  get 'home/index'
  get '/home', to: 'home#index'
  get '/users/1', to: 'home#index'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  resources :users
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
