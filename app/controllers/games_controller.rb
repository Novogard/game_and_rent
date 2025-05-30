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
  # par JSON
  # def autocomplete
  #   if params[:query].present?
  #     results = Game.where("title ILIKE ?", "%#{params[:query]}%")
  #     # render json: results.pluck(:title)
  #      # TODO render la partial de game-horizontal-card
  #      render "games/cards_search", games: game, user: current_user
  #   else
  #           render json: []
  #   end
  # end

def autocomplete
  if params[:query].present?
    @games = Game.where("title ILIKE ?", "%#{params[:query]}%")
    render partial: "games/cards_search", locals: { games: @games, user: current_user }
    # render partial: "games/cards_search", locals: { games: @games, user: current_user }
  else
    render plain: ""
  end
end

  private

  def game_params
    params.require(:game).permit(:title, :platform, :overview, :genre, :artwork_url)
  end
end
