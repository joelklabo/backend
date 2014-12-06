class UserController < ApplicationController

  def index
    render json: User.all
  end
  
  def create

    @user = User.new(user_params)
    @user.password = params[:password]

    if @user.save
      render json: @user, status: 201 
    else
      render json: @user.errors, status: 406 
    end

  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password_hash)
  end

end
