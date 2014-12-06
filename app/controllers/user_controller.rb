class UserController < ApplicationController
  
  def create

    @user = User.new(user_params)
    @user.password = params[:password]

    if @user.save
      render json: @user, status: 201 
    else
      render json: params[:user], status: 406 
    end

  end

  private

  def user_params

    { :name  => params[:name], 
      :email => params[:email], 
      :password_hash => nil }  if User.valid_password(params[:password])

  end

end
