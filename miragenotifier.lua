local url = "your_webhook_here" -- ur webhook url

getgenv().Settings = {
    ["Performance"] = {
        ["FPS Cap"] = 15,
        ["Downgraded Quality"] = true,
        ["Disable Rendering"] = false
    },
}

--[[
    
            catn1qqer mirage notifier
    by thuy2#5330, console concept by cart#4780

     open-source, project started in 30/4/2023
]]

-- // Performance // -- 

local PERFSettings = Settings["Performance"]

setfpscap(PERFSettings["FPS Cap"] or 30)
game.RunService:Set3dRenderingEnabled(not PERFSettings["Disable Rendering"])
if PERFSettings["Downgraded Quality"] then
    local lighting = game.Lighting
    lighting.GlobalShadows = false
    lighting.FogStart = 0
    lighting.FogEnd = 0
    lighting.Brightness = 0
    settings().Rendering.QualityLevel = "Level01"

    for _,v in pairs(game:GetDescendants()) do
        if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
            v.Material = "Plastic"
            v.Reflectance = 0
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Lifetime = NumberRange.new(0)
        elseif v:IsA("Explosion") then
            v.BlastPressure = 1
            v.BlastRadius = 1
        elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
            v.Enabled = false
        elseif v:IsA("MeshPart") then
            v.Material = "Plastic"
            v.Reflectance = 0
        end
    end

    for _,e in pairs(lighting:GetChildren()) do
        if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
            e.Enabled = false
        end
    end
end

repeat task.wait() until game:IsLoaded()
local loadTime = tick()

-- // Services // -- 

local request = syn and syn.request or http_request or http.request
local PlayerName = game.Players.LocalPlayer.Name

-- // Server Hop // --

function ServerHop()
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

rconsolename(("< catn1qqer mirage notifier (%s) > JobId: %s"):format(PlayerName, game.JobId))
rconsoleclear()
function log(...) rconsoleprint(("[catn1qqer open-sourced mirage notifier] %s\n"):format(table.concat({...}, " "))) end
function logTime(...) log(..., "|", math.round((tick() - loadTime) * 1000), "ms") end

-- // Webhook --

    ServerScript = 'game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,'..'\''..tostring(game.JobId)..'\''..')'
        for i,v in pairs(game.Players:GetPlayers()) do
            PlayersMin = i
        end

        if game:GetService("Lighting").Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149431" then
            MoonStatus = '🟢'
        else
            MoonStatus = '🔴'
        end

        MoonCheck = '```'..tostring(MoonStatus)..'```'

        local data = {
            ["username"] = 'catn1qqer | mirage notifier',
            ['content'] = '@everyone',
            ["embeds"] = {
                {
                    ["title"] = "**catn1qqer | mirage notifier**",
                    ["color"] = 5539744, -- color id		
                    ["type"] = "rich",
                    ["fields"] =  {
                        {
                            ["name"] = "Current Players",
                            ["value"] = '```lua\n'..tostring(CurrentPlayers)..'/12 \n```',
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
                            ["value"] = '```lua\n'..tostring(game.JobId)..'\n```',
                        }
                    },
                    ["image"] = {
                        ["url"] = "https://media.discordapp.net/attachments/1094257958117974096/1102149775924666449/image.png?width=971&height=405", -- you can remove this but it will hurt
                    },
                    ["timestamp"] = DateTime.now():ToIsoDate(),
                }
            },
        }

-- // Mirage Island // --

_G.ServerHop = false

if workspace.Map:FindFirstChild("MysticIsland") then
    log("omg :O mirage island found!! sharing this to the boys rn")
    local newdata = game:GetService("HttpService"):JSONEncode(data)
    local headers = {["content-type"] = "application/json"}
    request = http_request or request or HttpPost or syn.request
    local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
    request(abcdef)
    wait(0.3)
    _G.ServerHop = true
else
    log("no mirage island has found :( ")
    wait(0.3)
    _G.ServerHop = true
end

logTime("Finished searching Mirage Island, server hopping..")

while _G.ServerHop do
    wait(0.05)
    ServerHop()
end
