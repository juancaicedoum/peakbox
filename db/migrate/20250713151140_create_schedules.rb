class CreateSchedules < ActiveRecord::Migration[8.0] # La versión puede ser 7.1 o 8.0
  def change
    create_table :schedules do |t|
      t.string :name
      t.datetime :start_time
      t.datetime :end_time
      t.integer :capacity
      t.date :date
      t.boolean :enabled, default: true # <--- ¡Asegúrate de que esto esté aquí!

      t.timestamps
    end
  end
end
