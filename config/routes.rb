# config/routes.rb
Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :schedules
    resources :users, only: [:index, :new, :create, :edit, :update, :destroy] # <--- Asegúrate de que :destroy esté aquí
    root to: 'schedules#index'
  end

  resources :bookings, only: [:index, :create, :show, :destroy]

  root to: 'home#index'

  get "up" => "rails/health#show", as: :rails_health_check
end
