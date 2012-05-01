jQuery.fn.exists = function(){return this.length>0;}


$(document).ready(function() {
  var faye = new Faye.Client('http://localhost:9292/faye');
  
  var subscriptions = [faye.subscribe('/messages/'+user_id, function(data) {
        eval(data);
   })];
     
   subscriptions.push(faye.subscribe('/messages/0', function (data) {eval(data); }));
});

function toggleWindows(window_id) {
    if (last_toggle!=window_id) {
    	$('#chat_window_'+last_toggle).toggle('fast', function() { 
    	    	$('#chat_window_'+window_id).toggle('fast', function () {
    	    	    $('#chat_window_'+window_id).scrollTo('100%',50);
    	    	    if($('#message_counter_'+window_id).is(':visible') ) {
    	    	        $('#message_counter_'+window_id).toggle('fast');
	    	        }
        			last_toggle=window_id;
        			if(last_toggle!=0) {
        			    window.history.pushState(new Object(), "Titel", "?chat_partner_id="+last_toggle);
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
                            
                             $("#recent_link_"+openchat_id).toggle('fast');
                            
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


function adduser(chat_partner_id,toggle) {
$.ajaxSettings.accepts.html = $.ajaxSettings.accepts.script;

               $.get(  
                        "/messenger/openchats/new",  
                        {chat_partner_id: chat_partner_id},  
                        function(responseText){
                            $("#chat_content").append(responseText);
                            
                            if(toggle==true) {
                                toggleWindows(chat_partner_id);
                            }
                            return true;
                        },  
                        "html"  
                    );
}