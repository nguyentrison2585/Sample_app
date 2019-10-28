class UsersController < ApplicationController
  def show
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "not_found"
    redirect_to root_url
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash.now[:success] = t "welcome"
      redirect_to @user
    else
      flash.now[:danger] = t "fail"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit User::USER_ATTR
  end
end
