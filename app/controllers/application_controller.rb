class ApplicationController < ActionController::Base
  protect_from_forgery

  def signed_in?
    session[:user].present?
  end
  helper_method :signed_in?

end
