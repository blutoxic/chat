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
        			last_toggle=window_id;
        			});
    		});
	}	
}

function adduser(chat_partner_id) {
$.ajaxSettings.accepts.html = $.ajaxSettings.accepts.script;

               $.get(  
                        "/messenger/openchats/new",  
                        {chat_partner_id: chat_partner_id},  
                        function(responseText){  
                            $("#chat_scrollbar").append(responseText);
                            toggleWindows(chat_partner_id);
                            return true;
                        },  
                        "html"  
                    );
}