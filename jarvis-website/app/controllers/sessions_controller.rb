class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user and flash[:notice] = "Post successfully created"
    else
      flash[:notice] = "Post successfully created"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end