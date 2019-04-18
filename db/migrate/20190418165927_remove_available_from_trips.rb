class RemoveAvailableFromTrips < ActiveRecord::Migration[5.2]
  def change
    remove_column :trips, :available
  end
end
