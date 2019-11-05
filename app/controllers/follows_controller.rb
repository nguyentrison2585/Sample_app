class FollowController < ApplicationController
  def following
    @title = t "following"
    @user = User.find_by id: params[:id]
    @users = @user.following.page(params[:page]).per Settings.follow_per_page
    render "show_follow"
  end

  def followers
    @title = t "followers"
    @user = User.find_by id: params[:id]
    @users = @user.followers.page(params[:page]).per Settings.follow_per_page
    render "show_follow"
  end
end
