Rails.application.routes.draw do
  namespace :messenger do
    resources :chatmessages
    root :to => "chatmessages#index"
  end
end