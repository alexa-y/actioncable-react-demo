class DashboardController < ApplicationController

  def index
    return redirect_to sign_in_path unless signed_in_user
    js_env current_user: signed_in_user
  end

  def confirm_sign_in
    if params[:name].present?
      cookies.signed[:user] = params[:name].strip
      redirect_to root_path
    else
      redirect_to sign_in_path
    end
  end
end
