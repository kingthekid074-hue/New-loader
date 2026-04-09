local GoatKey = "Goathubrelesefirstgameever"
local KeyURL = "https://discord.gg/scJjpcVNZb"

local TweenService = game:GetService("TweenService")
local MarketplaceService = game:GetService("MarketplaceService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local TargetParent
local SuccessCore, CoreResult = pcall(function()
    return game:GetService("CoreGui")
end)

if SuccessCore and CoreResult then
    TargetParent = CoreResult
else
    TargetParent = Players.LocalPlayer:WaitForChild("PlayerGui")
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GoatHub_Ultimate_Auth"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = TargetParent

local function GetGameName()
    local Success, Info = pcall(function()
        return MarketplaceService:GetProductInfo(game.PlaceId).Name
    end)
    return Success and Info or "Unknown Environment"
end

local MainFrame = Instance.new("Frame")
MainFrame.Name = "GoatMain"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 420, 0, 260)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundTransparency = 1
MainFrame.ClipsDescendants = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 14)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(130, 60, 255)
UIStroke.Transparency = 1
UIStroke.Parent = MainFrame

local Glow = Instance.new("ImageLabel")
Glow.Parent = MainFrame
Glow.BackgroundTransparency = 1
Glow.Position = UDim2.new(0, -30, 0, -30)
Glow.Size = UDim2.new(1, 60, 1, 60)
Glow.Image = "rbxassetid://5028857084"
Glow.ImageColor3 = Color3.fromRGB(140, 82, 255)
Glow.ImageTransparency = 1
Glow.ZIndex = 0

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0.08, 0)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBlack
Title.Text = "GOAT HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 28
Title.TextTransparency = 1
Title.ZIndex = 2

local TitleGradient = Instance.new("UIGradient")
TitleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 80, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(230, 190, 255))
})
TitleGradient.Parent = Title

local SubTitle = Instance.new("TextLabel")
SubTitle.Parent = MainFrame
SubTitle.BackgroundTransparency = 1
SubTitle.Position = UDim2.new(0, 0, 0.25, 0)
SubTitle.Size = UDim2.new(1, 0, 0, 15)
SubTitle.Font = Enum.Font.GothamMedium
SubTitle.Text = "KEY SYSTEM"
SubTitle.TextColor3 = Color3.fromRGB(140, 140, 160)
SubTitle.TextSize = 10
SubTitle.TextTransparency = 1

local KeyInput = Instance.new("TextBox")
KeyInput.Parent = MainFrame
KeyInput.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
KeyInput.Position = UDim2.new(0.5, 0, 0.45, 0)
KeyInput.Size = UDim2.new(0.85, 0, 0, 48)
KeyInput.AnchorPoint = Vector2.new(0.5, 0.5)
KeyInput.Font = Enum.Font.GothamSemibold
KeyInput.PlaceholderText = "Enter Key..."
KeyInput.PlaceholderColor3 = Color3.fromRGB(100, 100, 120)
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.TextSize = 14
KeyInput.TextTransparency = 1
KeyInput.BackgroundTransparency = 1
Instance.new("UICorner", KeyInput).CornerRadius = UDim.new(0, 8)

local InputStroke = Instance.new("UIStroke", KeyInput)
InputStroke.Thickness = 1.5
InputStroke.Color = Color3.fromRGB(60, 60, 80)
InputStroke.Transparency = 1

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Parent = MainFrame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0.5, 0, 0.62, 0)
StatusLabel.Size = UDim2.new(0.85, 0, 0, 20)
StatusLabel.AnchorPoint = Vector2.new(0.5, 0.5)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "Awaiting verification..."
StatusLabel.TextColor3 = Color3.fromRGB(120, 120, 140)
StatusLabel.TextSize = 12
StatusLabel.TextTransparency = 1

local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Parent = MainFrame
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(130, 60, 255)
GetKeyBtn.Position = UDim2.new(0.5, 0, 0.8, 0)
GetKeyBtn.Size = UDim2.new(0.85, 0, 0, 45)
GetKeyBtn.AnchorPoint = Vector2.new(0.5, 0.5)
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.Text = "GET KEY"
GetKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GetKeyBtn.TextSize = 15
GetKeyBtn.AutoButtonColor = false
GetKeyBtn.BackgroundTransparency = 1
GetKeyBtn.TextTransparency = 1
Instance.new("UICorner", GetKeyBtn).CornerRadius = UDim.new(0, 8)

local LoadingFrame = Instance.new("Frame")
LoadingFrame.Name = "GoatLoading"
LoadingFrame.Parent = ScreenGui
LoadingFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
LoadingFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
LoadingFrame.Size = UDim2.new(0, 420, 0, 260)
LoadingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
LoadingFrame.BackgroundTransparency = 1
LoadingFrame.Visible = false
Instance.new("UICorner", LoadingFrame).CornerRadius = UDim.new(0, 14)

