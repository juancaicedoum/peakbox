# config/routes.rb
Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :schedules
    root to: 'schedules#index'
  end

  # Rutas para reservas de clientes
  resources :bookings, only: [:index, :create, :show] # <--- Añade esta línea

  root to: 'home#index'

  get "up" => "rails/health#show", as: :rails_health_check
end
