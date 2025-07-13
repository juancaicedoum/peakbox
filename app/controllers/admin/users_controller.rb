# app/controllers/admin/users_controller.rb
class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin! # Solo admins pueden acceder
  before_action :set_user, only: [:edit, :update]

  def index
    @users = User.all.order(:email)
  end

  # NUEVA ACCIÓN: Para mostrar el formulario de creación de usuario
  def new
    @user = User.new
  end

  # NUEVA ACCIÓN: Para procesar la creación de usuario
  def create
    @user = User.new(user_params) # Usamos user_params normal

    if @user.save
      redirect_to admin_users_path, notice: 'Usuario creado exitosamente.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # @user ya está establecido por set_user
  end

  def update
    # @user ya está establecido por set_user
    # Para la actualización, no permitimos password ni password_confirmation
    # a menos que los campos de contraseña se manejen de forma segura y separada
    # Si la contraseña no se envía, no la actualizamos
    if user_params[:password].blank? && user_params[:password_confirmation].blank?
      # Si no se envió contraseña, removerla de los params para que Devise no intente actualizarla
      params_without_password = user_params.except(:password, :password_confirmation)
      if @user.update(params_without_password)
        redirect_to admin_users_path, notice: 'Usuario actualizado exitosamente.'
      else
        render :edit, status: :unprocessable_entity
      end
    else
      # Si se envió contraseña, validarla y actualizarla
      if @user.update(user_params)
        redirect_to admin_users_path, notice: 'Usuario actualizado exitosamente.'
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    # Permite email, password, password_confirmation (para crear) y paid_until, admin (para editar/crear)
    params.require(:user).permit(:email, :password, :password_confirmation, :paid_until, :admin)
  end
end
