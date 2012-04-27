Rails.application.routes.draw do
  namespace :messenger do
    resources :chats
  end
end