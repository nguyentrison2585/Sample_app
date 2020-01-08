class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :find_post, only: :destroy

  def create
    @micropost = current_user.microposts.build micropost_params
    @micropost.image.attach params[:micropost][:image]
    save_post
  end

  def destroy
    if @micropost.destroy
      flash[:seccess] = t "post_deleted"
    else
      flash[:danger] = t "post_delete_fail"
    end
    redirect_to request.referer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit %i(content image)
  end

  def save_post
    if @micropost.save
      flash[:success] = t "post_created"
      redirect_to root_url
    else
      @feed_items = Micropost.me_and_following(current_user.id).page(params[:page])
                                .per Settings.posts_per_page
      flash[:danger] = t "post_create_fail"
      render "static_pages/home"
    end
  end

  def find_post
    @micropost = current_user.microposts.find_by id: params[:id]
    redirect_to root_url if @micropost.nil?
  end
end
