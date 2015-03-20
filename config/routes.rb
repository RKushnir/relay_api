Rails.application.routes.draw do
  resource :api, only: :show
  get :users, to: 'apis#show'
  get :posts, to: 'apis#posts'
  get :comments, to: 'apis#comments'
end
