class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.references :driver, foreign_key: true
      t.references :passenger, foreign_key: true
      t.date :date
      t.integer :rating
      t.float :cost

      t.timestamps
    end
  end
end
