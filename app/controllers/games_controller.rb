class GamesController < ApplicationController
  def index
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
