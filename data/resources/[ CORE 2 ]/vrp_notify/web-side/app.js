$(document).ready(function(){
	window.addEventListener("message",function(event){
		var html = "<div id='"+event.data.css+"'>"+event.data.mensagem+"</div>"
		$(html).fadeIn(100).appendTo("#notifications").delay(event.data.timer).fadeOut(100);
	})
});