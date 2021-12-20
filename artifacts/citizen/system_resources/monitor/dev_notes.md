## TODO v4.0.0
- [x] fixed perf chart labels
- [x] reorganize web js files
- [x] remove all `var` from web and core
- [x] core: optimize host stats collection
- [x] web: prepare html/js for nui mode (remove elements)
- [X] web: create `txAdminAPI` and replace all `$.ajax`
- [x] increase page timeouts
- [x] change webserver token every time the server starts
- [ ] xxx
- [ ] xxx
- [ ] diagnostics: use `globals.monitor.hostStats` instead of `systeminformation`
- [ ] add html file caching
- [ ] master actions deveria aparecer, mas desabilitado
- [ ] srvCmdBuffer needs to strip the color escape characters
- [ ] um monte de vars de render no ctxutils são iguais nos 3 casos de render, centralizar em uma função só






+set svgui_disable true +set txAdminMenu-debugMode true +setr txEnableMenuBeta true



nota:
- precisamos garantir que uma sessão criada via NUI seja só usada com nui
- criar um novo token, mudar no primeiro tick
- desabilitar master actions pra quando for NUI



quando falta convar
set sv_listingIPOverride "109.230.238.70"
isZapHosting, forceInterface,


// 1619440000 v3.7 -- 31/05 09:30 AM
// 1621233333 v3.8 -- 07/06 03:30 AM



stuff:
- [ ] Unrecognized event: playerJoining -- we are using playerjoining but should probably change that
- [ ] make the commands (kick, warn, etc) return success or danger, then edit DialogActionView.tsx
    - can be done by adding a randid to the command, then making the cmdBuffer match for `<id><OK|NOK>` 

- [ ] break `playerController` actions stuff to another file
- [ ] do the sv_listingIPOverride thing
- [ ] maybe remove the sv_maxclients enforcement in the cfg file
- [ ] fix the interface enforcement without port being set as zap server?
- [ ] consolidate the log pages


> ASAP!:
- [ ] a way to create admins file without cfx.re 
- [ ] add discord group whitelist (whitelist switch becomes a select box that will enable guildID and roleID)
    - Manual Approval (default)
    - Discord: be in guild
    - Discord: have a role in guild
- [ ] persistent discord status message that is set up by `/statusfixed`:
    - this will trigger a big status message to be sent in that channel
    - this message id can be stored in the config file
    - if discord id is present, use that instead of name (careful with the pings!)
- [ ] (really needed?) ignore key bindings commands https://discord.com/channels/577993482761928734/766868363041046589/795420910713831446
- [ ] add custom event for broadcast


> Hopefully now:
- [ ] check the places where I'm doing `Object.assign()` for shallow clones
- [ ] remove the ForceFXServerPort config and do either via `server.cfg` comment, or execute `endpoint_add_tcp "127.0.0.1:random"`
- [ ] create `admin.useroptions` for dark mode, welcome modals and such

> Soon™ (hopefully the next update)
- [ ] get all functions from `web\public\js\txadmin\players.js` and wrap in some object.
- [ ] maybe hardcode if(recipeName == plume) to open the readme in a new tab
- [ ] add new hardware bans
- [ ] add stats enc?
- [ ] apply the new action log html to the modal
- [ ] add `<fivem://connect/xxxxx>` to `/status` by getting `web_baseUrl` maybe from the heartbeat
- [ ] add ban server-side ban cache (last 500 bans?), updated on every ban change 
- [ ] add a commend system?
- [ ] add stopwatch (or something) to the db functions and print on `/diagnostics`

> Soon™® (hopefully in two months or so)
- [ ] tweak dashboard update checker behavior
- [ ] add an fxserver changelog page
- [ ] Social auth provider setup retry every 15 seconds
- [ ] show error when saving discord settings with wrong token
- [ ] break down `playerController` into separate files even more
- [ ] rename `playerController` to `playerManager`?

=======================================

## NUI commands
While the menu is open, show `ID | PlayerName` above nearby player heads.
The first thing selected is the tab selector, which can be operated using the arrows.
The Main menu will be fully arrow operated, but the player and txAdmin tab need to be mouse-operated

- Main Menu:
    - Teleport (submenu):
        - TP to coords (use regex)
        - TP to Marker
        - Send back (<name>) (me to my last, or player to his last)
    - Player mode (selector):
        - Nornal
        - NoClip/Invisible
        - God Mode
    - Heal Myself 
    - Spawn Car
    - Fix+Wash Car
    - Revive/Heal all players (temp)
    - Send Announcement (temp)
