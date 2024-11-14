class ApplicationController < ActionController::Base

protected

def configure_permitted_parameters
  # parameters allowed during sign up
  devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  # parameters that can be updated
  devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
end

end
