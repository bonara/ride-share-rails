require 'test_helper'

describe PassengersController do
  describe 'index' do
    it 'renders without crashing' do
      # Arrange
      Passenger.create!(name: 'Jane Doe', phone_num: '234-345-5555')

      # Act
      get passengers_path

      # Assert
      must_respond_with :ok
    end

    it 'renders even if there are zero passengers' do
      
      # Need to enable once destroy is working with foreign key
      # Arrange
      Passenger.destroy_all

      # Act
      get passengers_path

      # Assert
      must_respond_with :ok
    end
  end

  describe 'show' do
    it "returns a 404 status code if the passenger doesn't exist" do
      passenger_id = 98_888

      get passenger_path(passenger_id)

      must_respond_with :not_found
    end

    it 'returns a passenger that exists' do
      passenger = Passenger.create!(name: 'Jane Doe', phone_num: '234-345-5555')

      get passenger_path(passenger.id)

      must_respond_with :ok
    end
  end

  describe 'edit' do
    it 'can get the edit page for an existing passenger' do
      passenger = Passenger.create!(name: 'Jane Doe', phone_num: '606-456-6789')
      get edit_passenger_path(passenger.id)

      must_respond_with :success
    end

    it 'will respond with redirect when attempting to edit a nonexistant passenger' do
      # Act
      get edit_passenger_path(-1)

      # Assert
      must_respond_with :not_found
    end
  end

  describe 'update' do
    it 'changes the data on the model' do
      passenger = Passenger.create!(name: 'Jane Doe', phone_num: '606-456-6789')
      passenger_data = {
        passenger: {
          name: 'Mike Moore',
          phone_num: '606-456-6789'
        }
      }

      patch passenger_path(passenger), params: passenger_data

      must_respond_with :redirect
      must_redirect_to passenger_path(passenger)

      passenger.reload
      expect(passenger.name).must_equal(passenger_data[:passenger][:name])
    end
  end

  describe 'new' do
    it 'returns status code 200' do
      get new_passenger_path
      must_respond_with :ok
    end
  end

  describe 'create' do
    it 'creates a new passenger' do
      passenger_data = {
        passenger: {
          name: 'Mike Moore',
          phone_num: '606-456-6789'
        }
      }

      expect do
        post passengers_path, params: passenger_data
      end.must_change 'Passenger.count', +1

      must_respond_with :redirect
      must_redirect_to passengers_path

      passenger = Passenger.last
      expect(passenger.name).must_equal passenger_data[:passenger][:name]
      expect(passenger.phone_num).must_equal passenger_data[:passenger][:phone_num]
    end
  end

  describe 'destroy' do
    it 'removes the passenger from the database' do
      passenger = Passenger.create!(name: 'Jane Doe', phone_num: '234-345-5555')

      expect do
        delete passenger_path(passenger)
      end.must_change 'Passenger.count', -1

      must_respond_with :redirect
      must_redirect_to passengers_path

      after_passenger = Passenger.find_by(id: passenger.id)
      expect(after_passenger).must_be_nil
    end

    it "returns a 404 if the passenger doesn't exist" do
      passenger_id = 123_456_789

      expect(Passenger.find_by(id: passenger_id)).must_be_nil

      expect do
        delete passenger_path(passenger_id)
      end.wont_change 'Passenger.count'

      must_respond_with :not_found
    end
  end
end
