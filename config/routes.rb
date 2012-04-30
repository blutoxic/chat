Rails.application.routes.draw do
  namespace :messenger do
    resources :chatmessages
    resources :openchats
    root :to => "chatmessages#index"
  end
end