class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :on_pages_dashboard

  private

  def on_pages_dashboard
    controller_name == 'pages' && action_name == 'dashboard'
  end
end