- Player Tab:
    - search box
    - sort options
    - player cards:
        - basic modal (DM, Warn, Kick, Ban)
        - Heal
        - TP Player to me
        - TP to Player
        - Spectate
        - Troll commands????
            - Kill
            - Set on fire
            - Wild animal attack
            - make drunk
- txAdmin Tab:
    - iframe containing txAdmin's web with some customizations:
        - menu starts collapsed
        - no logo/header
        - no footer

High-level roadmap:
- Write the lua+js code to pipe the traffic + authenticate the user
- Make HTML changes to accept iframe
- Have the react stuff done
- Do all the Lua admin stuff (spawn cars, heal people & etc)
- Do all the txAdmin backend code to support those functions
- Finish the interface (Look & Feel)

=======================================

## Database Management page
- erase all whitelists
- erase all bans
- erase all warnings
- Prune Database:
    All options will be select boxes containing 3 options: none, conservative, aggressive
    - Players (without notes) innactive for xxx days: 60, 30
    - Warns older than xx days: 30, 7
    - Bans: revoked, revoked or expired
Add a note that to erase the entire database, the user should delete the `playersDB.json` (full path) file and restart txAdmin.
Pre calculate all counts

=======================================

## Structured traces

### Rate limiter
We could be more sensible when restarting the server and pushing an event to alert other resources thatm ight want to auto block it.
```bat
netsh advfirewall firewall add rule name="txAdmin_block_XXXX" dir=in interface=any action=block remoteip=198.51.100.108/32
netsh advfirewall firewall show rule name="txAdmin_block_XXXX"
netsh advfirewall firewall delete rule name="txAdmin_block_XXXX"
```

### Oversized resources streams
We could wait for the server to finish loading, as well as print in the interface somewhere an descending ordered list of large resource assets
https://github.com/citizenfx/fivem/blob/649dac8e9c9702cc3e293f8b6a48105a9378b3f5/code/components/citizen-server-impl/src/ResourceStreamComponent.cpp#L435

### Crash dumps

=======================================

## Video tutorials
Requirements:
    - 2 non-rp recipes
    - Separate master actions page
