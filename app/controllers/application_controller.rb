class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :current_user_or_default

  include Messages

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_user_or_default
    @current_user || User.find_by(email: 'anonymous@anonymous.com')
  end

  def require_login
    redirect_to login_path, alert: not_logged_in unless current_user
  end
end
