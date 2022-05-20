Rails.application.routes.draw do
  devise_for :users
  # Twire Link Routes
  get 'hubs', to: 'twire_link#index', as: 'hubs'
  # End Twire Link Routes

  # Users Routes
  get 'login', to: 'oauth#login', as: 'login'
  get 'process_oauth', to: 'oauth#process_oauth', as: 'process_oauth'
  # End Users Routes

  # Admin Routes
  get 'admins/populate_database'
  get 'admins/index'
  get 'admins/links'
  # End admin routes

  # Player Routes
  get 'players', to: 'players#index', as: 'players'
  get 'player/:id', to: 'players#show', as: 'player'
  # End Player ROutes

  # Teams Routes
  get 'teams', to: 'teams#index', as: 'teams'
  get 'team/:id', to: 'teams#show', as: 'team'
  # End Teams Routes

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ( "/")
  # root "articles#index"
  root "twire_link#index"
end
