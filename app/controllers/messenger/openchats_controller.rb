class Messenger::OpenchatsController < ApplicationController
  def index

  end
  
  def new
    @r_old_channel = Messenger::Openchat.find(:last).id
    @message_data= Chatmessage.find(:all,:conditions => "creator_id='#{params[:chat_partner_id]}' and receiver_id = '#{User.current.id}' 
    or creator_id='#{User.current.id}' and receiver_id = '#{params[:chat_partner_id]}'")
    respond_to do |format|
      format.js { 
        @database_answer=Messenger::Openchat.find_or_create_by_chat_partner_id_and_creator_id(params[:chat_partner_id],User.current.id)
        if (@database_answer.chat_partner_id!=params[:chat_partner_id])
          render :partial => "chatmessages/chat_form", :locals=>{:channel_id=>params[:chat_partner_id], :messages=>@message_data}
        end
      } 
    end
  end
end
