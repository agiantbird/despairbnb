Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "home#index"

  namespace :api do
    get "/users_by_email" => "users_by_emails#show", as: :users_by_email

    resources :favorites, only: [:create, :destroy]
  end

  resources :properties, only: :show do
    resources :reservations, only: [:new, :show], controller: "properties/reservations"
  end

  resources :reservation_payments, only: :create

  resources :profiles, only: [:show, :update]
end
