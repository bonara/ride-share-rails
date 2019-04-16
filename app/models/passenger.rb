class Passenger < ApplicationRecord
  has_many :trip

  validates :name, :phone_num, presence: true
end
