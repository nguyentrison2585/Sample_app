class StaticPagesController < ApplicationController
  def home
    return unless logged_in?

    @micropost = current_user.microposts.build
    @feed_items = Micropost.me_and_following(current_user.id)
                           .order_by_created_at.page(params[:page]).per Settings.posts_per_page
  end

  def help; end

  def about; end

  def contact; end
end
