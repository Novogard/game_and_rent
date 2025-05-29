class GamesController < ApplicationController
  def index
    @users = User.all
    @games = Game.all
    return unless params[:query].present?
    sql_subquery = "title ILIKE :query OR genre ILIKE :query OR platform ILIKE :query"
    @games = @games.where(sql_subquery, query: "%#{params[:query]}%")
  end

  def show
    @game = Game.find(params[:id])
  end

  private

  def game_params
    params.require(:game).permit(:title, :platform, :overview, :genre, :artwork_url)
  end
end
