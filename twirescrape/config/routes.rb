Rails.application.routes.draw do
  get 'admins/populate_database'
  get 'admins/index'
  #resources :players
  get 'players', to: 'players#index', as: 'players'
  get 'player/:id', to: 'players#show', as: 'player'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ( "/")
  # root "articles#index"
  root "players#index"
end
