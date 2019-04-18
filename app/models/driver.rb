class Driver < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :vin, presence: true, length: { is: 14}

#Details
#The driver gets 80% of the trip cost after a fee of $1.65 is subtracted

  def total_earnings
    total = (self.trips.sum {|trip| trip.cost - 165 }) * 0.8
    return "$#{(total /= 100).round(2)}"
  end
  
  def avrg_rating
    return total = (self.trips.sum { |trip| trip.rating}) / self.trips.count
  end

end

