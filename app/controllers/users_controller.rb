class UsersController < ApplicationController
  def new
    @user = User.new
  end

  # GET /users
  def index
    @user = User.all
  end

  # GET /users/1
  def show
    @user = User.find(params[:id])
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to Sample App."
      redirect_to @user
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
