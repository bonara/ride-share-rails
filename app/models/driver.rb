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
    unless self.trips.count == 0
      total_rating = self.trips.map{|trip| 
        unless trip.rating == nil
          trip.rating
        end }.compact.sum

      avrg = total_rating/self.trips.count
    end

    return avrg
  end

end

