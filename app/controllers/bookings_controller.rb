class BookingsController < ApplicationController
  def create
    @booking = Booking.new(booking_params)
    @offer = Offer.find(params[:offer_id])
    @booking.offer = @offer
    @booking.status = "Pending"
    @booking.user = current_user
    if @booking.save
      redirect_to dashboard_path, notice: "offer was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
  end

  def approve
    @booking = Booking.find(params[:id])
    @booking.status = "Accepted"
    @booking.save!
    redirect_to dashboard_path, notice: 'Booking was successfully approved.', status: :see_other
  end

  def reject
    @booking = Booking.find(params[:id])
    @booking.status = "Rejected"
    @booking.save!
    redirect_to dashboard_path, notice: 'Booking was successfully rejected.', status: :see_other

  end
  
  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
