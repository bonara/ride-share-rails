require "test_helper"

describe DriversController do
  describe "index" do
    it "can get index" do
      get drivers_path
      must_respond_with :ok
    end
  end

  describe "show" do
    it "returns a 404 status code if the passenger does not exist" do
      driver_id = 10000
      get driver_path(driver_id)
      must_respond_with :not_found
    end
  end

  describe "edit" do
    it 'can get the edit page for an existing driver' do
      driver = Driver.create!(name: 'Jane Doe', phone_num: '606-456-6789')
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

  describe "update" do
    # Your tests go here
  end

  describe "new" do
    # Your tests go here
  end

  describe "create" do
    # Your tests go here
  end

  describe "destroy" do
    # Your tests go here
  end
end
