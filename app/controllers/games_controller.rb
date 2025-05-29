class GamesController < ApplicationController

  def index
    @offers = Offer.all
    @users = User.all
  end

  def show
    @game = Game.find(params[:id])
    @offers = Offer.where(game: @game)
    @booking = Booking.new
  end

  private

  def game_params
    params.require(:game).permit(:title, :platform, :overview, :genre, :artwork_url)
  end

end
