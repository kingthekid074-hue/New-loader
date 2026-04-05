local KEY_URL = "https://discord.gg/rqrbkccttC"
local DatabaseURL = "https://raw.githubusercontent.com/kingthekid074-hue/New-loader/refs/heads/main/keys.json"

local TweenService = game:GetService("TweenService")
local MarketplaceService = game:GetService("MarketplaceService")
local HttpService = game:GetService("HttpService")

local HardwareID = gethwid and gethwid() or game:GetService("RbxAnalyticsService"):GetClientId()

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "SukunaHub_System"

local ValidKeys = {}

local Success, Response = pcall(function()
    return game:HttpGet(DatabaseURL)
end)

if Success then
    local DecodeSuccess, DecodedData = pcall(function()
        return HttpService:JSONDecode(Response)
    end)
    if DecodeSuccess then
        ValidKeys = DecodedData
    end
end

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
local CopyHwidBtn = Instance.new("TextButton")
local StatusLabel = Instance.new("TextLabel")

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -135)
MainFrame.Size = UDim2.new(0, 450, 0, 270)

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
KeyInput.Position = UDim2.new(0.1, 0, 0.28, 0)
KeyInput.Size = UDim2.new(0.8, 0, 0, 50)
KeyInput.Font = Enum.Font.Gotham
KeyInput.PlaceholderText = "Enter Key..."
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.new(1, 1, 1)
KeyInput.TextSize = 16
local InputCorner = Instance.new("UICorner", KeyInput)
InputCorner.CornerRadius = UDim.new(0, 8)

StatusLabel.Parent = MainFrame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0.1, 0, 0.52, 0)
StatusLabel.Size = UDim2.new(0.8, 0, 0, 20)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "Waiting for key..."
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusLabel.TextSize = 14

GetKeyBtn.Parent = MainFrame
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
GetKeyBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
GetKeyBtn.Size = UDim2.new(0.38, 0, 0, 45)
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.Text = "DISCORD"
GetKeyBtn.TextColor3 = Color3.new(1, 1, 1)
GetKeyBtn.TextSize = 16
local BtnCorner = Instance.new("UICorner", GetKeyBtn)
BtnCorner.CornerRadius = UDim.new(0, 8)

CopyHwidBtn.Parent = MainFrame
CopyHwidBtn.BackgroundColor3 = Color3.fromRGB(0, 80, 120)
CopyHwidBtn.Position = UDim2.new(0.52, 0, 0.65, 0)
CopyHwidBtn.Size = UDim2.new(0.38, 0, 0, 45)
CopyHwidBtn.Font = Enum.Font.GothamBold
CopyHwidBtn.Text = "COPY HWID"
CopyHwidBtn.TextColor3 = Color3.new(1, 1, 1)
CopyHwidBtn.TextSize = 16
local BtnCorner2 = Instance.new("UICorner", CopyHwidBtn)
BtnCorner2.CornerRadius = UDim.new(0, 8)

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
        local loadSuccess, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/kingthekid074-hue/New-loader/refs/heads/main/flick.lua"))()
        end)
        if not loadSuccess then warn("Failed to load script: " .. err) end
        LoadingText.Text = "Finished!"
        task.wait(1)
    elseif placeId == 70845479499574 then
        local loadSuccess, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/kingthekid074-hue/New-loader/refs/heads/main/bitebynight.lua"))()
        end)
        if not loadSuccess then warn("Failed to load script: " .. err) end
        LoadingText.Text = "Finished!"
        task.wait(1)
    else
        LoadingText.Text = "Game Not Supported!"
        task.wait(2)
    end
    ScreenGui:Destroy()
end

KeyInput:GetPropertyChangedSignal("Text"):Connect(function()
    local InputText = KeyInput.Text
    if ValidKeys[InputText] then
        if ValidKeys[InputText] == HardwareID then
            StatusLabel.Text = "Key Verified!"
            StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
            KeyInput.TextEditable = false
            task.wait(0.5)
            StartExecution()
        else
            StatusLabel.Text = "valid Key"
            StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 0)
        end
    elseif string.len(InputText) > 0 then
        StatusLabel.Text = "Checking..."
        task.delay(0.3, function()
            if not ValidKeys[KeyInput.Text] and string.len(KeyInput.Text) > 0 then
                StatusLabel.Text = "Invalid Key!"
                StatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
            end
        end)
    end
end)

GetKeyBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(KEY_URL)
        GetKeyBtn.Text = "COPIED!"
    end
    task.wait(2)
    GetKeyBtn.Text = "Get Key"
end)

CopyHwidBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(HardwareID)
        CopyHwidBtn.Text = "HWID COPIED!"
    end
    task.wait(2)
    CopyHwidBtn.Text = "COPY HWID(you will need it)"
end)
