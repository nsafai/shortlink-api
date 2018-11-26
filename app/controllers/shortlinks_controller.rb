class ShortlinksController < ApplicationController

  def index
    @shortlinks = Shortlink.all
  end

  def show
    @shortlink = Shortlink.find(params[:id])
  end

  def new
    @shortlink = Shortlink.new
  end

  def edit
    @shortlink = Shortlink.find(params[:id])
  end

  def create
    @shortlink = Shortlink.new(shortlink_params)

    if @shortlink.save
      redirect_to @shortlink
    else
      render 'new'
    end
  end

  def update
    @shortlink = Shortlink.find(params[:id])

    if @shortlink.update(shortlink_params)
      redirect_to @shortlink
    else
      render 'edit'
    end
  end

  def destroy
    @shortlink = Shortlink.find(params[:id])
    @shortlink.destroy

    redirect_to shortlinks_path
  end

  def redir
    @shortlink = Shortlink.find_by(short_url: params[:short_url])

    if @shortlink
      redirect_to @shortlink.long_url
    else
      render :template =>"/shortlinks/404-link", :status => 404
    end
  end

  private
    def shortlink_params
      params.require(:shortlink).permit(:short_url, :long_url)
    end
end
