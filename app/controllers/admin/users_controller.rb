# app/controllers/admin/users_controller.rb
class Admin::UsersController < ApplicationController
  # Asegura que el usuario esté autenticado antes de acceder a estas acciones.
  before_action :authenticate_user!
  # Protege este controlador: solo usuarios administradores pueden acceder.
  before_action :authorize_admin!
  # Establece el objeto @user para las acciones que operan sobre un usuario específico.
  before_action :set_user, only: [:edit, :update, :destroy]

  # GET /admin/users
  # Muestra una lista de todos los usuarios, ordenados por email.
  def index
    @users = User.all.order(:email)
  end

  # GET /admin/users/new
  # Muestra el formulario para crear un nuevo usuario.
  def new
    @user = User.new
  end

  # POST /admin/users
  # Procesa la creación de un nuevo usuario.
  def create
    @user = User.new(user_params) # user_params incluye los nuevos campos y la contraseña

    if @user.save
      redirect_to admin_users_path, notice: 'Usuario creado exitosamente.'
    else
      # Si la creación falla (ej. validaciones), renderiza el formulario de nuevo con errores.
      render :new, status: :unprocessable_entity
    end
  end

  # GET /admin/users/:id/edit
  # Muestra el formulario para editar un usuario existente.
  def edit
    # @user ya está establecido por set_user
  end

  # PATCH/PUT /admin/users/:id
  # Procesa la actualización de un usuario existente.
  def update
    # @user ya está establecido por set_user

    # Lógica para manejar la contraseña: Devise validará la contraseña
    # si está presente. Si está en blanco, Devise la ignorará por defecto.
    # No necesitamos una lógica condicional compleja aquí si Devise ya maneja esto.
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'Usuario actualizado exitosamente.'
    else
      # Si la actualización falla, renderiza el formulario de edición de nuevo con errores.
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/users/:id
  # Procesa la eliminación de un usuario.
  def destroy
    # @user ya está establecido por set_user
    # Evita que un administrador intente eliminarse a sí mismo.
    if @user == current_user
      redirect_to admin_users_path, alert: 'No puedes eliminar tu propia cuenta de administrador desde aquí.'
    else
      @user.destroy
      # Redirección con status: :see_other es importante para que Turbo procese la eliminación.
      redirect_to admin_users_path, notice: 'Usuario eliminado exitosamente.', status: :see_other
    end
  end

  private

  # Método auxiliar para encontrar un usuario por ID.
  # Se usa con before_action :set_user.
  def set_user
    @user = User.find(params[:id])
  end

  # Define los "strong parameters" permitidos para el creación y actualización de usuarios.
  # Esto protege contra la asignación masiva de atributos no deseados.
  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation,
      :paid_until,
      :admin,
      :first_name,
      :last_name,
      :date_of_birth,
      :phone_number
    )
  end
end
