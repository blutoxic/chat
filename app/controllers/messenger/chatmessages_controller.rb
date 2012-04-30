class Messenger::ChatmessagesController < ApplicationController
  def index
      @current_user=User.current

      @chat_partners=Messenger::Openchat.find(:all,:conditions => "creator_id = '#{@current_user.id}'")
      
      @chat_messages = Array.new(2, Hash.new)
      
      
      
      
      @chat_partners.each do |chat_partner| 
  				if chat_partner.chat_partner_id == 1 then
  				  @message_data_public=Chatmessage.find(:all,:conditions => "receiver_id = 1")

  				else 
  				  @message_data = Chatmessage.find(:all,:conditions => "creator_id='"+chat_partner.chat_partner_id+"' and receiver_id = '" + 
  				  User.current.id + "' or username='"+User.current.id+"' and receiver_id = '" + chat_partner.chat_partner_id + "'")
  				end
  				
  				if chat_partner.chat_partner_id != User.current.id then
  				  @message_data.each do |message|
  				    @chat_messages[message][chat_partner.chat_partner_id]=@message_data.content
				    end
  				  #render :partial => "chats/chat_form", :locals=>{:channel_id=>chat_partner.id, :channel=>chat_partner.open_chat_user,:messages=>@message_data} 
  				end
  		end
=begin
      public_entry=false
    	@chat_partners.each do |chat_partner|
    	  if chat_partner.chat_partner_id=="public"
    	    public_entry=true
    	    break
    	  end
    	end
    	if public_entry==false
    	  @open_chat=Openchat.new
        @open_chat.user=@current_user.login
        @open_chat.chat_partner_id="public"
        @open_chat.save
        @chat_partners.push(@open_chat)
    	end
=end
  end
end
