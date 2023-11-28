class Api::V1::AuthsController < ApplicationController
  def login
    user = User.find_by email: params[:email]
    if user&.authenticate params[:password]
      render json: {jwt_token: Authentication.encode({user_id: user.id})}, status: :ok
    else
      render json: {error: "Invalid email/password combination"}, status: 401
    end
  end
end
