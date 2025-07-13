# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  # Configura los parámetros permitidos por Devise para sign_up y account_update.
  # Debe ejecutarse antes de que Devise procese los datos del formulario.
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Asegura que el usuario esté autenticado antes de acceder a la mayoría de las acciones.
  # Home#index ya tiene skip_before_action para poder ser vista sin login.
  before_action :authenticate_user!

  protected # Los métodos llamados por Devise suelen ser 'protected'

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :date_of_birth, :phone_number])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :date_of_birth, :phone_number])
  end

  private # Los métodos helper para los controladores suelen ser privados.

  # Método para verificar si el usuario actual es un administrador.
  def authorize_admin!
    # Redirige si no hay usuario logueado O si el usuario logueado no es administrador.
    # current_user es un helper de Devise.
    unless current_user&.admin?
      redirect_to root_path, alert: "No tienes permisos para acceder a esta sección."
    end
  end
end
