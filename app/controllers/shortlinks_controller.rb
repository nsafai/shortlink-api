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

    if current_user.blank?
      # EROR: nobody logged in
      redirect_to shortlinks_path, :alert => "Please log in to edit this link."
    elsif (current_user.email != ENV["ADMIN_EMAIL"])
      # SUCCESS: user is admin, let them do whatever they want
      @shortlink = Shortlink.find(params[:id])
    elsif @shortlink.user_id.blank?
      # ERROR: shortlink was created by a guest user
      redirect_to shortlinks_path, :alert => "You can not edit this link because it was created by a guest user. It can only be edited by an admin."
    elsif (current_user.id == @shortlink.user_id)
      # SUCCESS: current_user created the link
      @shortlink = Shortlink.find(params[:id])
    elsif (current_user.id != @shortlink.user_id)
      # ERROR: current_user did not create the link
      redirect_to shortlinks_path, :alert => "You can not edit this link. It was created by another user."
    else
      # ERROR: catch all
      redirect_to shortlinks_path, :alert => "An unknown error has occurred. Please contact shortlinks-api@gmail.com if this happens again."
    end
  end

  def create
    @shortlink = Shortlink.new(shortlink_params)

    if current_user.blank?
      @shortlink.user_id = nil
    else
      @shortlink.user_id = current_user.id
    end

    if @shortlink.save
      redirect_to @shortlink
    else
      # something went wrong when saving, reload new
      render 'new'
    end
  end

  def update
    @shortlink = Shortlink.find(params[:id])

    if @shortlink.update(shortlink_params)
      redirect_to @shortlink
    else
      # something went wrong when updating, reload edit
      render 'edit'
    end
  end

  def destroy
    @shortlink = Shortlink.find(params[:id])

    if current_user.blank?
      # EROR: nobody logged in
      redirect_to shortlinks_path, :alert => "Please log in to delete this link."
    elsif (current_user.email != ENV["ADMIN_EMAIL"])
      # SUCCESS: user is admin, let them do whatever they want
      @shortlink.destroy
      redirect_to shortlinks_path # go back to all shortlinks
    elsif @shortlink.user_id.blank?
      # ERROR: shortlink was created by a guest user
      redirect_to shortlinks_path, :alert => "You can not edit this link because it was created by a guest user. It can only be deleted by an admin."
    elsif (current_user.id == @shortlink.user_id)
      # SUCCESS: current_user created the link
      @shortlink.destroy
      redirect_to shortlinks_path # go back to all shortlinks
    elsif (current_user.id != @shortlink.user_id)
      # ERROR: current_user did not create the link
      redirect_to shortlinks_path, :alert => "You can not delete this link. It was created by another user."
    else
      # ERROR: catch all
      redirect_to shortlinks_path, :alert => "An unknown error has occurred. Please contact shortlinks-api@gmail.com if this happens again."
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
