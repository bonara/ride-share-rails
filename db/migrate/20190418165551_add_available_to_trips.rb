class AddAvailableToTrips < ActiveRecord::Migration[5.2]
  def change
    add_column :trips, :available, :boolean
  end
end
