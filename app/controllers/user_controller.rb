class UserController < ApplicationController

  def index
    render json: User.all
  end

  def authenticate

    @user = User.find_by(email: params[:email]) 
    if @user && @user.password == params[:password]
      render json: give_token, status: 200
    else
      render json: {'error' => 'failed to authenticate'}, status: 403
    end
    
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

  
  def give_token

    {'token' => '2348h23kh324hk243jkhk423h2'}

  end


  private


  def user_params

    params.require(:user).permit(:name, :email, :password_hash)

  end


end
