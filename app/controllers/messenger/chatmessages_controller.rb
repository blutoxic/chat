class Messenger::ChatmessagesController < ApplicationController
  def index
      @current_chat_user=User.current

      @chat_partners=Messenger::Openchat.find(:all,:conditions => "creator_id = '#{@current_chat_user.id}'")

      @latest_chat_partner=Chatmessage.find(:last,:conditions => "creator_id='#{@current_chat_user.id}'").receiver_id

      public_entry=false
    	@chat_partners.each do |chat_partner|
    	  if chat_partner.chat_partner_id==0
    	    public_entry=true
    	    break
    	  end
    	end
    	if public_entry==false
    	  @open_chat=Messenger::Openchat.new
        @open_chat.creator_id=@current_chat_user
        @open_chat.chat_partner_id=0
        @open_chat.save
        @chat_partners.push(@open_chat)
    	end

      @chat_messages = Array.new(2, Hash.new)
  
      
      @chat_partners.each do |chat_partner| 

  		@message_data=Chatmessage.find(:all,:conditions => "creator_id='#{chat_partner.chat_partner_id}' and receiver_id = '
  		#{@current_chat_user.id}' or creator_id='#{@current_chat_user.id}' and receiver_id = '#{chat_partner.chat_partner_id}'")

  			#	if chat_partner.chat_partner_id != @current_chat_user.id then
  			#	  if @message_data!=nil
  			#	    @message_data.each do |message|
  			#	      @chat_messages[message][chat_partner.chat_partner_id]=@message_data.content
				 #     end
			  #    end
  			#	end
  		end
  		
  	
  end
  
  def create
      if params[:create][:content]!="" 
        #Essential for notifications:
        @r_old_channel = Messenger::Openchat.find(:last)
        params[:create][:creator_id]=User.current.id
        @message = Chatmessage.create!(params[:create])
      end
  end
  
  
end
