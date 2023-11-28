class ApplicationController < ActionController::API
  require './lib/authentication'
  private

  def authenticate_user!
    token = request.headers["Jwt-Token"]
    user_id = Authentication.decode(token)["user_id"] if token
    @current_user = User.find_by_id user_id
    unless @current_user
      render json: {error: "You need to log in to use the app"}, status: 401
    end
  end
end
