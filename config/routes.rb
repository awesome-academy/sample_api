Rails.application.routes.draw do
 # Api definition
 namespace :api do
   namespace :v1 do
    resources :users, only: %i(show create update destroy)
    resources :articles, only: :show
    post "/login", to: "auths#login"
   end
 end
end