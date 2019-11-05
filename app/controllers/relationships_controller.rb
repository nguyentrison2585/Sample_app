class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :load_user, only: :create
  before_action :load_relationship, only: :destroy

  def create
    current_user.follow @user
    respond_to :js
  end

  def destroy
    current_user.unfollow @user
    respond_to :js
  end

  private

  def load_user
    @user = User.find_by id: params[:followed_id]
    return @user if @user

    flash[:danger] = t "invalid_user"
    redirect_to root_url
  end

  def load_relationship
    @user = Relationship.find_by(id: params[:id]).followed
    return if @user

    flash[:danger] = t "invalid_user"
    redirect_to root_url
  end
end
