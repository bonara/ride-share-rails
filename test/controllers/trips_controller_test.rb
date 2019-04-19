require "test_helper"

describe TripsController do

  describe "create" do
    
    it 'creates a new trip' do
      expect {
        post passenger_trips_path(passenger_id: Passenger.first)
      }.must_change 'Trip.count', +1
    end
  end

  describe "destroy" do
    it 'removes trip from the database' do
      trip = Trip.new(
        passenger_id: Passenger.all.sample.id,
        driver_id: Driver.all.sample.id,
        date: Date.current,
        rating: nil,
        cost: (rand(9..100) * 100)
      )
      trip.save

      expect do
        delete trip_path(trip)
      end.must_change 'Trip.count', -1

      must_respond_with :redirect
      must_redirect_to root_path

      after_trip = Trip.find_by(id: trip.id)
      expect(after_trip).must_be_nil
    end
  end
end
