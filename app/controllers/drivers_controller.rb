class DriversController < ApplicationController
  def index
    @drivers = Driver.all
  end

  def show
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)

    unless @driver
      head :not_found
    end
  end

  def edit
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)

    unless @driver
      head :not_found
    end
  end

  def update
    driver = Driver.find_by(id: params[:id])

    unless driver
      head :not_found
      return
    end

    driver.update(driver_params)
    redirect_to driver_path(driver)
  end

  def destroy
    driver_id = params[:id]
    driver = Driver.find_by(id: driver_id)

    unless driver
      head :not_found
      return
    end

    driver.destroy
    redirect_to drivers_path
  end

  private

  def driver_params
    return params.require(:driver).permit(:name, :vin)
  end
end
