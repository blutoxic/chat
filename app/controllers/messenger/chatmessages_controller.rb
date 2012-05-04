class Messenger::ChatmessagesController < ApplicationController
=begin
  Function index (will be used after every loading of the chat-page):
  The variable "chat_partner_id" corresponds to User-IDs in the database and the Channel-ID of the Faye Server.
=end
  def index
=begin
    If the URL contains a variable named after "char_partner_id" (e.g. /messenger?chat_partner_id=2), the function loads the corresponding User into
    the array "chat_partner". Else the array "chat_partner" gets the ID of the public channel (zero).
=end
    if params[:chat_partner_id]
      @chat_partner  =  User.find(params[:chat_partner_id]).id
      Messenger::Openchat.find_or_create_by_chat_partner_id_and_creator_id(@chat_partner,User.current.id)
    else
      @chat_partner  =  0
    end
    # The current user of the chat will be loaded into the following array:
    @current_chat_user  =  User.current
    # Chatpartners which have been added by the user himself will be loaded into the following array:
    @recent_chats = Messenger::Openchat.find(:all,:conditions  => "creator_id  =  '#{@current_chat_user.id}'")
=begin
    If the Controller finds an entry in which the public chatroom is stated as created from the current user,
    it will be loaded into this array. Otherwise the Controller creates a new public chatroom entry and loads 
    it into the array too.
=end
    @open_chat_public = Messenger::Openchat.find_or_create_by_chat_partner_id_and_creator_id(0,User.current.id)
    # The last open chat entry will be loaded here
    @database_answer = Messenger::Openchat.find(:last,:conditions  => "creator_id = '#{@current_chat_user.id}'")
    # If the public chatroom entry had to be created in line 26, it must be loaded into the array recent_chats too here:
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