local LoadStroke = Instance.new("UIStroke", LoadingFrame)
LoadStroke.Color = Color3.fromRGB(130, 60, 255)
LoadStroke.Thickness = 2
LoadStroke.Transparency = 1

local LoadingText = Instance.new("TextLabel")
LoadingText.Parent = LoadingFrame
LoadingText.Size = UDim2.new(1, 0, 0.4, 0)
LoadingText.Position = UDim2.new(0, 0, 0.25, 0)
LoadingText.Font = Enum.Font.GothamBold
LoadingText.Text = "Verifying..."
LoadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadingText.TextSize = 20
LoadingText.BackgroundTransparency = 1
LoadingText.TextTransparency = 1

local ProgressBarBackground = Instance.new("Frame")
ProgressBarBackground.Parent = LoadingFrame
ProgressBarBackground.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
ProgressBarBackground.Position = UDim2.new(0.1, 0, 0.65, 0)
ProgressBarBackground.Size = UDim2.new(0.8, 0, 0, 8)
ProgressBarBackground.BackgroundTransparency = 1
Instance.new("UICorner", ProgressBarBackground).CornerRadius = UDim.new(1, 0)

local ProgressBar = Instance.new("Frame")
ProgressBar.Parent = ProgressBarBackground
ProgressBar.BackgroundColor3 = Color3.fromRGB(130, 60, 255)
ProgressBar.Size = UDim2.new(0, 0, 1, 0)
ProgressBar.BackgroundTransparency = 1
Instance.new("UICorner", ProgressBar).CornerRadius = UDim.new(1, 0)

local Dragging, DragInput, DragStart, StartPos
local function UpdateDrag(Input)
    local Delta = Input.Position - DragStart
    TweenService:Create(MainFrame, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + Delta.X, StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y)}):Play()
end

MainFrame.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
        Dragging = true
        DragStart = Input.Position
        StartPos = MainFrame.Position
        Input.Changed:Connect(function()
            if Input.UserInputState == Enum.UserInputState.End then
                Dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
        DragInput = Input
    end
end)

UserInputService.InputChanged:Connect(function(Input)
    if Input == DragInput and Dragging then
        UpdateDrag(Input)
    end
end)

local function HoverEffect(Obj, Color, SizeObj, Scale)
    pcall(function()
        TweenService:Create(Obj, TweenInfo.new(0.3, Enum.EasingStyle.Cubic), {BackgroundColor3 = Color}):Play()
        if SizeObj and Scale then
            TweenService:Create(SizeObj, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Size = Scale}):Play()
        end
    end)
end

GetKeyBtn.MouseEnter:Connect(function() HoverEffect(GetKeyBtn, Color3.fromRGB(150, 80, 255), GetKeyBtn, UDim2.new(0.88, 0, 0, 48)) end)
GetKeyBtn.MouseLeave:Connect(function() HoverEffect(GetKeyBtn, Color3.fromRGB(130, 60, 255), GetKeyBtn, UDim2.new(0.85, 0, 0, 45)) end)

local function PulseGlow()
    task.spawn(function()
        while MainFrame.Visible do
            pcall(function()
                TweenService:Create(UIStroke, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Color = Color3.fromRGB(180, 100, 255)}):Play()
                task.wait(1.5)
                TweenService:Create(UIStroke, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Color = Color3.fromRGB(130, 60, 255)}):Play()
                task.wait(1.5)
            end)
        end
    end)
end

local function PlayIntro()
    local EInfo = TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
    TweenService:Create(MainFrame, EInfo, {BackgroundTransparency = 0.1}):Play()
    TweenService:Create(UIStroke, EInfo, {Transparency = 0}):Play()
    TweenService:Create(Glow, EInfo, {ImageTransparency = 0.6}):Play()
    TweenService:Create(Title, EInfo, {TextTransparency = 0}):Play()
    TweenService:Create(SubTitle, EInfo, {TextTransparency = 0}):Play()
    TweenService:Create(KeyInput, EInfo, {TextTransparency = 0, BackgroundTransparency = 0}):Play()
    TweenService:Create(InputStroke, EInfo, {Transparency = 0}):Play()
    TweenService:Create(StatusLabel, EInfo, {TextTransparency = 0}):Play()
    TweenService:Create(GetKeyBtn, EInfo, {TextTransparency = 0, BackgroundTransparency = 0}):Play()
    PulseGlow()
end

