repeat task.wait() until game:IsLoaded()

---- // GUI // ----

-- Instances:

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Name = Instance.new("TextLabel")
local Username = Instance.new("TextLabel")
local JobID = Instance.new("TextLabel")
local Line = Instance.new("Frame")
local Koishi = Instance.new("ImageLabel")
local Mirage = Instance.new("TextLabel")
local FullMoon = Instance.new("TextLabel")

--Properties:

local blur = Instance.new('BlurEffect', game.Lighting)
blur.Size = 100

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(255, 240, 249)
Frame.Position = UDim2.new(0.5, -325, 0.5, -150)
Frame.Size = UDim2.new(0, 650, 0, 300)

UICorner.Parent = Frame

Name.Name = "Name"
Name.Parent = Frame
Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Name.BackgroundTransparency = 1.000
Name.BorderSizePixel = 0
Name.Position = UDim2.new(0.224999994, 0, 0.0500000007, 0)
Name.Size = UDim2.new(0, 145, 0, 35)
Name.Font = Enum.Font.ArialBold
Name.Text = "catn1qqer"
Name.TextColor3 = Color3.fromRGB(207, 132, 142)
Name.TextScaled = true
Name.TextSize = 19.000
Name.TextWrapped = true

Username.Name = "Username"
Username.Parent = Frame
Username.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Username.BackgroundTransparency = 1.000
Username.BorderSizePixel = 0
Username.Position = UDim2.new(0.0153846145, 0, 0.218333334, 0)
Username.Size = UDim2.new(0, 620, 0, 30)
Username.Font = Enum.Font.ArialBold
Username.Text = "Username : <username>"
Username.TextColor3 = Color3.fromRGB(207, 132, 142)
Username.TextScaled = true
Username.TextSize = 19.000
Username.TextWrapped = true
Username.TextXAlignment = Enum.TextXAlignment.Left

Line.Name = "Line"
Line.Parent = Frame
Line.BackgroundColor3 = Color3.fromRGB(235, 174, 255)
Line.BorderSizePixel = 0
Line.Position = UDim2.new(0, 10, 0.180000007, 0)
Line.Size = UDim2.new(0, 420, 0, 1)

Koishi.Name = "Koishi"
Koishi.Parent = Frame
Koishi.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Koishi.BackgroundTransparency = 1.000
Koishi.Position = UDim2.new(0.541538477, 0, -0.379999995, 0)
Koishi.Size = UDim2.new(0, 370, 0, 470)
Koishi.Image = "rbxassetid://10830943750"
Koishi.ScaleType = Enum.ScaleType.Fit

JobID.Name = "JobID" -- a button.
JobID.Parent = Frame
JobID.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
JobID.BackgroundTransparency = 1.000
JobID.BorderSizePixel = 0
JobID.Position = UDim2.new(0.0149999997, 0, 0.314999998, 0)
JobID.Size = UDim2.new(0, 589, 0, 15)
JobID.Font = Enum.Font.ArialBold
JobID.Text = "JobID : <jobid>"
JobID.TextColor3 = Color3.fromRGB(207, 132, 142)
JobID.TextScaled = true
JobID.TextSize = 14.000
JobID.TextWrapped = true
JobID.TextXAlignment = Enum.TextXAlignment.Left

---- // UI CODE // ----

JobID.Text = "JobID : ".. game.JobId
Username.Text = "Username : ".. game.Players.LocalPlayer.Name
