class BookingsController < ApplicationController
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

end
