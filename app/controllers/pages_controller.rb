class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:dashboard]

  def home
    @games = Game.all
  end

  def dashboard
    #Je dois récupérer l'id de mon current user
    @user = current_user || User.find(params[:id])
    #Je dois récupérer les offers de mon current user
    @offers = Offer.where(user_id: @user.id)
    #Je dois récupérer les bookings de mon current user
    @bookings = Booking.where(user_id: @user.id)
    @bookings_given = Booking.joins(:offer).where(offers: { user_id: @user.id })

    @booking_sorted_by_platform = @bookings.where(platform: "PS5")
  end

end
