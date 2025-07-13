Rails.application.routes.draw do
  devise_for :users

  resources :bookings, only: [:index, :create, :show, :destroy] # <-- This line is crucial for bookings

  namespace :admin do
    resources :schedules
    resources :users, only: [:index, :new, :create, :edit, :update] # <-- This line for admin users
    root to: 'schedules#index' # Root for admin panel
  end

  root to: 'home#index' # Main app root

  get "up" => "rails/health#show", as: :rails_health_check
end
