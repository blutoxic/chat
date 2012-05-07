class Messenger::ChatmessagesController < ApplicationController
=begin
  Function index (will be used after every loading of the chat-page):
  The variable "chat_partner_id" corresponds to User-IDs in the database and the Channel-ID of the Faye Server.
=end
  def index

    if params[:chat_partner_id]
      @chat_partner  =  User.find(params[:chat_partner_id]).id
      Messenger::Openchat.find_or_create_by_chat_partner_id_and_creator_id(@chat_partner,User.current.id)
    else
      @chat_partner  =  0
    end

    @current_chat_user  =  User.current
    @recent_chats = Messenger::Openchat.find(:all,:conditions  => "creator_id  =  '#{@current_chat_user.id}'")
    @open_chat_public = Messenger::Openchat.find_or_create_by_chat_partner_id_and_creator_id(0,User.current.id)
    @database_answer = Messenger::Openchat.find(:last,:conditions  => "creator_id = '#{@current_chat_user.id}'")
    
    
    if @recent_chats.last != @database_answer
      @recent_chats.push(@open_chat_public)
    end	
  end
  
  def create
      if params[:create][:content] != "" 
        params[:create][:creator_id] = User.current.id
        params[:create][:username] = User.current.login
        @message = Chatmessage.create!(params[:create])
      end
  end
end
