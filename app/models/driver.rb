class Driver < ApplicationRecord
  has_many :trip

  validates :name, presence: true
  validates :vin, presence: true, length: { is: 14}

  
  @driver = Driver.find_by(id: @driver_id)
  @driver_trips = Trip.where(driver_id: @driver_id)
  
  
  def avrg_rating
    return total = (@driver_trips.sum {|trip| trip.rating})/@driver_trips.count
  end
end

