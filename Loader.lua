local CORRECT_KEY = "SukunaCookingStfu67"
local KEY_URL = "https://discord.gg/rqrbkccttC"

local TweenService = game:GetService("TweenService")
local MarketplaceService = game:GetService("MarketplaceService")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "SukunaHub_System"

local function GetGameName()
    local success, info = pcall(function()
        return MarketplaceService:GetProductInfo(game.PlaceId).Name
    end)
    return success and info or "Unknown Game"
end

local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")
local Title = Instance.new("TextLabel")
local KeyInput = Instance.new("TextBox")
local GetKeyBtn = Instance.new("TextButton")
local StatusLabel = Instance.new("TextLabel")

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -125)
MainFrame.Size = UDim2.new(0, 450, 0, 250)

UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame

UIStroke.Thickness = 3
UIStroke.Color = Color3.fromRGB(200, 0, 0)
UIStroke.Parent = MainFrame

Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 60)
Title.Font = Enum.Font.GothamBold
Title.Text = "SUKUNA HUB | AUTH"
Title.TextColor3 = Color3.fromRGB(255, 0, 0)
Title.TextSize = 25

KeyInput.Parent = MainFrame
KeyInput.BackgroundColor3 = Color3.fromRGB(10, 0, 0)
KeyInput.Position = UDim2.new(0.1, 0, 0.35, 0)
KeyInput.Size = UDim2.new(0.8, 0, 0, 50)
KeyInput.Font = Enum.Font.Gotham
KeyInput.PlaceholderText = "Enter Key..."
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.new(1, 1, 1)
KeyInput.TextSize = 16
Instance.new("UICorner", KeyInput).CornerRadius = UDim.new(0, 8)

StatusLabel.Parent = MainFrame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0.1, 0, 0.58, 0)
StatusLabel.Size = UDim2.new(0.8, 0, 0, 20)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "Waiting for key..."
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusLabel.TextSize = 14

GetKeyBtn.Parent = MainFrame
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
GetKeyBtn.Position = UDim2.new(0.1, 0, 0.75, 0)
GetKeyBtn.Size = UDim2.new(0.8, 0, 0, 45)
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.Text = "GET KEY (DISCORD)"
GetKeyBtn.TextColor3 = Color3.new(1, 1, 1)
GetKeyBtn.TextSize = 18
Instance.new("UICorner", GetKeyBtn).CornerRadius = UDim.new(0, 8)

local LoadingFrame = Instance.new("Frame")
LoadingFrame.Name = "LoadingFrame"
LoadingFrame.Parent = ScreenGui
LoadingFrame.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
LoadingFrame.Position = UDim2.new(0.5, -225, 0.5, -125)
LoadingFrame.Size = UDim2.new(0, 450, 0, 250)
LoadingFrame.Visible = false
Instance.new("UICorner", LoadingFrame).CornerRadius = UDim.new(0, 15)
Instance.new("UIStroke", LoadingFrame).Color = Color3.fromRGB(255, 0, 0)

local LoadingText = Instance.new("TextLabel")
LoadingText.Parent = LoadingFrame
LoadingText.Size = UDim2.new(1, 0, 0.4, 0)
LoadingText.Position = UDim2.new(0, 0, 0.2, 0)
LoadingText.Font = Enum.Font.GothamBold
LoadingText.Text = "Detecting Game..."
LoadingText.TextColor3 = Color3.new(1, 1, 1)
LoadingText.TextSize = 22
LoadingText.BackgroundTransparency = 1

local ProgressBarBackground = Instance.new("Frame")
ProgressBarBackground.Parent = LoadingFrame
ProgressBarBackground.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
ProgressBarBackground.Position = UDim2.new(0.1, 0, 0.6, 0)
ProgressBarBackground.Size = UDim2.new(0.8, 0, 0, 10)
Instance.new("UICorner", ProgressBarBackground)

local ProgressBar = Instance.new("Frame")
ProgressBar.Parent = ProgressBarBackground
ProgressBar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ProgressBar.Size = UDim2.new(0, 0, 1, 0)
Instance.new("UICorner", ProgressBar)

local function StartExecution()
    MainFrame.Visible = false
    LoadingFrame.Visible = true
    
    local gameName = GetGameName()
    local placeId = game.PlaceId
    
    task.wait(0.5)
    LoadingText.Text = "Detected Game: " .. gameName
    local tween = TweenService:Create(ProgressBar, TweenInfo.new(1.5), {Size = UDim2.new(1, 0, 1, 0)})
    tween:Play()
    task.wait(1.5)

    if placeId == 136801880565837 then
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/kingthekid074-hue/New-loader/refs/heads/main/flick.lua"))()
        end)
        if not success then warn("Failed to load script: " .. err) end
    else
        LoadingText.Text = "Game Not Supported!"
        task.wait(2)
    end

    LoadingText.Text = "Finished!"
    task.wait(1)
    ScreenGui:Destroy()
end

KeyInput:GetPropertyChangedSignal("Text"):Connect(function()
    if KeyInput.Text == CORRECT_KEY then
        StatusLabel.Text = "Key Verified!"
        StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
        KeyInput.TextEditable = false
        task.wait(0.5)
        StartExecution()
    elseif #KeyInput.Text > 0 and KeyInput.Text ~= CORRECT_KEY then
        StatusLabel.Text = "Checking..."
        task.delay(0.3, function()
            if KeyInput.Text ~= CORRECT_KEY and #KeyInput.Text > 0 then
                StatusLabel.Text = "Invalid Key!"
                StatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
            end
        end)
    end
end)

GetKeyBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(KEY_URL)
        GetKeyBtn.Text = "LINK COPIED!"
    else        
    end
    task.wait(2)
    GetKeyBtn.Text = "GET KEY (DISCORD)"
end)
