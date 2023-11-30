require "rails_helper"
RSpec.describe Api::V1::UsersController, type: :request do
  let(:valid_attributes) {
    {email: "example@test.com", password: "123123"}
  }
  let(:invalid_attributes) {
    {email: "example", password: "123123"}
  } 
  before do
    params = {email: "nguyen.van.a@gmail.com", password: "123456"}
    user = User.create! params
    log_in(params)
    user_token = JSON.parse(response.body)["jwt_token"]
    @user_headers = {"Jwt-Token": "#{user_token}"}
  end
  describe "GET #show" do
    it "renders a successful response" do
      user = User.create! valid_attributes
      get api_v1_user_url(user), headers: @user_headers, as: :json
      expect(response).to be_successful
      user_response = JSON.parse(response.body, symbolize_names: true)
      expect(user_response[:email]).to eql user.email
    end
    it "renders a not_found response" do
      get api_v1_user_url(id: 10), headers: @user_headers, as: :json
      expect(response).to have_http_status(:not_found)
      user_response = JSON.parse(response.body)
      expect(user_response).to eql({})
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new User" do
        expect {
          post api_v1_users_url, headers: @user_headers,
            params: { user: valid_attributes }, as: :json
        }.to change(User, :count).by(1)
      end
 
      it "renders a JSON response with the new user" do
        post api_v1_users_url, headers: @user_headers,
             params: { user: valid_attributes }, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:email]).to eql valid_attributes[:email]
      end
    end

    context "with invalid parameters" do
      it "does not create a new User" do
        expect {
          post api_v1_users_url, headers: @user_headers,
            params: { user: invalid_attributes }, as: :json
        }.to change(User, :count).by(0)
      end
 
      it "renders a JSON response with errors for the new user" do
        post api_v1_users_url, headers: @user_headers,
          params: { user: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response).to eql(["Email is invalid"])
      end
    end
  end

  describe "PATCH #update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {email: "new@test.com", password: "123123"}
      }
 
      it "updates the requested user" do
        user = User.create! valid_attributes
        patch api_v1_user_url(user), headers: @user_headers,
          params: { user: new_attributes }, as: :json
        user.reload
        expect(user.email).to eql new_attributes[:email]
        expect(user.password).to eql new_attributes[:password]
      end

      it "renders a JSON response with the user" do
        user = User.create! valid_attributes
        patch api_v1_user_url(user), headers: @user_headers,
          params: { user: new_attributes }, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:email]).to eql new_attributes[:email]
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the user" do
        user = User.create! valid_attributes
        patch api_v1_user_url(user), headers: @user_headers,
          params: { user: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response).to eql(["Email is invalid"])
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested user" do
      user = User.create! valid_attributes
      expect {
        delete api_v1_user_url(user), headers: @user_headers, as: :json
      }.to change(User, :count).by(-1)
    end
  
    it "response status code" do
      user = User.create! valid_attributes
      delete api_v1_user_url(user), headers: @user_headers, as: :json
      expect(response).to have_http_status(204)
    end
  end
 
 private
 def log_in params
    post api_v1_login_url(params)
 end
end
