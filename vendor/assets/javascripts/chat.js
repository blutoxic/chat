$(document).ready(function() {
  var faye = new Faye.Client('http://localhost:9292/faye');
  var subscriptions = [faye.subscribe('/messages/'+user_id, function(data) {
        alert(data);
   })];
     
   subscriptions.push(faye.subscribe('/messages/1', function (data) {alert(data); }));
});