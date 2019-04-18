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
      driver = Driver.create!(name: 'Jane Doe', vin: 'xxx11111111111')
      get edit_driver_path(driver.id)

      must_respond_with :success
    end

    it 'will respond with redirect when attempting to edit a nonexistant driver' do
      get edit_driver_path(-1)
      must_respond_with :not_found
    end
  end

  describe "update" do
    it 'changes the data on the model' do
      driver = Driver.create!(name: 'Jane Doe', vin: 'xxx11111111111')
      driver_data = {
        driver: {
          name: 'Mike Moore',
          vin: 'xxx11111111111'
        }
      }

      patch driver_path(driver), params: driver_data

      must_respond_with :redirect
      must_redirect_to driver_path(driver)

      driver.reload
      expect(driver.name).must_equal(driver_data[:driver][:name])
    end
  end

  describe "new" do
    it 'returns status code 200' do
      get new_driver_path
      must_respond_with :ok
    end
  end

  describe "create" do
    it 'creates a new driver' do
      driver_data = {
        driver: {
          name: 'Mike Moore',
          vin: 'xxx11111111111'
        }
      }

      expect do
        post drivers_path, params: driver_data
      end.must_change 'Driver.count', +1

      must_respond_with :redirect
      must_redirect_to drivers_path

      driver = Driver.last
      expect(driver.name).must_equal driver_data[:driver][:name]
      expect(driver.vin).must_equal driver_data[:driver][:vin]
    end
  end

  describe "destroy" do
    it 'removes the driver from the database' do
      driver = Driver.create!(name: 'Jane Doe', vin: 'xxx11111111111')

      expect do
        delete driver_path(driver)
      end.must_change 'Driver.count', -1

      must_respond_with :redirect
      must_redirect_to drivers_path

      after_driver = Driver.find_by(id: driver.id)
      expect(after_driver).must_be_nil
    end

    it "returns a 404 if the driver does not exist" do
      driver_id = 123_456_789

      expect(Driver.find_by(id: driver_id)).must_be_nil

      expect do
        delete driver_path(driver_id)
      end.wont_change 'Driver.count'

      must_respond_with :not_found
    end
  end
end
