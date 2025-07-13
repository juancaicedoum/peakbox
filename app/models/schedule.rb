# app/models/schedule.rb
class Schedule < ApplicationRecord
  has_many :bookings # Añadiremos esto cuando creemos el modelo Booking

  validates :name, presence: true
  validates :date, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :capacity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate :end_time_after_start_time
  validate :date_is_future_or_today # Opcional: Asegurar que la fecha no sea pasada

  private

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?

    if end_time < start_time
      errors.add(:end_time, "debe ser posterior a la hora de inicio")
    end
  end

  def date_is_future_or_today
    return if date.blank?
    if date < Date.current
      errors.add(:date, "no puede ser en el pasado")
    end
  end
end
