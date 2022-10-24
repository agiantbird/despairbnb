class AddUniqueIndexToReservations < ActiveRecord::Migration[7.0]
  def change
    add_index :reservations, [:property_id, :user_id, :reservation_date], unique: true, name: 'index_reservations_on_property_and_user_and_reservation_date'
  end
end
