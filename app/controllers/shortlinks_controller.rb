class ShortlinksController < ApplicationController

  def index
    @shortlinks = Shortlink.order("clicks DESC").all
  end

  def show
    @shortlink = Shortlink.find(params[:id])
  end

  def new
    @shortlink = Shortlink.new
  end

  def edit
    @shortlink = Shortlink.new

    if (current_user == nil) # nobody logged in
      redirect_to shortlinks_path, :alert => "Access denied. Please log in."
    elsif @shortlink.user_id.blank? && (current_user.email != ENV["ADMIN_EMAIL"]) # shortlink was created by a guest user && current_user is not admin
      redirect_to shortlinks_path, :alert => "Access denied. This link was created by a guest user and can only be edited by an admin."
    elsif (current_user.id != @shortlink.user_id) # current_user did not create the link
      redirect_to shortlinks_path, :alert => "You can not edit this link. It was created by another user."
    else # user is either an admin or they created the link
      @shortlink = Shortlink.find(params[:id])
    end
  end

  def create
    @shortlink = Shortlink.new(shortlink_params)
    begin
      @shortlink.user_id = current_user.id
    rescue NoMethodError
      @shortlink.user_id = nil
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
    elsif (@shortlink.user_id == nil) && (current_user.email != ENV["ADMIN_EMAIL"]) # shortlink was created by a guest user && current_user is not admin
      redirect_to shortlinks_path, :alert => "Access denied. This link was created by a guest user and can only be deleted by an admin."
    elsif (current_user.id != @shortlink.user_id) # current_user did not create the link
      redirect_to shortlinks_path, :alert => "You can not delete this link. It was created by another user."
    else # user is either an admin or they created the link
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
