class Driver < ApplicationRecord
  has_many :trips, :dependent => :destroy

  validates :name, presence: true
  validates :vin, presence: true, length: { is: 14}

#Details
#The driver gets 80% of the trip cost after a fee of $1.65 is subtracted

  def total_earnings
    unless self.trips == nil
      total = (self.trips.sum {|trip| trip.cost - 165 }) * 0.8
      return "$#{(total /= 100).round(2)}"
    end
  end
  
  def avrg_rating
    return total = ((self.trips.sum { |trip| trip.rating if trip.rating != nil}) / self.trips.count).floor
  end

end

