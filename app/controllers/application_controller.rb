class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def js_env(opts = {})
    @js_env ||= {}
    @js_env.deep_merge!(opts)
  end
  helper_method :js_env

  def signed_in_user
    cookies.signed[:user]
  end
end
