class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @comments = @user.comments.includes(:tweet).order(created_at: :desc)
  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to action: "index"
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :age, :prefecture)
  end
end
