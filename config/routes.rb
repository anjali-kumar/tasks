Rails.application.routes.draw do
  resources :projects
  resources :users, only: %i[index show create update destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
end
