Rails.application.routes.draw do
<<<<<<< HEAD
  # Borra estas tres líneas:
  # get "bookings/index"
  # get "bookings/create"
  # get "bookings/show"

  devise_for :users # Esta línea debe permanecer aquí para la autenticación

  # Aquí es donde añadimos las rutas RESTful para bookings:
  resources :bookings, only: [:index, :create, :show, :destroy] # <--- ¡Esta es la línea clave para las reservas!

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :admin do
    get "users/index"
    get "users/edit"
    get "users/update"
    resources :schedules # Esto creará TODAS las rutas CRUD para horarios dentro de /admin
    resources :users, only: [:index, :new, :create, :edit, :update]
    root to: 'schedules#index' # Establece la página principal del panel de administración
  end

  root to: 'home#index' # Esta es la ruta raíz de tu aplicación principal

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
=======
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'pages#home'

  # delete this line: get 'pages/home'
end
>>>>>>> 6445efdc93586bdd4db684b09880f1298682850a
