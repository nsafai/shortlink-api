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
    @article = Article.find(params[:id])
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

  private
    def shortlink_params
      params.require(:shortlink).permit(:short_url, :long_url)
    end
end
