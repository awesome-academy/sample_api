class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :destroy, :update]
  swagger_controller :users, "User Management"

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  swagger_api :create do
    summary "To create user"
    notes "Implementation notes, such as required params, example queries for apis are written here."
    param :form, "user[email]", :string, :required, "Email of user"
    param :form, "user[password]", :string, :optional, "Age of user"
    response :success
    response :unprocessable_entity
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
