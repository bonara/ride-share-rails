class Driver < ApplicationRecord
  has_many :trip

  validates :name, presence: true
  validates :vin, presence: true, length: { is: 14}
end
