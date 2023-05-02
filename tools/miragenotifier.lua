-- // Settings // --
getgenv().Config = {
    ["Discord"] = { -- yuo cannot disable this. 
        ["WebhookUrl"] = "webhookhere",
        ["Content"] = "@everyone", -- @everyone or <@roleid/userid>, it can be just text.
        ["BrandName"] = "catn1qqer | mirage notifier", -- you can change it to your name, but this might hurt me :(
        ["ImageUrl"] = ""
    },
    ["Console"] = {
        ["Enabled"] = true,
    },
    ["ClientSettings"] = {
        ["Disable Rendering"] = false, -- also known as White Screen. (lol?)
        ["Fps Lock"] = 60
    }
}

--[[
    
            catn1qqer mirage notifier
    by thuy2#5330, console concept by cart#4780
             tested by Nighty#6300

     open-source, project started in 30/4/2023
]]

repeat task.wait() until game:IsLoaded()

loadstring(game:HttpGet("https://raw.githubusercontent.com/Thuy2y2c/catn1qqer/main/tools/uitest.lua"))() -- GET THE cutest ui 

-- // Console // --

local ConsoleSettings = Config["Console"]
local PlayerName = game.Players.LocalPlayer.Name

if ConsoleSettings["Enabled"] then
    rconsolename(("[ catn1qqer mirage notifier (%s) ] JobId: %s"):format(PlayerName, game.JobId))
    rconsoleclear()
    function log(...) rconsoleprint(("[catn1qqer open-sourced mirage notifier] %s\n"):format(table.concat({...}, " "))) end
    function logTime(...) log(..., "|", math.round((tick() - loadTime) * 1000), "ms") end
end

log("Game is loaded.")

-- // Config // --

local ClientSettings = Config["ClientSettings"]
local Discord = Config["Discord"]

-- // Config.ClientSettings // --

game.RunService:Set3dRenderingEnabled(not ClientSettings["Disable Rendering"])
setfpscap(ClientSettings["Fps Lock"])

-- // Config.Discord // --

repeat task.wait() until game:IsLoaded()

local Settings = {}
local HttpService = game:GetService("HttpService")

local SaveFileName = "serverhopjoin.json" -- thanks sea hub credits to sea hub

function SaveSettings()
  local HttpService = game:GetService("HttpService")
  if not isfolder("catn1qqer logs") then
      makefolder("catn1qqer logs")
  end
  writefile("catn1qqer logs/" .. SaveFileName, HttpService:JSONEncode(Settings))
end

function ReadSettings()
  local s,e = pcall(function()
      local HttpService = game:GetService("HttpService")
      if not isfolder("catn1qqer logs") then
          makefolder("catn1qqer logs")
      end
      return HttpService:JSONDecode(readfile("catn1qqer logs/" .. SaveFileName))
  end)
  if s then return e
  else
      SaveSettings()
      return ReadSettings()
  end
end
Settings = ReadSettings()

function HopServer()
  local function Hop()
      for i=1,100 do
          local invokep = game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer(i)
          for k,v in pairs(invokep) do
              if k~=game.JobId and v.Count < 10 then
                  if not Settings[k] or tick() - Settings[k].Time > 60*10  then
                       Settings[k] = {
                           Time = tick()
                       }
                       SaveSettings()
                      game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer("teleport",k)
                      return true
                  elseif tick() - Settings[k].Time > 60*60 then
                      Settings[k] = nil
                  end
              end
          end
      end
      return false
  end
  if not getgenv().Loaded then
      local function child(v)
          if v.Name == "ErrorPrompt" then
              if v.Visible then
                  if v.TitleFrame.ErrorTitle.Text == "Failed" then
                      HopServer()
                  end
              end
              v:GetPropertyChangedSignal("Visible"):Connect(function()
                  if v.Visible then
                      if v.TitleFrame.ErrorTitle.Text == "Failed" then
                          HopServer()
                      end
                  end
              end)
          end
      end
      for k,v in pairs(game.CoreGui.RobloxPromptGui.promptOverlay:GetChildren()) do
          child(v)
      end
      game.CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(child)
      getgenv().Loaded = true
  end
  while not Hop() do wait() end
  SaveSettings()
end

-- // Webhook // -- 

local Discord = Config["Discord"]
local url = Discord["WebhookUrl"]

ServerScript = 'game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer("teleport", '..'\''..tostring(game.JobId)..'\''..')'
for i,v in pairs(game.Players:GetPlayers()) do
    CurrentPlayers = i
end

local data = {
    ["username"] = 'catn1qqer | mirage notifier',
    ['content'] = Discord["Content"],
    ["embeds"] = {
        {
            ["title"] = '**'..tostring(Discord["BrandName"])..'**', -- LMAO WTF
            ["color"] = 5539744, -- color id		
            ["type"] = "rich",
            ["fields"] =  {
                {
                    ["name"] = "Current Players",
                    ["value"] = '```lua\n'..tostring(CurrentPlayers)..'/12 \n```',
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
                ["url"] = Discord["ImageUrl"],
            },
            ["timestamp"] = DateTime.now():ToIsoDate(),
        }
    },
}

-- // Main // --

if workspace.Map:FindFirstChild("MysticIsland") then
    log("Mirage Island found, sending notification via webhook.")

    local newdata = game:GetService("HttpService"):JSONEncode(data)
    local headers = {["content-type"] = "application/json"}
    request = http_request or request or HttpPost or syn.request
    local webhook = {Url = url, Body = newdata, Method = "POST", Headers = headers}
    request(webhook)

    _G.ServerHop = true
else
    log("No Mirage Island found.")
    _G.ServerHop = true
end

log("Finished search, server hopping")

while _G.ServerHop do
    wait(0.01)
    HopServer()
end