### [OFFICIAL] How to make a FiveM Server tutorial 2021 for beginners!
Target: absolute beginners, barely have a vps
- Requirements:
    - Needs to be a VPS (show suggestion list)
    - OS: windows server 2016 or 2019 recommended
    - Hardware specs recommendation
    - Download Visual C++
    - You need a forum account (show page, don't go trough)
    - Create server key
    - Download xamp (explain most servers require, show heidisql page)
- Open firewall ports (show windows + OVH)
- Download artifact (show difference between latest and latest recommended)
- Set folder structure
- Run txAdmin (should open chrome, if it doesn't, then open manually)
- Open page outside VPS to show the ip:port thing
- Create master account
- Setup:
    - Present options
    - Run PlumeESX recipe
    - Master Actions -> Reset FXServer Settings
    - Setup local folder (show endpoint + server.cfg.txt errors)
- Show how to create admins
- Callout for advanced tutorial
### [OFFICIAL] How to update your FiveM Server tutorial 2021
Target: server owners that followed the stupid Jeva tutorial
- Why windows only
- Show current stupid folder structure
- Download artifact (show difference between latest and latest recommended)
- Set new folder structure
- Run txAdmin (should open chrome, if it doesn't, then open manually)
- Create master account
- Setup (show endpoint + server.cfg.txt errors)
- Show how to create admins
- Open firewall port 40120 (show windows + OVH)
- Callout for advanced tutorial
### [OFFICIAL] txAdmin v3 advanced guide 2021
Target: average txAdmin users
- creating admins
- multiple servers
- discord bot
- discord login
- database pruning 
- scheduled restarter

=======================================

## Bot Commands:
DONE:
/addwl <wl req id>
/addwl <license>

TODO: Bot commands (in dev order):
/kick <mention>
/log <mention> - shows the last 5 log entries for an discord identifier (make it clear its only looking for the ID)
/ban <mention> <time> <reason>
/unban <ban-id>

/info - shows your info like join date and play time
/info <mention> - shows someone else's info
/addwl <mention>
/removewl <mention>

=======================================

## CLTR+C+V
```bash
# run
export CURR_FX_VERSION="3247"
alias cdmon="cd /e/FiveM/builds/$CURR_FX_VERSION/citizen/system_resources/monitor"

nodemon +set txDebugPlayerlistGenerator truex +set txAdminVerbose truex
nodemon +set txDebugPlayerlistGenerator true +set txAdminRTS "deadbeef00deadbeef00deadbeef00deadbeef00deadbeef" +set txAdminVerbose truex
nodemon +set txDebugPlayerlistGenerator true +set txDebugExternalSource "x.x.x.x:30120" +set txAdminVerbose truex

# build
rm -rf dist && npm run build && explorer dist
# fix this command later, the zip generated is too big and malformed
rm -rf dist && npm run build && tar.exe -cvf dist/monitor.zip dist/* && explorer dist

# other stuff
export TXADMIN_DEFAULT_LICENSE="YourKeyYourKeyYourKeyYourKeyYour"
npm-upgrade
con_miniconChannels script:monitor*

# eslint stuff
npx eslint ./src/**
npx eslint ./src/** -f ./lint-formatter.js
npx eslint ./src/** --fix

# hang fxserver (runcode)
console.log('hanging the thread for 60s');
Atomics.wait(new Int32Array(new SharedArrayBuffer(4)), 0, 0, 60 * 1000);
console.log('done');
```

```json
{
    "interface": "192.168.0.123",
    "fxServerPort": 30120,
    "txAdminPort": 40120,
    "loginPageLogo": "https://github.com/tabarra/txAdmin/raw/master/docs/banner.png",
    "defaults": {
        "license": "YourKeyYourKeyYourKeyYourKeyYour",
        "maxClients": 10,
        "mysqlHost": "mysql-mariadb-20-104.zap-hosting.com",
        "mysqlUser": "xxxxxxxxxx",
        "mysqlPassword": "xxxxxxxxxx",
        "mysqlDatabase": "xxxxxxxxxx"
    },
    "customer": {
        "name": "tabarra",
        "password_hash": "$2y$12$WNuN6IxozL4CjgScsLvmGOmxtskg8EcPe67HtUw0ENeCCSaZ.z3AW"
    },

    "interface-": false,
    "loginPageLogo-": false,
    "customer-": false
}

```

=======================================

## Links + Random Stuff

### CoreUI Stuff + Things I use
https://simplelineicons.github.io
https://coreui.io/demo/3.1.0/#icons/coreui-icons-free.html
https://coreui.io/demo/3.0.0/#colors.html
https://coreui.io/docs/content/typography/

https://www.npmjs.com/package/humanize-duration
https://kinark.github.io/Materialize-stepper/


### Reference stuff
https://www.science.co.il/language/Locale-codes.php


### Log Stuff:
https://www.npmjs.com/package/rotating-file-stream
https://www.npmjs.com/package/file-stream-rotator
https://www.npmjs.com/package/simple-node-logger
https://www.npmjs.com/package/infinite-scroll


### "Look into it"
https://www.reddit.com/r/javascript/comments/91a3tp/why_is_there_no_small_sane_nodejs_tool_for/

"State bag" support for C#
https://github.com/citizenfx/fivem/pull/516
https://github.com/citizenfx/fivem/pull/539


### server deployer original idea
https://discordapp.com/channels/192358910387159041/450373719974477835/701336723589955654

### the ace permissions editor thing
https://discordapp.com/channels/192358910387159041/450373719974477835/724266730024861717
maybe playerConnecting and then set permission by ID?
https://github.com/citizenfx/fivem/commit/fd3fae946163e8af472b7f739aed6f29eae8105f

### the fun command thing
https://github.com/VenomXNL/XNLRideAnimals/blob/master/XNLRideAnimals/client.lua
https://docs.fivem.net/docs/game-references/ped-models/#animals
https://github.com/SFL-Master/Peds/blob/master/client/main.lua
https://forum.cfx.re/t/peds-attack-players/3467/4
https://forum.cfx.re/t/request-how-to-create-aggressive-npcs/583370
https://forum.cfx.re/t/i-want-to-make-a-spawned-npc-attack-players/462463


=======================================

### Global vs Individual Modules
- Global
    - authenticator
    - discordBOT
    - logger
    - webserver
    - translator
    - players db (new)
    - config global (new)

- Individual
    - fxrunner
    - monitor
    - configvault

### Global vs Individual Pages
- Full Dashboard: Each row will be be one server, with: controls, stats (players, hitches, status), player chart
- Players
- Diagnostics: host + processes + multiple individual server info
- Admin Manager
- txAdmin Log
- Global Settings
- Servers:
    - live console
    - resources
    - log
    - cfg editor
...and maybe more, but now I'm going to sleep
