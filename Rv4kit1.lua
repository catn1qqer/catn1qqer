local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

print("load")

local Window = Library:CreateWindow({
    Title = 'thuys v4 kit | Race V4',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local Tabs = {
    Main = Window:AddTab('Main'),
    Server = Window:AddTab('Server'),
}

-- Tweens --

function TP2(P1)
    local Distance = (P1.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if Distance < 150 then
        Speed = 20000
    elseif Distance < 200 then
        Speed = 5000
    elseif Distance < 300 then
        Speed = 1030
    elseif Distance < 500 then
        Speed = 725
    elseif Distance < 1000 then
        Speed = 365
    elseif Distance >= 1000 then
        Speed = 365
    end
    game:GetService("TweenService"):Create(
        game.Players.LocalPlayer.Character.HumanoidRootPart,
        TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
        {CFrame = P1}
    ):Play()
    if _G.Stop_Tween==true then
        game:GetService("TweenService"):Create(
        game.Players.LocalPlayer.Character.HumanoidRootPart,
        TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
            {CFrame = P1}
        ):Cancel()
    end
    _G.Clip = true
    wait(Distance/Speed)
    _G.Clip = false
end

-- Main --

local LeftGroupBox = Tabs.Main:AddLeftGroupbox('Teleport')

LeftGroupBox:AddLabel('Temple of Time')

local TPtotButton = LeftGroupBox:AddButton({
    Text = 'Teleport to Temple of Time (Instant)',
    Func = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(29523.484, 15094.684, -87.59)
    end,
    DoubleClick = false,
    Tooltip = 'Its annoying to use your f skill to fly to the top, why dont script?'
})

local TPtotButton = LeftGroupBox:AddButton({
    Text = 'Teleport to Mirage',
    Func = function()
        TP2(game.workspace.Map.MysticIsland.BiggTree.Part.CFrame)
    end,
    DoubleClick = false,
    Tooltip = ''
})

-- Server --

local ServerLeftGroupBox = Tabs.Server:AddLeftGroupbox('Server Features')

local RejoinButton = ServerLeftGroupBox:AddButton({
    Text = 'Rejoin',
    Func = function()
        local ts = game:GetService("TeleportService")
        local p = game:GetService("Players").LocalPlayer
        ts:Teleport(game.PlaceId, p)
    end,
    DoubleClick = false,
    Tooltip = 'Rejoins the same server.'
})

local JobIDButton = ServerLeftGroupBox:AddButton({
    Text = 'Copy JobID',
    Func = function()
        print("Copied!")
        setclipboard(game.JobId)
    end,
    DoubleClick = false,
    Tooltip = 'Rejoins the same server, F9.'
})
