class Messenger::ChatmessagesController < ApplicationController
  def index
      @current_chat_user=User.current

      @chat_partners=Messenger::Openchat.find(:all,:conditions => "creator_id = '#{@current_chat_user.id}'")
      @database_answer=Chatmessage.find(:last,:conditions => "creator_id='#{@current_chat_user.id}'")
      if @database_answer!=nil
      @latest_chat_partner=@database_answer.receiver_id
      end
      
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
  end
  
  def create
      if params[:create][:content]!="" 
        #Essential for notifications:
        @r_old_channel = Messenger::Openchat.find(:last)
        params[:create][:creator_id]=User.current.id
        params[:create][:username]=User.current.login
        @message = Chatmessage.create!(params[:create])
      end
  end
  
  
end
