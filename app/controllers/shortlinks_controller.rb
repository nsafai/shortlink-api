class ShortlinksController < ApplicationController

  def index
    @shortlinks = Shortlink.all
  end

  def show
    @shortlink = Shortlink.find(params[:id])
    if (@shortlink.user_id)
      @creator = User.find(@shortlink.user_id)
    else
      @creator = User.new
      @creator.email = "--"
    end
  end

  def new
    @shortlink = Shortlink.new
  end

  def edit
    @shortlink = Shortlink.new
    if (current_user == nil) # nobody logged in
      redirect_to shortlinks_path, :alert => "Access denied. Please log in."
    elsif (current_user.email != ENV["ADMIN_EMAIL"]) || # current_user is admin
      (current_user.id != @shortlink.user_id) # current_user created the link
      redirect_to shortlinks_path, :alert => "Access denied. You can only delete
      a link if you created it while logged in, or if you are an admin."
    else
      @shortlink = Shortlink.find(params[:id])
    end
  end

  def create
    @shortlink = Shortlink.new(shortlink_params)
    if (current_user != nil)
      @shortlink.user_id = current_user.id
    end

    # catch exceptions
    if @shortlink.save
      redirect_to @shortlink
    else # something went wrong when saving, reload new
      render 'new'
    end
  end

  def update
    @shortlink = Shortlink.find(params[:id])

    if @shortlink.update(shortlink_params)
      redirect_to @shortlink
    else # something went wrong when updating, reload edit
      render 'edit'
    end
  end

  def destroy
    @shortlink = Shortlink.find(params[:id])
    if (current_user == nil) # nobody logged in
      redirect_to shortlinks_path, :alert => "Access denied. Please log in."
    elsif (current_user.email != ENV["ADMIN_EMAIL"]) || # current_user is admin
      (current_user.id != @shortlink.user_id) # current_user created the link
      redirect_to shortlinks_path, :alert => "Access denied. You can only delete
      a link if you created it while logged in, or if you are an admin."
    else
      @shortlink.destroy
      redirect_to shortlinks_path # go back to all shortlinks
    end
  end

  def redir
    @shortlink = Shortlink.find_by(short_url: params[:short_url])

    if @shortlink
      @shortlink.increment!(:clicks)
      redirect_to @shortlink.long_url
    else
      render :template =>"/shortlinks/404-link", :status => 404
    end
  end

  private
    def shortlink_params
      params.require(:shortlink).permit(:short_url, :long_url, :user_id)
    end
end
