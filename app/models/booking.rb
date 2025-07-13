# app/models/booking.rb
class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :schedule

  validates :status, presence: true, inclusion: { in: %w(confirmed cancelled) }
  validates :confirmation_code, presence: true, uniqueness: true

  # NUEVA VALIDACIÓN: Asegura que un usuario no pueda reservar el mismo horario más de una vez
  validates :user_id, uniqueness: { scope: :schedule_id, message: "ya has reservado esta clase." }

  before_validation :generate_confirmation_code, on: :create
  validate :schedule_has_capacity, on: :create
  validate :user_membership_active, on: :create

  private

  def generate_confirmation_code
    self.confirmation_code = SecureRandom.hex(8)
  end

  def schedule_has_capacity
    current_bookings_count = Booking.where(schedule_id: schedule_id, status: 'confirmed').count

    if schedule && current_bookings_count >= schedule.capacity
      errors.add(:schedule, "no tiene cupos disponibles.")
    end
  end

  def user_membership_active
    if user && !user.membership_active?
      errors.add(:user, "tu mensualidad no está activa. Por favor, actualiza tu pago.")
    end
  end
end