local function StartExecution()
    local Outro = TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
    TweenService:Create(MainFrame, Outro, {BackgroundTransparency = 1}):Play()
    TweenService:Create(UIStroke, Outro, {Transparency = 1}):Play()
    TweenService:Create(Glow, Outro, {ImageTransparency = 1}):Play()
    TweenService:Create(Title, Outro, {TextTransparency = 1}):Play()
    TweenService:Create(SubTitle, Outro, {TextTransparency = 1}):Play()
    TweenService:Create(KeyInput, Outro, {TextTransparency = 1, BackgroundTransparency = 1}):Play()
    TweenService:Create(InputStroke, Outro, {Transparency = 1}):Play()
    TweenService:Create(StatusLabel, Outro, {TextTransparency = 1}):Play()
    TweenService:Create(GetKeyBtn, Outro, {TextTransparency = 1, BackgroundTransparency = 1}):Play()
    
    task.wait(0.5)
    MainFrame.Visible = false
    LoadingFrame.Visible = true
    
    TweenService:Create(LoadingFrame, Outro, {BackgroundTransparency = 0.1}):Play()
    TweenService:Create(LoadStroke, Outro, {Transparency = 0}):Play()
    TweenService:Create(LoadingText, Outro, {TextTransparency = 0}):Play()
    TweenService:Create(ProgressBarBackground, Outro, {BackgroundTransparency = 0}):Play()
    TweenService:Create(ProgressBar, Outro, {BackgroundTransparency = 0}):Play()
    
    local TargetPlace = game.PlaceId
    local EnvName = GetGameName()
    
    task.wait(0.5)
    LoadingText.Text = "Verifying..."
    TweenService:Create(ProgressBar, TweenInfo.new(1), {Size = UDim2.new(0.4, 0, 1, 0)}):Play()
    task.wait(1.2)
    
    LoadingText.Text = "Game: " .. EnvName
    TweenService:Create(ProgressBar, TweenInfo.new(1.5), {Size = UDim2.new(1, 0, 1, 0)}):Play()
    task.wait(1.6)

    if TargetPlace == 124473577469410 then
        local ExecSuccess, ExecError = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/kingthekid074-hue/New-loader/refs/heads/main/bealuckyblock.lua"))()
        end)
        
        if ExecSuccess then
            LoadingText.Text = "execute Successful!"
            LoadingText.TextColor3 = Color3.fromRGB(100, 255, 100)
        else
            LoadingText.Text = "execute Failure"
            LoadingText.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
        task.wait(1.5)
    else
        LoadingText.Text = "Game Not Supported"
        LoadingText.TextColor3 = Color3.fromRGB(255, 100, 100)
        task.wait(2)
    end
    
    local FinalOutro = TweenService:Create(LoadingFrame, Outro, {BackgroundTransparency = 1})
    TweenService:Create(LoadStroke, Outro, {Transparency = 1}):Play()
    TweenService:Create(LoadingText, Outro, {TextTransparency = 1}):Play()
    TweenService:Create(ProgressBarBackground, Outro, {BackgroundTransparency = 1}):Play()
    TweenService:Create(ProgressBar, Outro, {BackgroundTransparency = 1}):Play()
    
    FinalOutro:Play()
    FinalOutro.Completed:Connect(function() ScreenGui:Destroy() end)
end

KeyInput:GetPropertyChangedSignal("Text"):Connect(function()
    local InputText = KeyInput.Text
    if InputText == GoatKey then
        StatusLabel.Text = "Key Verified!"
        StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        KeyInput.TextEditable = false
        TweenService:Create(InputStroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(100, 255, 100)}):Play()
        task.wait(0.4)
        StartExecution()
    elseif #InputText > 0 and InputText ~= GoatKey then
        StatusLabel.Text = "Validating..."
        StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        TweenService:Create(InputStroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(80, 80, 100)}):Play()
        task.delay(0.4, function()
            if KeyInput.Text ~= GoatKey and #KeyInput.Text > 0 then
                StatusLabel.Text = "Invalid Authorization Key"
                StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
                TweenService:Create(InputStroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(255, 100, 100)}):Play()
            end
        end)
    else
        StatusLabel.Text = "Awaiting verification..."
        StatusLabel.TextColor3 = Color3.fromRGB(120, 120, 140)
        TweenService:Create(InputStroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(60, 60, 80)}):Play()
    end
end)

GetKeyBtn.MouseButton1Click:Connect(function()
    local ClipSuccess = pcall(function()
        if setclipboard then setclipboard(KeyURL) end
    end)
    
    if ClipSuccess then
        GetKeyBtn.Text = "URL COPIED"
        TweenService:Create(GetKeyBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(100, 200, 100)}):Play()
    end
    
    task.wait(1.5)
    GetKeyBtn.Text = "GET KEY"
    TweenService:Create(GetKeyBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(130, 60, 255)}):Play()
end)

PlayIntro()
