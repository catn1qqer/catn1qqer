for i,v in next, game.Players.LocalPlayer.PlayerGui:GetChildren() do -- Deletes the current Blox Fruits UI
    if v:IsA'ScreenGui' then
    v:Destroy()
    end
end

-- Instances:

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Username = Instance.new("TextLabel")
local JobId = Instance.new("TextLabel")
local credits = Instance.new("TextLabel")
local Tip = Instance.new("TextLabel")
local cat = Instance.new("ImageLabel")

--Properties:

local blur = Instance.new('BlurEffect', game.Lighting)
blur.Size = 100

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
Frame.Position = UDim2.new(0.5, -400, 0.5, -200)
Frame.Size = UDim2.new(0, 800, 0, 400)

UICorner.Parent = Frame

Username.Name = "Username"
Username.Parent = Frame
Username.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Username.BackgroundTransparency = 1.000
Username.BorderSizePixel = 0
Username.Position = UDim2.new(0.0217857361, 0, 0.022499999, 0)
Username.Size = UDim2.new(0, 571, 0, 50)
Username.Font = Enum.Font.Gotham
Username.Text = "Welcome, <username>"
Username.TextColor3 = Color3.fromRGB(255, 255, 255)
Username.TextSize = 39.000
Username.TextWrapped = true
Username.TextXAlignment = Enum.TextXAlignment.Left

JobId.Name = "JobId"
JobId.Parent = Frame
JobId.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
JobId.BackgroundTransparency = 1.000
JobId.BorderSizePixel = 0
JobId.Position = UDim2.new(0.0217857361, 0, 0.125, 0)
JobId.Size = UDim2.new(0, 758, 0, 18)
JobId.Font = Enum.Font.Gotham
JobId.Text = "JobId : <jobid>"
JobId.TextColor3 = Color3.fromRGB(255, 255, 255)
JobId.TextSize = 14.000
JobId.TextWrapped = true
JobId.TextXAlignment = Enum.TextXAlignment.Left

credits.Name = "credits"
credits.Parent = Frame
credits.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
credits.BackgroundTransparency = 1.000
credits.BorderSizePixel = 0
credits.Position = UDim2.new(0.901785791, 0, 0.914999962, 0)
credits.Size = UDim2.new(0, 66, 0, 26)
credits.Font = Enum.Font.Gotham
credits.Text = "catn1qqer"
credits.TextColor3 = Color3.fromRGB(255, 255, 255)
credits.TextSize = 14.000
credits.TextTransparency = 0.360
credits.TextWrapped = true
credits.TextXAlignment = Enum.TextXAlignment.Right

Tip.Name = "Tip"
Tip.Parent = Frame
Tip.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Tip.BackgroundTransparency = 1.000
Tip.BorderSizePixel = 0
Tip.Position = UDim2.new(0.159285739, 0, 0.4375, 0)
Tip.Size = UDim2.new(0, 571, 0, 50)
Tip.Font = Enum.Font.Gotham
Tip.Text = "tat ca la tai cong san"
Tip.TextColor3 = Color3.fromRGB(255, 255, 255)
Tip.TextSize = 39.000
Tip.TextWrapped = true

cat.Name = "cat!!"
cat.Parent = Frame
cat.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
cat.BackgroundTransparency = 1.000
cat.Position = UDim2.new(0.0212499946, 0, 0.730000019, 0)
cat.Size = UDim2.new(0, 100, 0, 100)
cat.Image = "rbxassetid://12711711186"

-- // Code \\ --

JobId.Text = "JobId : ".. game.JobId
Username.Text = "Username : ".. game.Players.LocalPlayer.Name
