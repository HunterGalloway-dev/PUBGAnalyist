Rails.application.routes.draw do

  get 'admins/populate_database'
  get 'admins/index'
  get 'admins/links'
  #resources :players
  get 'players', to: 'players#index', as: 'players'
  get 'player/:id', to: 'players#show', as: 'player'

  get 'teams', to: 'teams#index', as: 'teams'
  get 'team/:id', to: 'teams#show', as: 'team'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ( "/")
  # root "articles#index"
  root "players#index"
end
