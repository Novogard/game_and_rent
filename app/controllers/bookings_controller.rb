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
