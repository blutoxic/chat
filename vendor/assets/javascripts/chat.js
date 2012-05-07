jQuery.fn.exists = function(){return this.length>0;}


$(document).ready(function() {
  var faye = new Faye.Client('http://demo.i-v-o.ch:9292/faye');
  
  var subscriptions = [faye.subscribe('/messages/'+user_id, function(data) {
        eval(data);
   })];
     
   subscriptions.push(faye.subscribe('/messages/0', function (data) {eval(data); }));
});

function addUser(chat_partner_id,toggle) {
$.ajaxSettings.accepts.html = $.ajaxSettings.accepts.script;
                //Get window
               $.get(  
                        "/messenger/openchats/new",  
                        {chat_partner_id: chat_partner_id},  
                        function(responseText){
                            
                            $("#chat_content").append(responseText)
                            if(toggle==true) {
                                toggleWindows(chat_partner_id);
                            }
                            return true;
                        },  
                        "html"  
                    );
                 //Get li
                $.get(  
                        "/messenger/openchats/show",  
                         {chat_partner_id: chat_partner_id},  
                         function(responseText){
                             
                             $("#recent_chats").append(responseText, function(){
                                 createNotification(chat_partner_id,unread_messages[chat_partner_id]+1)
                             });                           
                            },  
                         "html"  
                 );
}

function toggleWindows(window_id,recent_id) {
    if (last_toggle!=window_id) {
    	$('#chat_window_'+last_toggle).toggle('fast', function() { 
    	    	$('#chat_window_'+window_id).toggle('fast', function () {
    	    	   
    	    	    $('#container_'+window_id).scrollTo('100%',0);
    	    	    if($('#message_counter_'+window_id).is(':visible') ) {
    	    	        $('#message_counter_'+window_id).toggle('fast');
    	    	        if (recent_id) {
    	    	            $('#recent_link_'+recent_id).removeClass('red');
    	    	            alert(recent_id);
	    	            }
	    	        }
	    	        
        			last_toggle=window_id;
        			if(last_toggle!=0) {
        			    window.history.pushState(new Object(),window_id, "?chat_partner_id="+last_toggle);
    			    }
        			});
    		});
	}	
}


function removeUser(openchat_id,toggle_id) {
    $.ajaxSettings.accepts.html = $.ajaxSettings.accepts.script;

                    $.ajax({
                       url: '/messenger/openchats/'+openchat_id,
                        type: 'DELETE',
                        success: function() {
                            
                             $("#recent_link_"+openchat_id).toggle('fast', function(){
                                 $("#recent_link_"+openchat_id).remove();
                                  window.history.pushState(new Object(),openchat_id, "?chat_partner_id=0");
                             });
                            
                                   toggleWindows(0);
                                   
                                
                        }
                    }); 
}

function createNotification(channel_id,number) {
    if(number!=0) {
        $('#message_counter_'+channel_id).text(number);
        if($('#message_counter_'+channel_id).is(':hidden') ) {
            $('#message_counter_'+channel_id).toggle('fast');
        }
    }
}

