class Messenger::OpenchatsController < ApplicationController
  def index
    @openchats=Openchat.find(:all)
  end
end
