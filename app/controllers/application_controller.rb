class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :on_pages_dashboard
  before_action :configure_permitted_parameters, if: :devise_controller?





  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :address])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :address])
  end

  private

  def on_pages_dashboard
    controller_name == 'pages' && action_name == 'dashboard'
  end
end
