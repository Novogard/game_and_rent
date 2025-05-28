Rails.application.routes.draw do
  devise_for :users
  get 'pages/dashboard/:id', to: 'pages#dashboard', as: 'pages_dashboard'
  get 'games/:id', to: 'games#show'
  resources :offers

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check
  # Defines the root path route ("/")
  root to: "games#index"
  resources :games

end
