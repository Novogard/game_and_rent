Rails.application.routes.draw do
  devise_for :users
  get '/dashboard', to: 'pages#dashboard', as: 'dashboard'

  patch '/edit-booking-dates', to: 'bookings#edit_booking_dates'

  resources :offers do
    resources :bookings, only: [:create]
  end

  patch "/bookings/:id/approve", to: "bookings#approve", as: "approve_booking"
  patch "/bookings/:id/reject", to: "bookings#reject", as: "reject_booking"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check
  # Defines the root path route ("/")
  root to: "pages#home"
  resources :games do
    collection do
      get 'filter', to: 'games#filter', as: 'filter'
      get "autocomplete"
    end
  end
end
