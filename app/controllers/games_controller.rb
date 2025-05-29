class GamesController < ApplicationController
  def index
    @games = Game.all
    @users = User.all
  end

  def show
    @game = Game.find(params[:id])
  end

  private

  def game_params
    params.require(:game).permit(:title, :platform, :overview, :genre, :artwork_url)
  end
end
