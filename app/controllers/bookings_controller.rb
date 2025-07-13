# app/controllers/bookings_controller.rb
class BookingsController < ApplicationController
  before_action :authenticate_user! # Asegura que el usuario esté logueado
  before_action :set_booking, only: [:show, :destroy] # <--- ¡Ajusta esta línea!

  def index
    # Mostrar horarios disponibles para reservar
    @available_schedules = Schedule.where(enabled: true)
                                   .where('date >= ?', Date.current)
                                   .order(:date, :start_time)
                                   .select do |schedule|
                                     Booking.where(schedule_id: schedule.id, status: 'confirmed').count < schedule.capacity
                                   end
    # Mostrar las reservas del usuario actual
    @user_bookings = current_user.bookings.order(created_at: :desc) if user_signed_in?
  end

  def create
    @schedule = Schedule.find(params[:schedule_id])
    @booking = current_user.bookings.new(schedule: @schedule)

    if @booking.save
      redirect_to @booking, notice: 'Reserva creada exitosamente. Tu código de confirmación es: ' + @booking.confirmation_code
    else
      redirect_to bookings_path, alert: @booking.errors.full_messages.to_sentence
    end
  end

  def show
    # @booking ya está establecido por set_booking
  end

  # NUEVA ACCIÓN: Para eliminar una reserva
  def destroy
    # @booking ya está establecido por set_booking
    # Asegúrate de que el usuario actual es el propietario de la reserva
    if @booking.user == current_user
      @booking.destroy
      # O podrías cambiar el estado a 'cancelled' en lugar de borrarlo completamente:
      # @booking.update(status: 'cancelled')
      redirect_to bookings_path, notice: 'Reserva cancelada exitosamente.', status: :see_other
    else
      redirect_to bookings_path, alert: 'No tienes permiso para cancelar esta reserva.'
    end
  end

  private

  def set_booking
    # Encuentra la reserva por ID, pero solo si pertenece al usuario logueado
    @booking = current_user.bookings.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to bookings_path, alert: "Reserva no encontrada o no tienes acceso."
  end
end
