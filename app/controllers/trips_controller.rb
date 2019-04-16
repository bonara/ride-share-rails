class TripsController < ApplicationController
  def show
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)

    head :not_found unless @trip
  end

  def edit
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)

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
