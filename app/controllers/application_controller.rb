class ApplicationController < ActionController::Base
  include Clearance::Controller
  # before_action :require_login
  protect_from_forgery with: :exception

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end
