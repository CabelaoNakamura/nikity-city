$(document).ready(function(){
	window.addEventListener("message",function(event){
		switch(event["data"]["action"]){
			case "showMenu":
				$(".inventory").css("display","flex");
			break;

			case "hideMenu":
				$(".inventory").css("display","none");
				$(".ui-tooltip").hide();
			break;

			case "updateMochila":
				updateMochila();
			break;
		}
	});

	document.onkeyup = data => {
		if (data["key"] === "Escape"){
			$.post("http://highway/close");
		}
	};
});