local Library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = Library:MakeWindow({Name = "catn1qqer (thuyexplode)", HidePremium = false, SaveConfig = true, ConfigFolder = "catn1qqermain", IntroText = " ", Icon ="0"})

local placeId = game.PlaceId
if placeId == 2753915549 then
	OldWorld = true
elseif placeId == 4442272183 then
	NewWorld = true
elseif placeId == 7449423635 then
	ThreeWorld = true
end

function BTP(Position)
	game.Players.LocalPlayer.Character.Head:Destroy()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Position
	wait(1)
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Position
	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
end

function TP2(P1) -- only for teleport use
	Distance = (P1.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
	if Distance < 1000 then
		Speed = 500
	elseif Distance >= 1000 then
		Speed = 350
	end
    game:GetService("TweenService"):Create(
        game.Players.LocalPlayer.Character.HumanoidRootPart,
        TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
        {CFrame = P1}
    ):Play()
    Clip = true
    wait(Distance/Speed)
    Clip = false
end

spawn(function()
    while wait(.1) do
        pcall(function()
            if Clip then
				if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
					game.Players.LocalPlayer.Character.Humanoid:ChangeState(15)
					wait(5)
				end
				PIO = false
                if not game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity") then 
					local L_1 = Instance.new("BodyVelocity")
                    L_1.Name = "BodyGyrozz"
                    L_1.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart 
                    L_1.MaxForce=Vector3.new(1000000000,1000000000,1000000000)
                    L_1.Velocity=Vector3.new(0,0,0) 
                end
            elseif PIO == false then
				for i,v in pairs(game.Players.LocalPlayer.Character.HumanoidRootPart:GetChildren()) do
					if v.Name == "BodyGyrozz" then
						v:Destroy()
						PIO = true
					end
				end
            end
        end)
    end
end)

-- [Main]

local Tab = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab:AddParagraph("Cảm ơn.","Cảm ơn bạn vì đã sử dụng catn1qqer, mình không ngờ là project mình làm có người dùng nó. Nó đã và đang ủng hộ tinh thần và mình sẽ chăm chỉ vào để làm script, làm trải nghiệm của mọi người tốt hơn. - catn1qqer (thuy)")

-- [Status]

local StatusTab = Window:MakeTab({
	Name = "Status",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local MoonStatus = StatusTab:AddLabel("Full Moon : N/Q")
local MirageStatus = StatusTab:AddLabel("Mirage Island : N/Q")
local Elite_Hunter_Status = StatusTab:AddLabel("Elite Status : N/Q")
local DimensionCountStatus = StatusTab:AddLabel("Cake Monsters : N/Q")
local ClientTime = StatusTab:AddLabel("Client Uptime : ")

spawn(function()
	while wait() do
		pcall(function()
			if game:GetService("Lighting").Sky.MoonTextureId=="http://www.roblox.com/asset/?id=9709149431" then
				MoonStatus:Set("Full Moon : True")
			else
				MoonStatus:Set("Full Moon : False")
			end
		end)
	end
end)

spawn(function()
	while wait() do
		pcall(function()
            local scripttime=game.Workspace.DistributedGameTime
            local seconds = scripttime%60
            local minutes = math.floor(scripttime/60%60)
            local hours = math.floor(scripttime/3600)
            local tempo = string.format("%.0f:%.0f:%.0f", hours ,minutes, seconds)
            ClientTime:Set("Client Uptime : "..tempo)
		end)
	end
end)

if ThreeWorld then
    spawn(function()
        while wait() do
            pcall(function()
                if game:GetService("ReplicatedStorage"):FindFirstChild("Diablo [Lv. 1750]") or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre [Lv. 1750]") or game:GetService("ReplicatedStorage"):FindFirstChild("Urban [Lv. 1750]") or game:GetService("Workspace").Enemies:FindFirstChild("Diablo [Lv. 1750]") or game:GetService("Workspace").Enemies:FindFirstChild("Deandre [Lv. 1750]") or game:GetService("Workspace").Enemies:FindFirstChild("Urban [Lv. 1750]") then
                    Elite_Hunter_Status:Set("Elite Status : Spawned")	
                else
                    Elite_Hunter_Status:Set("Elite Status : Not Spawned")	
                end
            end)
        end
    end)

    spawn(function()
        while wait() do
            pcall(function()
                if game.Workspace._WorldOrigin.Locations:FindFirstChild('Mirage Island') then
                    MirageStatus:Set("Mirage Island : True")
                else
                    MirageStatus:Set("Mirage Island : False")
                end
            end)
        end
    end)

    function CheckStatus()
        local OP = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CakePrinceSpawner")
        local Lp = tonumber(string.match(tostring(OP), "%d+"))
        local displayCount = 501 - Lp
        DimensionCountStatus:Set("Cake Monsters : "..tostring(displayCount))
    end

    spawn(function()
        while wait() do
            pcall(function()
                CheckStatus()
            end)
        end
    end)
end

-- [Mirage]

local MirageTab = Window:MakeTab({
	Name = "Mirage",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local FogRemove = MirageTab:AddButton({
    Name = "Remove Fog",
    Callback = function()
        Fog = game:GetService("Lighting").BaseAtmosphere
        Fog:Destroy()
    end,
})

local RaceActive = MirageTab:AddToggle({
    Name = "Auto Active Race",
    CurrentValue = false,
    Flag = "RaceActive", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        if Value then
            _G.sex = true
            while _G.sex do
                game:service('VirtualInputManager'):SendKeyEvent(true, "T", false, game)
                game:service('VirtualInputManager'):SendKeyEvent(false, "T", false, game)
                wait(0.1)
            end
        else
            _G.sex = false
        end
    end,
})

local MirageSection = MirageTab:AddSection({ Name = "Mirage" })

local TPHighest = MirageTab:AddButton({
    Name = "Teleport to Mirage Island",
    Callback = function()
        TP2(game.Workspace.Map.MysticIsland.BiggTree.Part.CFrame)
    end,
})

local MoonToggle = MirageTab:AddToggle({
    Name = "Auto Look Moon",
    CurrentValue = false,
    Flag = "MoonAimLock", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        if Value then
            _G.lookmoonstatus = true
            while _G.lookmoonstatus do
                -- code to look at moon goes here
                local moonDir = game.Lighting:GetMoonDirection()
                local lookAtPos = game.Workspace.CurrentCamera.CFrame.p + moonDir * 100
                game.Workspace.CurrentCamera.CFrame = CFrame.lookAt(game.Workspace.CurrentCamera.CFrame.p, lookAtPos)
                wait(0.1)
            end
        else
            _G.lookmoonstatus = false
        end
    end,
})

local TPBGear = MirageTab:AddButton({
    Name = "Tween to Blue Gear",
    Callback = function()
        TP2(game.Workspace.Map.MysticIsland.BiggTree.Part.CFrame)
    end,
})

-- [Trial]

local TrialTab = Window:MakeTab({
	Name = "Trial",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local TempleOfTimeTP = TrialTab:AddButton({
    Name = "Teleport to Temple of Time",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(29523.484, 15094.684, -87.59)
    end,
})

local TrialSection = TrialTab:AddSection({ Name = "Teleports (must be in temple of time)" })

local MinkTP = TrialTab:AddButton({Name = "Teleport to Mink Trial", Callback = function() TP2(CFrame.new(29016.262, 14887.483, -379.314)) end})
local HumanTP = TrialTab:AddButton({Name = "Teleport to Human Trial", Callback = function() TP2(CFrame.new(29233.115, 14887.483, -206.613)) end})
local SkyTP = TrialTab:AddButton({Name = "Teleport to Sky Trial", Callback = function() TP2(CFrame.new(28963.857, 14916.131, 234.286)) end})
local SharkTP = TrialTab:AddButton({Name = "Teleport to Shark Trial", Callback = function() TP2(CFrame.new(28229.066, 14887.483, -211.908)) end})
local GhoulTP = TrialTab:AddButton({Name = "Teleport to Ghoul Trial", Callback = function() TP2(CFrame.new(28673.125, 14887.184, 452.101)) end})
local CyborgTP = TrialTab:AddButton({Name = "Teleport to Cyborg Trial", Callback = function() TP2(CFrame.new(28495.311, 14892.483, -422.864)) end})

local FinishSection = TrialTab:AddSection({ Name = "Finish Trial (must be in trial)" })

-- [Teleport]

local TeleportTab = Window:MakeTab({
	Name = "Teleport",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local WorldsSection = TeleportTab:AddSection({ Name = "Sea (Worlds)" })

local TpSea1 = TeleportTab:AddButton({Name = "Teleport to First Sea", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain") end})
local TpSea2 = TeleportTab:AddButton({Name = "Teleport to Second Sea", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa") end})
local TpSea3 = TeleportTab:AddButton({Name = "Teleport to Third Sea", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou") end})

local IslandSection = TeleportTab:AddSection({ Name = "Islands" })

if OldWorld then
    TeleportTab:AddDropdown({
        Name = "Select Island to Teleport",
        Default = "WindMill",
        Options = {        
            "WindMill",
            "Marine",
            "Middle Town",
            "Jungle",
            "Pirate Village",
            "Desert",
            "Snow Island",
            "MarineFord",
            "Colosseum",
            "Sky Island 1",
            "Sky Island 2",
            "Sky Island 3",
            "Prison",
            "Magma Village",
            "Under Water Island",
            "Fountain City",
            "Shank Room",
            "Mob Island"
        },
        Callback = function(Value)
            _G.SelectIsland = Value
        end    
    })
end

if NewWorld then
    TeleportTab:AddDropdown({
        Name = "Select Island to Teleport",
        Default = "The Cafe",
        Options = {        
            "The Cafe",
            "Frist Spot",
            "Dark Area",
            "Flamingo Mansion",
            "Flamingo Room",
            "Green Zone",
            "Factory",
            "Colossuim",
            "Zombie Island",
            "Two Snow Mountain",
            "Punk Hazard",
            "Cursed Ship",
            "Ice Castle",
            "Forgotten Island",
            "Ussop Island",
            "Mini Sky Island"
        },
        Callback = function(Value)
            _G.SelectIsland = Value
        end    
    })
end

if ThreeWorld then
    TeleportTab:AddDropdown({
        Name = "Select Island to Teleport",
        Default = "Castle On The Sea",
        Options = {        
            "Mansion",
            "Port Town",
            "Great Tree",
            "Castle On The Sea",
            "MiniSky", 
            "Hydra Island",
            "Floating Turtle",
            "Haunted Castle",
            "Ice Cream Island",
            "Peanut Island",
            "Cake Island",
            "Chocolate Island",
            "Candy Island"
        },
        Callback = function(Value)
            _G.SelectIsland = Value
        end    
    })
end

local SelectIslandTP = TeleportTab:AddButton({
    Name = "Teleport to Selected Island",
    Callback = function()
        if _G.SelectIsland == "WindMill" then
            TP2(CFrame.new(979.79895019531, 16.516613006592, 1429.0466308594))
        elseif _G.SelectIsland == "Marine" then
            TP2(CFrame.new(-2566.4296875, 6.8556680679321, 2045.2561035156))
        elseif _G.SelectIsland == "Middle Town" then
            TP2(CFrame.new(-690.33081054688, 15.09425163269, 1582.2380371094))
        elseif _G.SelectIsland == "Jungle" then
            TP2(CFrame.new(-1612.7957763672, 36.852081298828, 149.12843322754))
        elseif _G.SelectIsland == "Pirate Village" then
            TP2(CFrame.new(-1181.3093261719, 4.7514905929565, 3803.5456542969))
        elseif _G.SelectIsland == "Desert" then
            TP2(CFrame.new(944.15789794922, 20.919729232788, 4373.3002929688))
        elseif _G.SelectIsland == "Snow Island" then
            TP2(CFrame.new(1347.8067626953, 104.66806030273, -1319.7370605469))
        elseif _G.SelectIsland == "MarineFord" then
            TP2(CFrame.new(-4914.8212890625, 50.963626861572, 4281.0278320313))
        elseif _G.SelectIsland == "Colosseum" then
            TP2( CFrame.new(-1427.6203613281, 7.2881078720093, -2792.7722167969))
        elseif _G.SelectIsland == "Sky Island 1" then
            TP2(CFrame.new(-4869.1025390625, 733.46051025391, -2667.0180664063))
        elseif _G.SelectIsland == "Sky Island 2" then  
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-4607.82275, 872.54248, -1667.55688))
        elseif _G.SelectIsland == "Sky Island 3" then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
        elseif _G.SelectIsland == "Prison" then
            TP2( CFrame.new(4875.330078125, 5.6519818305969, 734.85021972656))
        elseif _G.SelectIsland == "Magma Village" then
            TP2(CFrame.new(-5247.7163085938, 12.883934020996, 8504.96875))
        elseif _G.SelectIsland == "Under Water Island" then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
        elseif _G.SelectIsland == "Fountain City" then
            TP2(CFrame.new(5127.1284179688, 59.501365661621, 4105.4458007813))
        elseif _G.SelectIsland == "Shank Room" then
            TP2(CFrame.new(-1442.16553, 29.8788261, -28.3547478))
        elseif _G.SelectIsland == "Mob Island" then
            TP2(CFrame.new(-2850.20068, 7.39224768, 5354.99268))
        elseif _G.SelectIsland == "The Cafe" then
            TP2(CFrame.new(-380.47927856445, 77.220390319824, 255.82550048828))
        elseif _G.SelectIsland == "Frist Spot" then
            TP2(CFrame.new(-11.311455726624, 29.276733398438, 2771.5224609375))
        elseif _G.SelectIsland == "Dark Area" then
            TP2(CFrame.new(3780.0302734375, 22.652164459229, -3498.5859375))
        elseif _G.SelectIsland == "Flamingo Mansion" then
            TP2(CFrame.new(-483.73370361328, 332.0383605957, 595.32708740234))
        elseif _G.SelectIsland == "Flamingo Room" then
            TP2(CFrame.new(2284.4140625, 15.152037620544, 875.72534179688))
        elseif _G.SelectIsland == "Green Zone" then
            TP2( CFrame.new(-2448.5300292969, 73.016105651855, -3210.6306152344))
        elseif _G.SelectIsland == "Factory" then
            TP2(CFrame.new(424.12698364258, 211.16171264648, -427.54049682617))
        elseif _G.SelectIsland == "Colossuim" then
            TP2( CFrame.new(-1503.6224365234, 219.7956237793, 1369.3101806641))
        elseif _G.SelectIsland == "Zombie Island" then
            TP2(CFrame.new(-5622.033203125, 492.19604492188, -781.78552246094))
        elseif _G.SelectIsland == "Two Snow Mountain" then
            TP2(CFrame.new(753.14288330078, 408.23559570313, -5274.6147460938))
        elseif _G.SelectIsland == "Punk Hazard" then
            TP2(CFrame.new(-6127.654296875, 15.951762199402, -5040.2861328125))
        elseif _G.SelectIsland == "Cursed Ship" then
            TP2(CFrame.new(923.40197753906, 125.05712890625, 32885.875))
        elseif _G.SelectIsland == "Ice Castle" then
            TP2(CFrame.new(6148.4116210938, 294.38687133789, -6741.1166992188))
        elseif _G.SelectIsland == "Forgotten Island" then
            TP2(CFrame.new(-3032.7641601563, 317.89672851563, -10075.373046875))
        elseif _G.SelectIsland == "Ussop Island" then
            TP2(CFrame.new(4816.8618164063, 8.4599885940552, 2863.8195800781))
        elseif _G.SelectIsland == "Mini Sky Island" then
            TP2(CFrame.new(-288.74060058594, 49326.31640625, -35248.59375))
        elseif _G.SelectIsland == "Great Tree" then
            TP2(CFrame.new(2681.2736816406, 1682.8092041016, -7190.9853515625))
        elseif _G.SelectIsland == "Castle On The Sea" then
            TP2(CFrame.new(-5074.45556640625, 314.5155334472656, -2991.054443359375))
        elseif _G.SelectIsland == "MiniSky" then
            TP2(CFrame.new(-260.65557861328, 49325.8046875, -35253.5703125))
        elseif _G.SelectIsland == "Port Town" then
            TP2(CFrame.new(-290.7376708984375, 6.729952812194824, 5343.5537109375))
        elseif _G.SelectIsland == "Hydra Island" then
            TP2(CFrame.new(5228.8842773438, 604.23400878906, 345.0400390625))
        elseif _G.SelectIsland == "Floating Turtle" then
            TP2(CFrame.new(-13274.528320313, 531.82073974609, -7579.22265625))
        elseif _G.SelectIsland == "Mansion" then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375))
        elseif _G.SelectIsland == "Haunted Castle" then
            TP2(CFrame.new(-9515.3720703125, 164.00624084473, 5786.0610351562))
        elseif _G.SelectIsland == "Ice Cream Island" then
            TP2(CFrame.new(-902.56817626953, 79.93204498291, -10988.84765625))
        elseif _G.SelectIsland == "Peanut Island" then
            TP2(CFrame.new(-2062.7475585938, 50.473892211914, -10232.568359375))
        elseif _G.SelectIsland == "Cake Island" then
            TP2(CFrame.new(-1884.7747802734375, 19.327526092529297, -11666.8974609375))
        elseif _G.SelectIsland == "Chocolate Island" then
            TP2(CFrame.new(129.568, 25.0775, -12100))
        elseif _G.SelectIsland == "Candy Island" then
            TP2(CFrame.new(-1025.39, 14.4503, -14154.5))
        end
    end,
})

local SelectIslandTP = TeleportTab:AddButton({
    Name = "Teleport to Selected Island (Bypass TP)",
    Callback = function()
        if _G.SelectIsland == "WindMill" then
            BTP(CFrame.new(979.79895019531, 16.516613006592, 1429.0466308594))
        elseif _G.SelectIsland == "Marine" then
            BTP(CFrame.new(-2566.4296875, 6.8556680679321, 2045.2561035156))
        elseif _G.SelectIsland == "Middle Town" then
            BTP(CFrame.new(-690.33081054688, 15.09425163269, 1582.2380371094))
        elseif _G.SelectIsland == "Jungle" then
            BTP(CFrame.new(-1612.7957763672, 36.852081298828, 149.12843322754))
        elseif _G.SelectIsland == "Pirate Village" then
            BTP(CFrame.new(-1181.3093261719, 4.7514905929565, 3803.5456542969))
        elseif _G.SelectIsland == "Desert" then
            BTP(CFrame.new(944.15789794922, 20.919729232788, 4373.3002929688))
        elseif _G.SelectIsland == "Snow Island" then
            BTP(CFrame.new(1347.8067626953, 104.66806030273, -1319.7370605469))
        elseif _G.SelectIsland == "MarineFord" then
            BTP(CFrame.new(-4914.8212890625, 50.963626861572, 4281.0278320313))
        elseif _G.SelectIsland == "Colosseum" then
            BTP( CFrame.new(-1427.6203613281, 7.2881078720093, -2792.7722167969))
        elseif _G.SelectIsland == "Sky Island 1" then
            BTP(CFrame.new(-4869.1025390625, 733.46051025391, -2667.0180664063))
        elseif _G.SelectIsland == "Sky Island 2" then  
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-4607.82275, 872.54248, -1667.55688))
        elseif _G.SelectIsland == "Sky Island 3" then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
        elseif _G.SelectIsland == "Prison" then
            BTP( CFrame.new(4875.330078125, 5.6519818305969, 734.85021972656))
        elseif _G.SelectIsland == "Magma Village" then
            BTP(CFrame.new(-5247.7163085938, 12.883934020996, 8504.96875))
        elseif _G.SelectIsland == "Under Water Island" then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
        elseif _G.SelectIsland == "Fountain City" then
            BTP(CFrame.new(5127.1284179688, 59.501365661621, 4105.4458007813))
        elseif _G.SelectIsland == "Shank Room" then
            BTP(CFrame.new(-1442.16553, 29.8788261, -28.3547478))
        elseif _G.SelectIsland == "Mob Island" then
            BTP(CFrame.new(-2850.20068, 7.39224768, 5354.99268))
        elseif _G.SelectIsland == "The Cafe" then
            BTP(CFrame.new(-380.47927856445, 77.220390319824, 255.82550048828))
        elseif _G.SelectIsland == "Frist Spot" then
            BTP(CFrame.new(-11.311455726624, 29.276733398438, 2771.5224609375))
        elseif _G.SelectIsland == "Dark Area" then
            BTP(CFrame.new(3780.0302734375, 22.652164459229, -3498.5859375))
        elseif _G.SelectIsland == "Flamingo Mansion" then
            BTP(CFrame.new(-483.73370361328, 332.0383605957, 595.32708740234))
        elseif _G.SelectIsland == "Flamingo Room" then
            BTP(CFrame.new(2284.4140625, 15.152037620544, 875.72534179688))
        elseif _G.SelectIsland == "Green Zone" then
            BTP( CFrame.new(-2448.5300292969, 73.016105651855, -3210.6306152344))
        elseif _G.SelectIsland == "Factory" then
            BTP(CFrame.new(424.12698364258, 211.16171264648, -427.54049682617))
        elseif _G.SelectIsland == "Colossuim" then
            BTP( CFrame.new(-1503.6224365234, 219.7956237793, 1369.3101806641))
        elseif _G.SelectIsland == "Zombie Island" then
            BTP(CFrame.new(-5622.033203125, 492.19604492188, -781.78552246094))
        elseif _G.SelectIsland == "Two Snow Mountain" then
            BTP(CFrame.new(753.14288330078, 408.23559570313, -5274.6147460938))
        elseif _G.SelectIsland == "Punk Hazard" then
            BTP(CFrame.new(-6127.654296875, 15.951762199402, -5040.2861328125))
        elseif _G.SelectIsland == "Cursed Ship" then
            BTP(CFrame.new(923.40197753906, 125.05712890625, 32885.875))
        elseif _G.SelectIsland == "Ice Castle" then
            BTP(CFrame.new(6148.4116210938, 294.38687133789, -6741.1166992188))
        elseif _G.SelectIsland == "Forgotten Island" then
            BTP(CFrame.new(-3032.7641601563, 317.89672851563, -10075.373046875))
        elseif _G.SelectIsland == "Ussop Island" then
            BTP(CFrame.new(4816.8618164063, 8.4599885940552, 2863.8195800781))
        elseif _G.SelectIsland == "Mini Sky Island" then
            BTP(CFrame.new(-288.74060058594, 49326.31640625, -35248.59375))
        elseif _G.SelectIsland == "Great Tree" then
            BTP(CFrame.new(2681.2736816406, 1682.8092041016, -7190.9853515625))
        elseif _G.SelectIsland == "Castle On The Sea" then
            BTP(CFrame.new(-5074.45556640625, 314.5155334472656, -2991.054443359375))
        elseif _G.SelectIsland == "MiniSky" then
            BTP(CFrame.new(-260.65557861328, 49325.8046875, -35253.5703125))
        elseif _G.SelectIsland == "Port Town" then
            BTP(CFrame.new(-290.7376708984375, 6.729952812194824, 5343.5537109375))
        elseif _G.SelectIsland == "Hydra Island" then
            BTP(CFrame.new(5228.8842773438, 604.23400878906, 345.0400390625))
        elseif _G.SelectIsland == "Floating Turtle" then
            BTP(CFrame.new(-13274.528320313, 531.82073974609, -7579.22265625))
        elseif _G.SelectIsland == "Mansion" then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375))
        elseif _G.SelectIsland == "Haunted Castle" then
            BTP(CFrame.new(-9515.3720703125, 164.00624084473, 5786.0610351562))
        elseif _G.SelectIsland == "Ice Cream Island" then
            BTP(CFrame.new(-902.56817626953, 79.93204498291, -10988.84765625))
        elseif _G.SelectIsland == "Peanut Island" then
            BTP(CFrame.new(-2062.7475585938, 50.473892211914, -10232.568359375))
        elseif _G.SelectIsland == "Cake Island" then
            BTP(CFrame.new(-1884.7747802734375, 19.327526092529297, -11666.8974609375))
        elseif _G.SelectIsland == "Chocolate Island" then
            BTP(CFrame.new(129.568, 25.0775, -12100))
        elseif _G.SelectIsland == "Candy Island" then
            BTP(CFrame.new(-1025.39, 14.4503, -14154.5))
        end
    end,
})

-- [Raid]

local DungeonsTab = Window:MakeTab({
	Name = "Dungeons (Raid)",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local KillAura = DungeonsTab:AddToggle({
    Name = "Kill Aura",
    CurrentValue = false,
    Flag = "KillAura", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        _G.Killaura = Value
        print(Value)
    end,
})

spawn(function()
    while task.wait() do
        pcall(function()
            if _G.Killaura then
                for i,v in pairs(game.Workspace.Enemies:GetDescendants()) do
                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                        pcall(function()
                            repeat task.wait()
                                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                v.Humanoid.Health = 0
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(100,100,100)
                                v.HumanoidRootPart.Transparency = 1
                            until not _G.Killaura or not v.Parent or v.Humanoid.Health <= 0
                        end)
                    end
                end
            end
        end)
    end
end)

DungeonsTab:AddDropdown({
	Name = "Select Raid Chip",
	Default = "Flame",
	Options = {"Flame","Ice","Quake","Light","Dark","String","Rumble","Magma","Human: Buddha","Sand","Dough","Phoenix"},
	Callback = function(Value)
		_G.FruitChipSelect = Value
	end    
})

local StartRaid = DungeonsTab:AddButton({
    Name = "Buy Selected Chip",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("RaidsNpc","Select",_G.FruitChipSelect)
    end,
})

local BuyChipStart = DungeonsTab:AddToggle({
    Name = "Auto Start Raid (hold chip)",
    CurrentValue = false,
    Flag = "BuyChipStart", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(value)
        _G.Auto_StartRaid = value
    end,
})

spawn(function()
    while wait(.1) do
        pcall(function()
            if _G.Auto_StartRaid then
                if game:GetService("Players")["LocalPlayer"].PlayerGui.Main.Timer.Visible == false then
                    if not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") and game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Special Microchip") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Special Microchip") then
                        if NewWorld then
                            fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon2.Button.Main.ClickDetector)
                        elseif ThreeWorld then
                            fireclickdetector(game:GetService("Workspace").Map["Boat Castle"].RaidSummon2.Button.Main.ClickDetector)
                        end
                    end
                end
            end
        end)
    end
end)

-- [Shop]

local ShopTab = Window:MakeTab({
	Name = "Shop",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local DevilFruitsSection = ShopTab:AddSection({ Name = "Devil Fruits" })     

local BuyFruit= ShopTab:AddButton({Name = "Random Fruit", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin","Buy") end})
local BuyAutoFruit = ShopTab:AddToggle({Name = "Auto Random Fruit", CurrentValue = false, Flag = "BuyFruitAuto", Callback = function(value) _G.RandomFruit = value end})
spawn(function()
    while wait(.2) do
        if _G.RandomFruit then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin","Buy")
        end
    end
end)

local BuyItemSection = ShopTab:AddSection({ Name = "Melee V1" })

local BuyItem = ShopTab:AddButton({Name = "Buy Black Step", Callback = function() local args = { [1] = "BuyElectro" } game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args)) end})
local BuyItem = ShopTab:AddButton({Name = "Buy Electro", Callback = function() local args = { [1] = "BuyBlackLeg" } game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args)) end})
local BuyItem = ShopTab:AddButton({Name = "Buy Fishman Karate", Callback = function() local args = { [1] = "BuyFishmanKarate" } game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args)) end})
local BuyItem = ShopTab:AddButton({Name = "Buy Dragon Claw", Callback = function()     
local args = {
    [1] = "BlackbeardReward",
    [2] = "DragonClaw",
    [3] = "1"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
local args = {
    [1] = "BlackbeardReward",
    [2] = "DragonClaw",
    [3] = "2"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args)) end})
local BuyItem = ShopTab:AddButton({Name = "Buy Superhuman", Callback = function() local args = { [1] = "BuySuperhuman" } game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args)) end})

local BuyItemSection = ShopTab:AddSection({ Name = "Melee V2" })

local BuyItem = ShopTab:AddButton({Name = "Buy Death Step", Callback = function() local args = { [1] = "BuyDeathStep" } game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args)) end})
local BuyItem = ShopTab:AddButton({Name = "Buy Electric Claw", Callback = function() local args = { [1] = "BuyElectricClaw" } game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args)) end})
local BuyItem = ShopTab:AddButton({Name = "Buy Sharkman Karate", Callback = function() local args = { [1] = "BuySharkmanKarate" } game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args)) end})
local BuyItem = ShopTab:AddButton({Name = "Buy Dragon Talon", Callback = function()         
local args = {
    [1] = "BuyDragonTalon",
    [2] = true
    }
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
local args = {
    [1] = "BuyDragonTalon"
    }
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args)) end})
local BuyItem = ShopTab:AddButton({Name = "Buy Godhuman", Callback = function() local args = { [1] = "BuyGodhuman" } game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args)) end})

local BuyItemSection = ShopTab:AddSection({ Name = "Bones" })

local RedeemBone = ShopTab:AddButton({
    Name = "Redeem Bone (once)",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones","Check")
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones","Buy",1,1)
    end,
})

local AutoRedeemBone = ShopTab:AddToggle({
    Name = "Auto Redeem Bone",
    CurrentValue = false,
    Flag = "AutoRedeemBone", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(value)
        _G.AutoRedeemBone = value
    end,
  })

    spawn(function()
        while wait(0.2) do
            pcall(function()
                if _G.AutoRedeemBone then
                     	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones","Check")
                     	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones","Buy",1,1)
                     end
                end)
            end
        end)   

-- [Misc]

local MiscTab = Window:MakeTab({
	Name = "Misc",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

-- [Settings]

local SettingsTab = Window:MakeTab({
	Name = "Settings",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Library:Init()
