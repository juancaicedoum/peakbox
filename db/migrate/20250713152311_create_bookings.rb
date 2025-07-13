class CreateBookings < ActiveRecord::Migration[8.0] # La versión puede ser 7.1 o 8.0
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :schedule, null: false, foreign_key: true
      t.string :status, default: "confirmed" # <--- ¡Asegúrate de que esto esté aquí!
      t.string :confirmation_code # <--- ¡Asegúrate de que esto esté aquí!

      t.timestamps
    end
    add_index :bookings, :confirmation_code, unique: true # <--- ¡Asegúrate de que esta línea esté aquí!
  end
end
