fx_version "bodacious"
game "gta5"

ui_page "web-side/index.html"

client_scripts {
	"@vrp/lib/vehicles.lua",
	"@vrp/lib/itemlist.lua",
	"@PolyZone/client.lua",
	"@vrp/lib/utils.lua",
	"client-side/*"
}

server_scripts {
	"@vrp/lib/vehicles.lua",
	"@vrp/lib/itemlist.lua",
	"@vrp/lib/itemlist.lua",
	"@vrp/lib/utils.lua",
	"server-side/*"
}

files {
	"web-side/*",
	"web-side/**/*"
}

exports {
	"AddButton","SetTitle"
}