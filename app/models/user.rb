# app/models/user.rb
class User < ApplicationRecord
  # Incluye módulos predeterminados de devise. Otros disponibles son:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Validaciones básicas (opcional, pero buena práctica)
  validates :email, presence: true, uniqueness: true

  # Relaciones
  has_many :bookings, dependent: :destroy  # <--- Asegúrate de que esta línea esté aquí

  # Métodos personalizados para la lógica de negocio
  # Verifica si el usuario es un administrador
  def admin?
    admin # El campo 'admin' de tipo booleano ya lo hace por nosotros
  end

  # Verifica si la mensualidad del usuario está activa
  def membership_active?
    # La mensualidad está activa si 'paid_until' existe y es igual o posterior a la fecha actual.
    paid_until.present? && paid_until >= Date.current
  end
end
