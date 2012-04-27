Rails.application.routes.draw do

  mount Messenger::Engine => "/messenger"
end
