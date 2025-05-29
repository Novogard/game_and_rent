class GamesController < ApplicationController
  def index
    @genres = Game.joins(:offers).distinct.pluck(:genre)
    @platforms = Game.joins(:offers).distinct.pluck(:platform)
    @users = User.all
    @games = Game.all
    return unless params[:query].present?

    sql_subquery = "title ILIKE :query OR genre ILIKE :query OR platform ILIKE :query"
    @games = @games.where(sql_subquery, query: "%#{params[:query]}%")
  end

  def show
    @game = Game.find(params[:id])
    @offers = @game.offers
    @booking = Booking.new
  end

  def filter
    @genres = params[:genres] || []
    @platforms = params[:platforms] || []
    @games = Game.all
    @games = @games.where(genre: @genres) unless @genres.empty?
    @games = @games.where(platform: @platforms) unless @platforms.empty?

    render partial: 'games/games', locals: { games: @games }
  end

  private

  def game_params
    params.require(:game).permit(:title, :platform, :overview, :genre, :artwork_url)
  end
end
