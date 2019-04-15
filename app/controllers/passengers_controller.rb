class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all
  end

  def new
    @passenger = Passenger.new
  end

  def create
    passenger = Passenger.new(passenger_params)
    passenger.save
    redirect_to passenger_path(passenger.id)
  end

  def show
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id)

    redirect_to passengers_path if @passenger.nil?
  end

  def edit
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id)

    redirect_to passengers_path if @passenger.nil?
  end

  def update
    passenger_id = params[:id]
    passenger = Passenger.find_by(id: passenger_id)

    unless passenger
      redirect_to passengers_path
      return
    end

    passenger.update(passenger_params)
    redirect_to passenger_path(passenger)
  end

  def destroy
    passenger_id = params[:id]
    passenger = Passenger.find_by(id: passenger_id)

    unless passenger
      head :not_found
      return
    end
    passenger.destroy
    redirect_to passengers_path
  end

  private

  def passenger_params
    params.require(:passenger).permit(:name, :phone_num)
  end
end
