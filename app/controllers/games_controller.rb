class GamesController < ApplicationController
  def index
    @genres = Game.pluck(:genre).uniq
    @platforms = Game.pluck(:platform).uniq
    @users = User.all
    if params[:query].present?
      @games = Game.search_by_text(params[:query])
    else
      @games = Game.all
    end
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
