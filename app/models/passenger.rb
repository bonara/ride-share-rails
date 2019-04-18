class Passenger < ApplicationRecord
  has_many :trip, :dependent => :destroy

  validates :name, :phone_num, presence: true
end
