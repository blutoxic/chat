class Messenger::ChatmessagesController < ApplicationController
  def index
    
     
     
    	if params[:chat_partner_id]
    	    @latest_chat_partner=User.find(params[:chat_partner_id]).id
      	  Messenger::Openchat.find_or_create_by_chat_partner_id_and_creator_id(@latest_chat_partner,User.current.id)
    	else
        @latest_chat_partner=0
      end
      
      @current_chat_user=User.current
      @chat_partners=Messenger::Openchat.find(:all,:conditions => "creator_id = '#{@current_chat_user.id}'")
      @open_chat_public=Messenger::Openchat.find_or_create_by_chat_partner_id_and_creator_id(0,User.current.id)
      
      @database_answer=Messenger::Openchat.find(:last,:conditions => "creator_id='#{@current_chat_user.id}'")
      if @chat_partners.last!=@database_answer
        @chat_partners.push(@open_chat_public)
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
