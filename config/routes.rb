Rails.application.routes.draw do
  resources :users, only: %i[index show create update destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # post '/login', to: 'sessions#create'
  # delete '/logout', to: 'sessions#destroy'
  resources :sessions, only: %i[create destroy]
end
