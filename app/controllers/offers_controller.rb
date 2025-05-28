class OffersController < ApplicationController
  before_action :set_offer, only: %i[edit update destroy]

  def new
    # @game = Game.all
    @offer = Offer.new
  end

  def index
    @offers = Offer.all
  end

  def edit
  end

  def create
    @offer = Offer.new(offer_params)
    @offer.user = current_user
    if @offer.save
      redirect_to offers_path, notice: "offer was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @offer.update(offer_params)
      redirect_to @offer, notice: "offer was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end


  private

  # Use callbacks to share common setup or constraints between actions.
  def set_offer
    @offer = Offer.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def offer_params
    params.require(:offer).permit(:game_id, :rate_per_day, :description, :photo, :condition)


def destroy
  @offer = Offer.find(params[:id])
  @offer.destroy
  redirect_to pages_dashboard_path(current_user.id), notice: 'Offer was successfully deleted.', status: :see_other

  end

end
