class BookingsController < ApplicationController
  def edit_booking_dates
    @booking = Booking.find(params[:id])
    return if @booking.status != "Pending"

    if params[:start_date].present?
    @booking.start_date = (params[:start_date])
    @booking.save
    end

    if params[:end_date].present?
      @booking.end_date = (params[:end_date])
      @booking.save
    end
    redirect_to dashboard_path
  end
end
