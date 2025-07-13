# app/controllers/home_controller.rb
class HomeController < ApplicationController
  # Permite que la página de inicio sea accesible sin necesidad de iniciar sesión
  skip_before_action :authenticate_user! 

  def index
    # Aquí puedes añadir lógica para la página de bienvenida si es necesario
  end
end
