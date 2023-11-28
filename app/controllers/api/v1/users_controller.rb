class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :destroy, :update]
  # GET /users/1
  def show
    render json: @user
  end

  def create
    @user = User.new user_params
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end
 
  def update
    if @user.update user_params
      render json: @user, status: :ok
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    head 204
  end 

  private
  def set_user
    @user = User.find_by(id:params[:id])
    return if @user
    render json: {}, status: :not_found
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
  
end
