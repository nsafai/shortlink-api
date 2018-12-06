class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    # puts('admin email is:')
    # puts(ENV["ADMIN_EMAIL"]) # showing up blank for some reason
    if current_user.email == ENV["ADMIN_EMAIL"]
      @users = User.all
    else
      redirect_to root_path, :alert => "Access denied."
    end

  end

  def show
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to root_path, :alert => "Access denied."
    end
  end

end
