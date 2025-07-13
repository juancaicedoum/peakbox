class AddPaidUntilToUsers < ActiveRecord::Migration[8.0] # La versión puede ser 7.1 o 8.0
  def change
    add_column :users, :paid_until, :date
  end
end
