class ShortlinksController < ApplicationController
  def redir
    @shortlink = Shortlink.find(params[:short_url])
  end

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

  private
    def shortlink_params
      params.require(:shortlink).permit(:short_url, :long_url)
    end
end
