public_session_user="new";
$(document).ready(function() {
  var faye = new Faye.Client('http://localhost:9292/faye');
  var subscriptions = [faye.subscribe('/messages/'+public_session_user, function(data) {
        alert(data);
   })];
     
   //subscriptions.push(faye.subscribe('/messages/public', function (data) {eval(data); }));
});