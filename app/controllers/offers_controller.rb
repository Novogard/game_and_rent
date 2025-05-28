class OffersController < ApplicationController

def destroy
  @offer = Offer.find(params[:id])
  @offer.destroy
  redirect_to pages_dashboard_path(current_user.id), notice: 'Offer was successfully deleted.', status: :see_other
  end

end
