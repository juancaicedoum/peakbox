# app/controllers/memberships_controller.rb
class MembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_if_admin

  def status
    @user = current_user

    # Lógica para determinar el estado de la mensualidad usando @user.paid_until
    if @user.paid_until.present? && @user.paid_until >= Date.current
      @membership_status = "Activa"
      @status_class = "active"
      @message = "Tu mensualidad está activa hasta el #{@user.paid_until.strftime('%d/%m/%Y')}."
    else
      @membership_status = "Inactiva"
      @status_class = "inactive"
      @message = "Tu mensualidad está inactiva. Por favor, contacta a la administración para renovar."
    end
  end

  private

  def redirect_if_admin
    redirect_to admin_root_path, alert: "Los administradores no tienen estado de mensualidad de cliente." if current_user.admin?
  end
end
