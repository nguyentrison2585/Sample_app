class SessionsController < ApplicationController
  before_action :find_user, only: :create
  def new; end

  def create
    if @user.authenticate(params[:session][:password])
      log_in @user
      if params[:session][:remember_me] == Settings.check_remembered
        remember @user
      else
        forget @user
      end
      redirect_back_or @user
    else
      flash.now[:danger] = t "invalid_login"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def find_user
    @user = User.find_by email: params[:session][:email].downcase
    return if @user

    flash.now[:danger] = t "invalid_login"
    render :new
  end
end
