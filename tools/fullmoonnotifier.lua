local url = "webhookinglololo" -- ur webhook url

getgenv().Settings = {
    ["Performance"] = {
        ["FPS Cap"] = 60,
        ["Disable Rendering"] = false
    },
}

--[[
    
            catn1qqer full moon notifier
    by thuy2#5330, console concept by cart#4780

     open-source, project started in 30/4/2023

   - Recommend using 2-8 or more accounts instead of one, this increases the chance of finding a full moon.
   - How can script hubs find full moons, mirage so fast? + They have a logger inside the script, when theres events like Mirage Island spawning or Full Moons.
     they will just log the infomations into their webhooks, thats why you can get declined sometimes because its an private server.

]]

-- // Performance // -- 

local PERFSettings = Settings["Performance"]

setfpscap(PERFSettings["FPS Cap"] or 60)
game.RunService:Set3dRenderingEnabled(not PERFSettings["Disable Rendering"])

repeat task.wait() until game:IsLoaded()
local loadTime = tick()

-- // Services // -- 

local request = syn and syn.request or http_request or http.request
local PlayerName = game.Players.LocalPlayer.Name

-- // Server Hop // --

function ServerHop() -- its skidded for now. lol
    local PlaceID = game.PlaceId
    local AllIDs = {}
    local foundAnything = ""
    local actualHour = os.date("!*t").hour
    local Deleted = false
    function TPReturner()
        local Site;
        if foundAnything == "" then
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
        else
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
        end
        local ID = ""
        if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
            foundAnything = Site.nextPageCursor
        end
        local num = 0;
        for i,v in pairs(Site.data) do
            local Possible = true
            ID = tostring(v.id)
            if tonumber(v.maxPlayers) > tonumber(v.playing) then
                for _,Existing in pairs(AllIDs) do
                    if num ~= 0 then
                        if ID == tostring(Existing) then
                            Possible = false
                        end
                    else
                        if tonumber(actualHour) ~= tonumber(Existing) then
                            local delFile = pcall(function()
                                AllIDs = {}
                                table.insert(AllIDs, actualHour)
                            end)
                        end
                    end
                    num = num + 1
                end
                if Possible == true then
                    table.insert(AllIDs, ID)
                    wait()
                    pcall(function()
                        wait()
                        game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                    end)
                    wait(0.05)
                end
            end
        end
    end
    function Teleport() 
        while wait() do
            pcall(function()
                TPReturner()
                if foundAnything ~= "" then
                    TPReturner()
                end
            end)
        end
    end
    Teleport()
end   

-- // Logging // --

rconsolename(("< catn1qqer full moon notifier (%s) > JobId: %s"):format(PlayerName, game.JobId))
rconsoleclear()
function log(...) rconsoleprint(("[catn1qqer open-sourced full moon notifier] %s\n"):format(table.concat({...}, " "))) end
function logTime(...) log(..., "|", math.round((tick() - loadTime) * 1000), "ms") end

-- // Webhook --

    ServerScript = 'game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,'..'\''..tostring(game.JobId)..'\''..')'
        for i,v in pairs(game.Players:GetPlayers()) do
            CurrentPlayers = i
        end

        if game:GetService("Lighting").Sky.MoonTextureId=="http://www.roblox.com/asset/?id=9709149431" then
            MoonStatus = '🟢'
        else
            MoonStatus = '🔴'
        end

        MoonCheck = '```'..tostring(MoonStatus)..'```'

        local data = {
            ["username"] = 'catn1qqer | full moon notifier',
            ['content'] = '@everyone',
            ["embeds"] = {
                {
                    ["title"] = "**catn1qqer | full moon notifier**",
                    ["color"] = 5539744, -- color id		
                    ["type"] = "rich",
                    ["fields"] =  {
                        {
                            ["name"] = "Current Players",
                            ["value"] = '```'..tostring(CurrentPlayers)..'/12```',
                            ["inline"] = true,
                        },
                        {
                            ["name"] = "Full Moon",
                            ["value"] = MoonCheck,
                            ["inline"] = true,
                        },
                        {
                            ["name"] = "Script",
                            ["value"] = '```lua\n'..ServerScript..'\n```',
                        },
                        {
                            ["name"] = "JobId",
                            ["value"] = '```'..tostring(game.JobId)..'```',
                        }
                    },
                    ["image"] = {
                        ["url"] = "https://media.discordapp.net/attachments/1094257958117974096/1102149775924666449/image.png?width=971&height=405", -- wtf
                    },
                    ["timestamp"] = DateTime.now():ToIsoDate(),
                }
            },
        }

-- // Full Moon // --

_G.ServerHop = false
log("false")

if game:GetService("Lighting").Sky.MoonTextureId=="http://www.roblox.com/asset/?id=9709149431" then -- Make the game find the object first, then server hop.
    log("omg :O full moon found!! sharing this to the boys rn")
    local newdata = game:GetService("HttpService"):JSONEncode(data)
    local headers = {["content-type"] = "application/json"}
    request = http_request or request or HttpPost or syn.request
    local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
    request(abcdef)
    wait(0.3)
    _G.ServerHop = true
    log("true")
else
    log("no full moon has found :( ")
    wait(0.3)
    _G.ServerHop = true
    log("true")
end

logTime("Finished searching Full Moon, server hopping..")

while _G.ServerHop do
    wait(0.05)
    ServerHop()
end
