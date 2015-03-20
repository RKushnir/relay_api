Rails.application.routes.draw do
  resource :api, only: :show
end
