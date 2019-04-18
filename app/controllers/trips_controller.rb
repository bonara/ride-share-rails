class TripsController < ApplicationController
  def new
    if params[:passenger_id]
      @passenger = Passenger.find_by(id: params[:passenger_id])
      if @passenger
        @trip = @passenger.trip.new
      else
        head :not_found
        return
      end
    end
  end

  def create
    
  end

  def show
    @trip = Trip.find(params[:id])

    head :not_found unless @trip
  end

  def edit
    @trip = Trip.find(params[:id])

    head :not_found unless @trip
  end

  def update
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)

    unless @trip
      head :not_found
      return
    end

    if @trip.update(trip_params)
      redirect_to trip_path(@trip)
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)

    unless trip
      head :not_found
      return
    end
    trip.destroy
    redirect_to trip_path
  end

  private

  def trip_params
    params.require(:trip).permit(:date, :rating, :cost)
  end
end
