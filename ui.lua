local MoonHub = {}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

-- Config System
local ConfigSystem = {
    Folder = "MoonHub",
    CurrentConfig = "default",
    Configs = {},
    AutoLoad = false,
    AutoSave = true
}

-- Utility Functions
local function MakeDraggable(frame, dragFrame)
    local dragging, dragInput, dragStart, startPos
    
    dragFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    dragFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

local function Tween(object, properties, duration, style, direction)
    style = style or Enum.EasingStyle.Quad
    direction = direction or Enum.EasingDirection.Out
    local tween = TweenService:Create(object, TweenInfo.new(duration, style, direction), properties)
    tween:Play()
    return tween
end

local function Ripple(button)
    spawn(function()
        local ripple = Instance.new("ImageLabel")
        ripple.Name = "Ripple"
        ripple.Parent = button
        ripple.BackgroundTransparency = 1
        ripple.BorderSizePixel = 0
        ripple.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
        ripple.ImageColor3 = Color3.fromRGB(255, 255, 255)
        ripple.ImageTransparency = 0.5
        ripple.ScaleType = Enum.ScaleType.Fit
        ripple.ZIndex = button.ZIndex + 1
        ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
        ripple.Size = UDim2.new(0, 0, 0, 0)
        ripple.AnchorPoint = Vector2.new(0.5, 0.5)
        
        Tween(ripple, {Size = UDim2.new(2, 0, 2, 0), ImageTransparency = 1}, 0.5)
        wait(0.5)
        ripple:Destroy()
    end)
end

-- Config Functions
function ConfigSystem:GetConfigPath()
    return self.Folder .. "/" .. self.CurrentConfig .. ".json"
end

function ConfigSystem:SaveConfig(configName)
    configName = configName or self.CurrentConfig
    local configData = {}
    
    for key, value in pairs(self.Configs) do
        configData[key] = value
    end
    
    local success, result = pcall(function()
        writefile(self.Folder .. "/" .. configName .. ".json", HttpService:JSONEncode(configData))
    end)
    
    if success then
        return true, "Config saved successfully!"
    else
        return false, "Failed to save config: " .. tostring(result)
    end
end

function ConfigSystem:LoadConfig(configName)
    configName = configName or self.CurrentConfig
    
    local success, result = pcall(function()
        return readfile(self.Folder .. "/" .. configName .. ".json")
    end)
    
    if success then
        local configData = HttpService:JSONDecode(result)
        for key, value in pairs(configData) do
            self.Configs[key] = value
            if self.Callbacks[key] then
                self.Callbacks[key](value)
            end
        end
        return true, "Config loaded successfully!"
    else
        return false, "Failed to load config: " .. tostring(result)
    end
end

function ConfigSystem:DeleteConfig(configName)
    local success, result = pcall(function()
        delfile(self.Folder .. "/" .. configName .. ".json")
    end)
    
    return success, success and "Config deleted!" or "Failed to delete config"
end

function ConfigSystem:ListConfigs()
    local success, result = pcall(function()
        return listfiles(self.Folder)
    end)
    
    if success then
        local configs = {}
        for _, file in ipairs(result) do
            local name = file:match("([^/]+)%.json$")
            if name then
                table.insert(configs, name)
            end
        end
        return configs
    else
        return {}
    end
end

function ConfigSystem:Init()
    if not isfolder(self.Folder) then
        makefolder(self.Folder)
    end
    
    self.Callbacks = {}
    
    if self.AutoLoad then
        self:LoadConfig("autoload")
    end
end

ConfigSystem:Init()

-- Main Window Creation
function MoonHub:CreateWindow(config)
    config = config or {}
    local WindowName = config.Name or "Moon Hub"
    local Theme = config.Theme or {
        Background = Color3.fromRGB(20, 20, 25),
        Topbar = Color3.fromRGB(25, 25, 30),
        Tab = Color3.fromRGB(30, 30, 35),
        Element = Color3.fromRGB(35, 35, 40),
        Accent = Color3.fromRGB(138, 43, 226),
        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(180, 180, 180)
    }
    
    local Window = {
        Tabs = {},
        Theme = Theme,
        Notifications = {}
    }
    
    -- Create ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "MoonHub"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    if syn then
        syn.protect_gui(ScreenGui)
        ScreenGui.Parent = CoreGui
    else
        ScreenGui.Parent = gethui and gethui() or CoreGui
    end
    
    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Theme.Background
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.5, -400, 0.5, -300)
    MainFrame.Size = UDim2.new(0, 800, 0, 600)
    MainFrame.ClipsDescendants = true
    
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 10)
    MainCorner.Parent = MainFrame
    
    -- Topbar
    local Topbar = Instance.new("Frame")
    Topbar.Name = "Topbar"
    Topbar.Parent = MainFrame
    Topbar.BackgroundColor3 = Theme.Topbar
    Topbar.BorderSizePixel = 0
    Topbar.Size = UDim2.new(1, 0, 0, 50)
    
    local TopbarCorner = Instance.new("UICorner")
    TopbarCorner.CornerRadius = UDim.new(0, 10)
    TopbarCorner.Parent = Topbar
    
    local TopbarCover = Instance.new("Frame")
    TopbarCover.Parent = Topbar
    TopbarCover.BackgroundColor3 = Theme.Topbar
    TopbarCover.BorderSizePixel = 0
    TopbarCover.Position = UDim2.new(0, 0, 1, -10)
    TopbarCover.Size = UDim2.new(1, 0, 0, 10)
    
    -- Title
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Parent = Topbar
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.Size = UDim2.new(0, 200, 1, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Text = WindowName
    Title.TextColor3 = Theme.Text
    Title.TextSize = 18
    Title.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Close Button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = Topbar
    CloseButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
    CloseButton.BorderSizePixel = 0
    CloseButton.Position = UDim2.new(1, -40, 0.5, -10)
    CloseButton.Size = UDim2.new(0, 20, 0, 20)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 18
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 5)
    CloseCorner.Parent = CloseButton
    
    CloseButton.MouseButton1Click:Connect(function()
        Ripple(CloseButton)
        Tween(MainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3)
        wait(0.3)
        ScreenGui:Destroy()
    end)
    
    -- Minimize Button
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Parent = Topbar
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(200, 200, 50)
    MinimizeButton.BorderSizePixel = 0
    MinimizeButton.Position = UDim2.new(1, -70, 0.5, -10)
    MinimizeButton.Size = UDim2.new(0, 20, 0, 20)
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.Text = "-"
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeButton.TextSize = 18
    
    local MinimizeCorner = Instance.new("UICorner")
    MinimizeCorner.CornerRadius = UDim.new(0, 5)
    MinimizeCorner.Parent = MinimizeButton
    
    local Minimized = false
    MinimizeButton.MouseButton1Click:Connect(function()
        Ripple(MinimizeButton)
        Minimized = not Minimized
        Tween(MainFrame, {Size = Minimized and UDim2.new(0, 800, 0, 50) or UDim2.new(0, 800, 0, 600)}, 0.3)
    end)
    
    -- Tab Container
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = MainFrame
    TabContainer.BackgroundColor3 = Theme.Tab
    TabContainer.BorderSizePixel = 0
    TabContainer.Position = UDim2.new(0, 10, 0, 60)
    TabContainer.Size = UDim2.new(0, 180, 1, -70)
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 8)
    TabCorner.Parent = TabContainer
    
    local TabList = Instance.new("UIListLayout")
    TabList.Parent = TabContainer
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 5)
    
    local TabPadding = Instance.new("UIPadding")
    TabPadding.Parent = TabContainer
    TabPadding.PaddingTop = UDim.new(0, 10)
    TabPadding.PaddingLeft = UDim.new(0, 10)
    TabPadding.PaddingRight = UDim.new(0, 10)
    TabPadding.PaddingBottom = UDim.new(0, 10)
    
    -- Content Container
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Parent = MainFrame
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Position = UDim2.new(0, 200, 0, 60)
    ContentContainer.Size = UDim2.new(1, -210, 1, -70)
    
    -- Search Bar
    local SearchBar = Instance.new("TextBox")
    SearchBar.Name = "SearchBar"
    SearchBar.Parent = Topbar
    SearchBar.BackgroundColor3 = Theme.Element
    SearchBar.BorderSizePixel = 0
    SearchBar.Position = UDim2.new(0, 220, 0.5, -12)
    SearchBar.Size = UDim2.new(0, 200, 0, 24)
    SearchBar.Font = Enum.Font.Gotham
    SearchBar.PlaceholderText = "Search features..."
    SearchBar.Text = ""
    SearchBar.TextColor3 = Theme.Text
    SearchBar.TextSize = 12
    SearchBar.ClearTextOnFocus = false
    
    local SearchCorner = Instance.new("UICorner")
    SearchCorner.CornerRadius = UDim.new(0, 6)
    SearchCorner.Parent = SearchBar
    
    local SearchPadding = Instance.new("UIPadding")
    SearchPadding.Parent = SearchBar
    SearchPadding.PaddingLeft = UDim.new(0, 10)
    
    MakeDraggable(MainFrame, Topbar)
    
    -- Notification System
    function Window:Notify(config)
        config = config or {}
        local Title = config.Title or "Notification"
        local Content = config.Content or "No content provided"
        local Duration = config.Duration or 3
        local Type = config.Type or "Info" -- Info, Success, Warning, Error
        
        local NotifColors = {
            Info = Color3.fromRGB(100, 150, 255),
            Success = Color3.fromRGB(100, 255, 150),
            Warning = Color3.fromRGB(255, 200, 100),
            Error = Color3.fromRGB(255, 100, 100)
        }
        
        local Notification = Instance.new("Frame")
        Notification.Name = "Notification"
        Notification.Parent = ScreenGui
        Notification.BackgroundColor3 = Theme.Element
        Notification.BorderSizePixel = 0
        Notification.Position = UDim2.new(1, -320, 1, 20)
        Notification.Size = UDim2.new(0, 300, 0, 80)
        
        local NotifCorner = Instance.new("UICorner")
        NotifCorner.CornerRadius = UDim.new(0, 8)
        NotifCorner.Parent = Notification
        
        local NotifAccent = Instance.new("Frame")
        NotifAccent.Name = "Accent"
        NotifAccent.Parent = Notification
        NotifAccent.BackgroundColor3 = NotifColors[Type]
        NotifAccent.BorderSizePixel = 0
        NotifAccent.Size = UDim2.new(0, 5, 1, 0)
        
        local AccentCorner = Instance.new("UICorner")
        AccentCorner.CornerRadius = UDim.new(0, 8)
        AccentCorner.Parent = NotifAccent
        
        local NotifTitle = Instance.new("TextLabel")
        NotifTitle.Name = "Title"
        NotifTitle.Parent = Notification
        NotifTitle.BackgroundTransparency = 1
        NotifTitle.Position = UDim2.new(0, 15, 0, 10)
        NotifTitle.Size = UDim2.new(1, -30, 0, 20)
        NotifTitle.Font = Enum.Font.GothamBold
        NotifTitle.Text = Title
        NotifTitle.TextColor3 = Theme.Text
        NotifTitle.TextSize = 14
        NotifTitle.TextXAlignment = Enum.TextXAlignment.Left
        
        local NotifContent = Instance.new("TextLabel")
        NotifContent.Name = "Content"
        NotifContent.Parent = Notification
        NotifContent.BackgroundTransparency = 1
        NotifContent.Position = UDim2.new(0, 15, 0, 35)
        NotifContent.Size = UDim2.new(1, -30, 1, -45)
        NotifContent.Font = Enum.Font.Gotham
        NotifContent.Text = Content
        NotifContent.TextColor3 = Theme.SubText
        NotifContent.TextSize = 12
        NotifContent.TextWrapped = true
        NotifContent.TextXAlignment = Enum.TextXAlignment.Left
        NotifContent.TextYAlignment = Enum.TextYAlignment.Top
        
        Tween(Notification, {Position = UDim2.new(1, -320, 1, -100)}, 0.5)
        
        wait(Duration)
        
        Tween(Notification, {Position = UDim2.new(1, -320, 1, 20)}, 0.5)
        wait(0.5)
        Notification:Destroy()
    end
    
    -- Tab Creation
    function Window:CreateTab(config)
        config = config or {}
        local TabName = config.Name or "Tab"
        local Icon = config.Icon or "📁"
        
        local Tab = {
            Sections = {},
            Elements = {}
        }
        
        -- Tab Button
        local TabButton = Instance.new("TextButton")
        TabButton.Name = TabName
        TabButton.Parent = TabContainer
        TabButton.BackgroundColor3 = Theme.Element
        TabButton.BorderSizePixel = 0
        TabButton.Size = UDim2.new(1, -10, 0, 35)
        TabButton.Font = Enum.Font.GothamSemibold
        TabButton.Text = Icon .. " " .. TabName
        TabButton.TextColor3 = Theme.SubText
        TabButton.TextSize = 13
        TabButton.TextXAlignment = Enum.TextXAlignment.Left
        
        local ButtonCorner = Instance.new("UICorner")
        ButtonCorner.CornerRadius = UDim.new(0, 6)
        ButtonCorner.Parent = TabButton
        
        local ButtonPadding = Instance.new("UIPadding")
        ButtonPadding.Parent = TabButton
        ButtonPadding.PaddingLeft = UDim.new(0, 12)
        
        -- Tab Content
        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Name = TabName
        TabContent.Parent = ContentContainer
        TabContent.Active = true
        TabContent.BackgroundTransparency = 1
        TabContent.BorderSizePixel = 0
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.ScrollBarThickness = 4
        TabContent.ScrollBarImageColor3 = Theme.Accent
        TabContent.Visible = false
        TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        
        local ContentList = Instance.new("UIListLayout")
        ContentList.Parent = TabContent
        ContentList.SortOrder = Enum.SortOrder.LayoutOrder
        ContentList.Padding = UDim.new(0, 10)
        
        ContentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentList.AbsoluteContentSize.Y + 10)
        end)
        
        TabButton.MouseButton1Click:Connect(function()
            Ripple(TabButton)
            for _, tab in pairs(Window.Tabs) do
                tab.Content.Visible = false
                tab.Button.BackgroundColor3 = Theme.Element
                tab.Button.TextColor3 = Theme.SubText
            end
            
            TabContent.Visible = true
            TabButton.BackgroundColor3 = Theme.Accent
            TabButton.TextColor3 = Theme.Text
        end)
        
        -- Make first tab active
        if #Window.Tabs == 0 then
            TabContent.Visible = true
            TabButton.BackgroundColor3 = Theme.Accent
            TabButton.TextColor3 = Theme.Text
        end
        
        Tab.Button = TabButton
        Tab.Content = TabContent
        
        -- Section Creation
        function Tab:CreateSection(name)
            local Section = Instance.new("Frame")
            Section.Name = name
            Section.Parent = TabContent
            Section.BackgroundColor3 = Theme.Element
            Section.BorderSizePixel = 0
            Section.Size = UDim2.new(1, -10, 0, 35)
            Section.AutomaticSize = Enum.AutomaticSize.Y
            
            local SectionCorner = Instance.new("UICorner")
            SectionCorner.CornerRadius = UDim.new(0, 8)
            SectionCorner.Parent = Section
            
            local SectionTitle = Instance.new("TextLabel")
            SectionTitle.Name = "Title"
            SectionTitle.Parent = Section
            SectionTitle.BackgroundTransparency = 1
            SectionTitle.Position = UDim2.new(0, 15, 0, 0)
            SectionTitle.Size = UDim2.new(1, -30, 0, 35)
            SectionTitle.Font = Enum.Font.GothamBold
            SectionTitle.Text = name
            SectionTitle.TextColor3 = Theme.Text
            SectionTitle.TextSize = 14
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            local SectionContainer = Instance.new("Frame")
            SectionContainer.Name = "Container"
            SectionContainer.Parent = Section
            SectionContainer.BackgroundTransparency = 1
            SectionContainer.Position = UDim2.new(0, 10, 0, 40)
            SectionContainer.Size = UDim2.new(1, -20, 1, -45)
            SectionContainer.AutomaticSize = Enum.AutomaticSize.Y
            
            local SectionList = Instance.new("UIListLayout")
            SectionList.Parent = SectionContainer
            SectionList.SortOrder = Enum.SortOrder.LayoutOrder
            SectionList.Padding = UDim.new(0, 8)
            
            local SectionObj = {
                Container = SectionContainer,
                Elements = {}
            }
            
            -- Toggle Element
            function SectionObj:AddToggle(config)
                config = config or {}
                local Name = config.Name or "Toggle"
                local Default = config.Default or false
                local Callback = config.Callback or function() end
                local Flag = config.Flag or Name
                
                local ToggleFrame = Instance.new("Frame")
                ToggleFrame.Name = Name
                ToggleFrame.Parent = SectionContainer
                ToggleFrame.BackgroundTransparency = 1
                ToggleFrame.Size = UDim2.new(1, 0, 0, 30)
                
                local ToggleLabel = Instance.new("TextLabel")
                ToggleLabel.Name = "Label"
                ToggleLabel.Parent = ToggleFrame
                ToggleLabel.BackgroundTransparency = 1
                ToggleLabel.Size = UDim2.new(1, -45, 1, 0)
                ToggleLabel.Font = Enum.Font.Gotham
                ToggleLabel.Text = Name
                ToggleLabel.TextColor3 = Theme.Text
                ToggleLabel.TextSize = 13
                ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
                
                local ToggleButton = Instance.new("TextButton")
                ToggleButton.Name = "Button"
                ToggleButton.Parent = ToggleFrame
                ToggleButton.BackgroundColor3 = Default and Theme.Accent or Theme.Tab
                ToggleButton.BorderSizePixel = 0
                ToggleButton.Position = UDim2.new(1, -40, 0.5, -10)
                ToggleButton.Size = UDim2.new(0, 40, 0, 20)
                ToggleButton.Text = ""
                
                local ToggleCorner = Instance.new("UICorner")
                ToggleCorner.CornerRadius = UDim.new(1, 0)
                ToggleCorner.Parent = ToggleButton
                
                local ToggleCircle = Instance.new("Frame")
                ToggleCircle.Name = "Circle"
                ToggleCircle.Parent = ToggleButton
                ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleCircle.BorderSizePixel = 0
                ToggleCircle.Position = Default and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
                ToggleCircle.Size = UDim2.new(0, 16, 0, 16)
                
                local CircleCorner = Instance.new("UICorner")
                CircleCorner.CornerRadius = UDim.new(1, 0)
                CircleCorner.Parent = ToggleCircle
                
                local Toggled = Default
                ConfigSystem.Configs[Flag] = Default
                
                ToggleButton.MouseButton1Click:Connect(function()
                    Toggled = not Toggled
                    ConfigSystem.Configs[Flag] = Toggled
                    
                    Tween(ToggleButton, {BackgroundColor3 = Toggled and Theme.Accent or Theme.Tab}, 0.2)
                    Tween(ToggleCircle, {Position = Toggled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)}, 0.2)
                    
                    Callback(Toggled)
                    
                    if ConfigSystem.AutoSave then
                        ConfigSystem:SaveConfig()
                    end
                end)
                
                ConfigSystem.Callbacks[Flag] = function(value)
                    Toggled = value
                    ToggleButton.BackgroundColor3 = value and Theme.Accent or Theme.Tab
                    ToggleCircle.Position = value and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
                    Callback(value)
                end
                
                return {
                    Set = function(self, value)
                        Toggled = value
                        ConfigSystem.Configs[Flag] = value
                        Tween(ToggleButton, {BackgroundColor3 = value and Theme.Accent or Theme.Tab}, 0.2)
                        Tween(ToggleCircle, {Position = value and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)}, 0.2)
                        Callback(value)
                    end
                }
            end
            
            -- Button Element
            function SectionObj:AddButton(config)
                config = config or {}
                local Name = config.Name or "Button"
                local Callback = config.Callback or function() end
                
                local Button = Instance.new("TextButton")
                Button.Name = Name
                Button.Parent = SectionContainer
                Button.BackgroundColor3 = Theme.Tab
                Button.BorderSizePixel = 0
                Button.Size = UDim2.new(1, 0, 0, 35)
                Button.Font = Enum.Font.GothamSemibold
                Button.Text = Name
                Button.TextColor3 = Theme.Text
                Button.TextSize = 13
                
                local ButtonCorner = Instance.new("UICorner")
                ButtonCorner.CornerRadius = UDim.new(0, 6)
                ButtonCorner.Parent = Button
                
                Button.MouseEnter:Connect(function()
                    Tween(Button, {BackgroundColor3 = Theme.Accent}, 0.2)
                end)
                
                Button.MouseLeave:Connect(function()
                    Tween(Button, {BackgroundColor3 = Theme.Tab}, 0.2)
                end)
                
                Button.MouseButton1Click:Connect(function()
                    Ripple(Button)
                    Callback()
                end)
                
                return Button
            end
            
            -- Slider Element
            function SectionObj:AddSlider(config)
                config = config or {}
                local Name = config.Name or "Slider"
                local Min = config.Min or 0
                local Max = config.Max or 100
                local Default = config.Default or Min
                local Increment = config.Increment or 1
                local Callback = config.Callback or function() end
                local Flag = config.Flag or Name
                
                local SliderFrame = Instance.new("Frame")
                SliderFrame.Name = Name
                SliderFrame.Parent = SectionContainer
                SliderFrame.BackgroundTransparency = 1
                SliderFrame.Size = UDim2.new(1, 0, 0, 50)
                
                local SliderLabel = Instance.new("TextLabel")
                SliderLabel.Name = "Label"
                SliderLabel.Parent = SliderFrame
                SliderLabel.BackgroundTransparency = 1
                SliderLabel.Size = UDim2.new(1, -60, 0, 20)
                SliderLabel.Font = Enum.Font.Gotham
                SliderLabel.Text = Name
                SliderLabel.TextColor3 = Theme.Text
                SliderLabel.TextSize = 13
                SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
                
                local SliderValue = Instance.new("TextLabel")
                SliderValue.Name = "Value"
                SliderValue.Parent = SliderFrame
                SliderValue.BackgroundTransparency = 1
                SliderValue.Position = UDim2.new(1, -55, 0, 0)
                SliderValue.Size = UDim2.new(0, 55, 0, 20)
                SliderValue.Font = Enum.Font.GothamBold
                SliderValue.Text = tostring(Default)
                SliderValue.TextColor3 = Theme.Accent
                SliderValue.TextSize = 13
                SliderValue.TextXAlignment = Enum.TextXAlignment.Right
                
                local SliderBack = Instance.new("Frame")
                SliderBack.Name = "Background"
                SliderBack.Parent = SliderFrame
                SliderBack.BackgroundColor3 = Theme.Tab
                SliderBack.BorderSizePixel = 0
                SliderBack.Position = UDim2.new(0, 0, 0, 28)
                SliderBack.Size = UDim2.new(1, 0, 0, 6)
                
                local SliderBackCorner = Instance.new("UICorner")
                SliderBackCorner.CornerRadius = UDim.new(1, 0)
                SliderBackCorner.Parent = SliderBack
                
                local SliderFill = Instance.new("Frame")
                SliderFill.Name = "Fill"
                SliderFill.Parent = SliderBack
                SliderFill.BackgroundColor3 = Theme.Accent
                SliderFill.BorderSizePixel = 0
                SliderFill.Size = UDim2.new((Default - Min) / (Max - Min), 0, 1, 0)
                
                local SliderFillCorner = Instance.new("UICorner")
                SliderFillCorner.CornerRadius = UDim.new(1, 0)
                SliderFillCorner.Parent = SliderFill
                
                local SliderCircle = Instance.new("Frame")
                SliderCircle.Name = "Circle"
                SliderCircle.Parent = SliderFill
                SliderCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderCircle.BorderSizePixel = 0
                SliderCircle.Position = UDim2.new(1, -8, 0.5, -8)
                SliderCircle.Size = UDim2.new(0, 16, 0, 16)
                
                local CircleCorner = Instance.new("UICorner")
                CircleCorner.CornerRadius = UDim.new(1, 0)
                CircleCorner.Parent = SliderCircle
                
                local Value = Default
                ConfigSystem.Configs[Flag] = Default
                
                local function UpdateSlider(input)
                    local pos = math.clamp((input.Position.X - SliderBack.AbsolutePosition.X) / SliderBack.AbsoluteSize.X, 0, 1)
                    Value = math.floor(Min + (Max - Min) * pos / Increment + 0.5) * Increment
                    Value = math.clamp(Value, Min, Max)
                    
                    ConfigSystem.Configs[Flag] = Value
                    SliderValue.Text = tostring(Value)
                    Tween(SliderFill, {Size = UDim2.new((Value - Min) / (Max - Min), 0, 1, 0)}, 0.1)
                    Callback(Value)
                    
                    if ConfigSystem.AutoSave then
                        ConfigSystem:SaveConfig()
                    end
                end
                
                local dragging = false
                
                SliderBack.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                        UpdateSlider(input)
                    end
                end)
                
                SliderBack.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)
                
                UserInputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        UpdateSlider(input)
                    end
                end)
                
                ConfigSystem.Callbacks[Flag] = function(value)
                    Value = value
                    SliderValue.Text = tostring(value)
                    SliderFill.Size = UDim2.new((value - Min) / (Max - Min), 0, 1, 0)
                    Callback(value)
                end
                
                return {
                    Set = function(self, value)
                        Value = math.clamp(value, Min, Max)
                        ConfigSystem.Configs[Flag] = Value
                        SliderValue.Text = tostring(Value)
                        Tween(SliderFill, {Size = UDim2.new((Value - Min) / (Max - Min), 0, 1, 0)}, 0.2)
                        Callback(Value)
                    end
                }
            end
            
            -- Dropdown Element
            function SectionObj:AddDropdown(config)
                config = config or {}
                local Name = config.Name or "Dropdown"
                local Options = config.Options or {}
                local Default = config.Default or Options[1]
                local Callback = config.Callback or function() end
                local Flag = config.Flag or Name
                
                local DropdownFrame = Instance.new("Frame")
                DropdownFrame.Name = Name
                DropdownFrame.Parent = SectionContainer
                DropdownFrame.BackgroundTransparency = 1
                DropdownFrame.Size = UDim2.new(1, 0, 0, 40)
                DropdownFrame.ClipsDescendants = true
                
                local DropdownLabel = Instance.new("TextLabel")
                DropdownLabel.Name = "Label"
                DropdownLabel.Parent = DropdownFrame
                DropdownLabel.BackgroundTransparency = 1
                DropdownLabel.Size = UDim2.new(1, 0, 0, 20)
                DropdownLabel.Font = Enum.Font.Gotham
                DropdownLabel.Text = Name
                DropdownLabel.TextColor3 = Theme.Text
                DropdownLabel.TextSize = 13
                DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
                
                local DropdownButton = Instance.new("TextButton")
                DropdownButton.Name = "Button"
                DropdownButton.Parent = DropdownFrame
                DropdownButton.BackgroundColor3 = Theme.Tab
                DropdownButton.BorderSizePixel = 0
                DropdownButton.Position = UDim2.new(0, 0, 0, 22)
                DropdownButton.Size = UDim2.new(1, 0, 0, 30)
                DropdownButton.Font = Enum.Font.Gotham
                DropdownButton.Text = Default or "Select..."
                DropdownButton.TextColor3 = Theme.Text
                DropdownButton.TextSize = 12
                
                local ButtonCorner = Instance.new("UICorner")
                ButtonCorner.CornerRadius = UDim.new(0, 6)
                ButtonCorner.Parent = DropdownButton
                
                local DropdownIcon = Instance.new("TextLabel")
                DropdownIcon.Name = "Icon"
                DropdownIcon.Parent = DropdownButton
                DropdownIcon.BackgroundTransparency = 1
                DropdownIcon.Position = UDim2.new(1, -25, 0, 0)
                DropdownIcon.Size = UDim2.new(0, 25, 1, 0)
                DropdownIcon.Font = Enum.Font.GothamBold
                DropdownIcon.Text = "▼"
                DropdownIcon.TextColor3 = Theme.SubText
                DropdownIcon.TextSize = 10
                
                local DropdownList = Instance.new("ScrollingFrame")
                DropdownList.Name = "List"
                DropdownList.Parent = DropdownFrame
                DropdownList.Active = true
                DropdownList.BackgroundColor3 = Theme.Tab
                DropdownList.BorderSizePixel = 0
                DropdownList.Position = UDim2.new(0, 0, 0, 54)
                DropdownList.Size = UDim2.new(1, 0, 0, 0)
                DropdownList.ScrollBarThickness = 4
                DropdownList.ScrollBarImageColor3 = Theme.Accent
                DropdownList.CanvasSize = UDim2.new(0, 0, 0, 0)
                DropdownList.Visible = false
                
                local ListCorner = Instance.new("UICorner")
                ListCorner.CornerRadius = UDim.new(0, 6)
                ListCorner.Parent = DropdownList
                
                local ListLayout = Instance.new("UIListLayout")
                ListLayout.Parent = DropdownList
                ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                ListLayout.Padding = UDim.new(0, 2)
                
                local ListPadding = Instance.new("UIPadding")
                ListPadding.Parent = DropdownList
                ListPadding.PaddingTop = UDim.new(0, 5)
                ListPadding.PaddingBottom = UDim.new(0, 5)
                ListPadding.PaddingLeft = UDim.new(0, 5)
                ListPadding.PaddingRight = UDim.new(0, 5)
                
                local Selected = Default
                local Open = false
                ConfigSystem.Configs[Flag] = Default
                
                for _, option in ipairs(Options) do
                    local OptionButton = Instance.new("TextButton")
                    OptionButton.Name = option
                    OptionButton.Parent = DropdownList
                    OptionButton.BackgroundColor3 = Theme.Element
                    OptionButton.BorderSizePixel = 0
                    OptionButton.Size = UDim2.new(1, -10, 0, 25)
                    OptionButton.Font = Enum.Font.Gotham
                    OptionButton.Text = option
                    OptionButton.TextColor3 = Theme.Text
                    OptionButton.TextSize = 12
                    
                    local OptionCorner = Instance.new("UICorner")
                    OptionCorner.CornerRadius = UDim.new(0, 4)
                    OptionCorner.Parent = OptionButton
                    
                    OptionButton.MouseEnter:Connect(function()
                        Tween(OptionButton, {BackgroundColor3 = Theme.Accent}, 0.2)
                    end)
                    
                    OptionButton.MouseLeave:Connect(function()
                        Tween(OptionButton, {BackgroundColor3 = Theme.Element}, 0.2)
                    end)
                    
                    OptionButton.MouseButton1Click:Connect(function()
                        Selected = option
                        ConfigSystem.Configs[Flag] = option
                        DropdownButton.Text = option
                        Open = false
                        Tween(DropdownFrame, {Size = UDim2.new(1, 0, 0, 54)}, 0.3)
                        Tween(DropdownIcon, {Rotation = 0}, 0.3)
                        DropdownList.Visible = false
                        Callback(option)
                        
                        if ConfigSystem.AutoSave then
                            ConfigSystem:SaveConfig()
                        end
                    end)
                end
                
                ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    DropdownList.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 10)
                end)
                
                DropdownButton.MouseButton1Click:Connect(function()
                    Open = not Open
                    local listHeight = math.min(120, ListLayout.AbsoluteContentSize.Y + 10)
                    
                    if Open then
                        DropdownList.Visible = true
                        DropdownList.Size = UDim2.new(1, 0, 0, 0)
                        Tween(DropdownList, {Size = UDim2.new(1, 0, 0, listHeight)}, 0.3)
                        Tween(DropdownFrame, {Size = UDim2.new(1, 0, 0, 54 + listHeight + 5)}, 0.3)
                        Tween(DropdownIcon, {Rotation = 180}, 0.3)
                    else
                        Tween(DropdownList, {Size = UDim2.new(1, 0, 0, 0)}, 0.3)
                        Tween(DropdownFrame, {Size = UDim2.new(1, 0, 0, 54)}, 0.3)
                        Tween(DropdownIcon, {Rotation = 0}, 0.3)
                        wait(0.3)
                        DropdownList.Visible = false
                    end
                end)
                
                ConfigSystem.Callbacks[Flag] = function(value)
                    Selected = value
                    DropdownButton.Text = value
                    Callback(value)
                end
                
                return {
                    Set = function(self, value)
                        Selected = value
                        ConfigSystem.Configs[Flag] = value
                        DropdownButton.Text = value
                        Callback(value)
                    end,
                    Refresh = function(self, newOptions)
                        for _, child in ipairs(DropdownList:GetChildren()) do
                            if child:IsA("TextButton") then
                                child:Destroy()
                            end
                        end
                        
                        Options = newOptions
                        for _, option in ipairs(Options) do
                            local OptionButton = Instance.new("TextButton")
                            OptionButton.Name = option
                            OptionButton.Parent = DropdownList
                            OptionButton.BackgroundColor3 = Theme.Element
                            OptionButton.BorderSizePixel = 0
                            OptionButton.Size = UDim2.new(1, -10, 0, 25)
                            OptionButton.Font = Enum.Font.Gotham
                            OptionButton.Text = option
                            OptionButton.TextColor3 = Theme.Text
                            OptionButton.TextSize = 12
                            
                            local OptionCorner = Instance.new("UICorner")
                            OptionCorner.CornerRadius = UDim.new(0, 4)
                            OptionCorner.Parent = OptionButton
                            
                            OptionButton.MouseButton1Click:Connect(function()
                                Selected = option
                                DropdownButton.Text = option
                                Callback(option)
                            end)
                        end
                    end
                }
            end
            
            -- TextBox Element
            function SectionObj:AddTextBox(config)
                config = config or {}
                local Name = config.Name or "TextBox"
                local Default = config.Default or ""
                local Placeholder = config.Placeholder or "Enter text..."
                local Callback = config.Callback or function() end
                local Flag = config.Flag or Name
                
                local TextBoxFrame = Instance.new("Frame")
                TextBoxFrame.Name = Name
                TextBoxFrame.Parent = SectionContainer
                TextBoxFrame.BackgroundTransparency = 1
                TextBoxFrame.Size = UDim2.new(1, 0, 0, 50)
                
                local TextBoxLabel = Instance.new("TextLabel")
                TextBoxLabel.Name = "Label"
                TextBoxLabel.Parent = TextBoxFrame
                TextBoxLabel.BackgroundTransparency = 1
                TextBoxLabel.Size = UDim2.new(1, 0, 0, 20)
                TextBoxLabel.Font = Enum.Font.Gotham
                TextBoxLabel.Text = Name
                TextBoxLabel.TextColor3 = Theme.Text
                TextBoxLabel.TextSize = 13
                TextBoxLabel.TextXAlignment = Enum.TextXAlignment.Left
                
                local TextBox = Instance.new("TextBox")
                TextBox.Name = "Input"
                TextBox.Parent = TextBoxFrame
                TextBox.BackgroundColor3 = Theme.Tab
                TextBox.BorderSizePixel = 0
                TextBox.Position = UDim2.new(0, 0, 0, 24)
                TextBox.Size = UDim2.new(1, 0, 0, 30)
                TextBox.Font = Enum.Font.Gotham
                TextBox.PlaceholderText = Placeholder
                TextBox.Text = Default
                TextBox.TextColor3 = Theme.Text
                TextBox.TextSize = 12
                TextBox.ClearTextOnFocus = false
                
                local TextBoxCorner = Instance.new("UICorner")
                TextBoxCorner.CornerRadius = UDim.new(0, 6)
                TextBoxCorner.Parent = TextBox
                
                local TextBoxPadding = Instance.new("UIPadding")
                TextBoxPadding.Parent = TextBox
                TextBoxPadding.PaddingLeft = UDim.new(0, 10)
                TextBoxPadding.PaddingRight = UDim.new(0, 10)
                
                ConfigSystem.Configs[Flag] = Default
                
                TextBox.FocusLost:Connect(function()
                    ConfigSystem.Configs[Flag] = TextBox.Text
                    Callback(TextBox.Text)
                    
                    if ConfigSystem.AutoSave then
                        ConfigSystem:SaveConfig()
                    end
                end)
                
                ConfigSystem.Callbacks[Flag] = function(value)
                    TextBox.Text = value
                    Callback(value)
                end
                
                return {
                    Set = function(self, value)
                        TextBox.Text = value
                        ConfigSystem.Configs[Flag] = value
                        Callback(value)
                    end
                }
            end
            
            -- Label Element
            function SectionObj:AddLabel(text)
                local Label = Instance.new("TextLabel")
                Label.Name = "Label"
                Label.Parent = SectionContainer
                Label.BackgroundTransparency = 1
                Label.Size = UDim2.new(1, 0, 0, 20)
                Label.Font = Enum.Font.Gotham
                Label.Text = text
                Label.TextColor3 = Theme.SubText
                Label.TextSize = 12
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.TextWrapped = true
                Label.AutomaticSize = Enum.AutomaticSize.Y
                
                return {
                    Set = function(self, newText)
                        Label.Text = newText
                    end
                }
            end
            
            -- Keybind Element
            function SectionObj:AddKeybind(config)
                config = config or {}
                local Name = config.Name or "Keybind"
                local Default = config.Default or Enum.KeyCode.E
                local Callback = config.Callback or function() end
                local Flag = config.Flag or Name
                
                local KeybindFrame = Instance.new("Frame")
                KeybindFrame.Name = Name
                KeybindFrame.Parent = SectionContainer
                KeybindFrame.BackgroundTransparency = 1
                KeybindFrame.Size = UDim2.new(1, 0, 0, 30)
                
                local KeybindLabel = Instance.new("TextLabel")
                KeybindLabel.Name = "Label"
                KeybindLabel.Parent = KeybindFrame
                KeybindLabel.BackgroundTransparency = 1
                KeybindLabel.Size = UDim2.new(1, -80, 1, 0)
                KeybindLabel.Font = Enum.Font.Gotham
                KeybindLabel.Text = Name
                KeybindLabel.TextColor3 = Theme.Text
                KeybindLabel.TextSize = 13
                KeybindLabel.TextXAlignment = Enum.TextXAlignment.Left
                
                local KeybindButton = Instance.new("TextButton")
                KeybindButton.Name = "Button"
                KeybindButton.Parent = KeybindFrame
                KeybindButton.BackgroundColor3 = Theme.Tab
                KeybindButton.BorderSizePixel = 0
                KeybindButton.Position = UDim2.new(1, -75, 0.5, -12)
                KeybindButton.Size = UDim2.new(0, 75, 0, 24)
                KeybindButton.Font = Enum.Font.GothamSemibold
                KeybindButton.Text = Default.Name
                KeybindButton.TextColor3 = Theme.Text
                KeybindButton.TextSize = 11
                
                local ButtonCorner = Instance.new("UICorner")
                ButtonCorner.CornerRadius = UDim.new(0, 6)
                ButtonCorner.Parent = KeybindButton
                
                local CurrentKey = Default
                local Binding = false
                ConfigSystem.Configs[Flag] = Default
                
                KeybindButton.MouseButton1Click:Connect(function()
                    Binding = true
                    KeybindButton.Text = "..."
                    KeybindButton.BackgroundColor3 = Theme.Accent
                end)
                
                UserInputService.InputBegan:Connect(function(input, processed)
                    if Binding then
                        if input.KeyCode ~= Enum.KeyCode.Unknown then
                            CurrentKey = input.KeyCode
                            ConfigSystem.Configs[Flag] = CurrentKey
                            KeybindButton.Text = CurrentKey.Name
                            KeybindButton.BackgroundColor3 = Theme.Tab
                            Binding = false
                            
                            if ConfigSystem.AutoSave then
                                ConfigSystem:SaveConfig()
                            end
                        end
                    elseif not processed and input.KeyCode == CurrentKey then
                        Callback()
                    end
                end)
                
                ConfigSystem.Callbacks[Flag] = function(value)
                    CurrentKey = value
                    KeybindButton.Text = value.Name
                end
                
                return {
                    Set = function(self, key)
                        CurrentKey = key
                        ConfigSystem.Configs[Flag] = key
                        KeybindButton.Text = key.Name
                    end
                }
            end
            
            -- Color Picker Element
            function SectionObj:AddColorPicker(config)
                config = config or {}
                local Name = config.Name or "Color"
                local Default = config.Default or Color3.fromRGB(255, 255, 255)
                local Callback = config.Callback or function() end
                local Flag = config.Flag or Name
                
                local ColorFrame = Instance.new("Frame")
                ColorFrame.Name = Name
                ColorFrame.Parent = SectionContainer
                ColorFrame.BackgroundTransparency = 1
                ColorFrame.Size = UDim2.new(1, 0, 0, 30)
                
                local ColorLabel = Instance.new("TextLabel")
                ColorLabel.Name = "Label"
                ColorLabel.Parent = ColorFrame
                ColorLabel.BackgroundTransparency = 1
                ColorLabel.Size = UDim2.new(1, -40, 1, 0)
                ColorLabel.Font = Enum.Font.Gotham
                ColorLabel.Text = Name
                ColorLabel.TextColor3 = Theme.Text
                ColorLabel.TextSize = 13
                ColorLabel.TextXAlignment = Enum.TextXAlignment.Left
                
                local ColorDisplay = Instance.new("TextButton")
                ColorDisplay.Name = "Display"
                ColorDisplay.Parent = ColorFrame
                ColorDisplay.BackgroundColor3 = Default
                ColorDisplay.BorderSizePixel = 0
                ColorDisplay.Position = UDim2.new(1, -35, 0.5, -12)
                ColorDisplay.Size = UDim2.new(0, 35, 0, 24)
                ColorDisplay.Text = ""
                
                local DisplayCorner = Instance.new("UICorner")
                DisplayCorner.CornerRadius = UDim.new(0, 6)
                DisplayCorner.Parent = ColorDisplay
                
                ConfigSystem.Configs[Flag] = Default
                
                ColorDisplay.MouseButton1Click:Connect(function()
                    -- Simple color picker (you can expand this)
                    Window:Notify({
                        Title = "Color Picker",
                        Content = "Advanced color picker coming soon!",
                        Duration = 2
                    })
                end)
                
                ConfigSystem.Callbacks[Flag] = function(value)
                    ColorDisplay.BackgroundColor3 = value
                    Callback(value)
                end
                
                return {
                    Set = function(self, color)
                        ConfigSystem.Configs[Flag] = color
                        ColorDisplay.BackgroundColor3 = color
                        Callback(color)
                    end
                }
            end
            
            table.insert(Tab.Sections, SectionObj)
            return SectionObj
        end
        
        table.insert(Window.Tabs, Tab)
        return Tab
    end
    
    -- Config Tab
    local ConfigTab = Window:CreateTab({Name = "Configs", Icon = "⚙️"})
    local ConfigSection = ConfigTab:CreateSection("Config Management")
    
    local configListDropdown
    local function RefreshConfigList()
        local configs = ConfigSystem:ListConfigs()
        if configListDropdown then
            configListDropdown:Refresh(configs)
        end
    end
    
    configListDropdown = ConfigSection:AddDropdown({
        Name = "Select Config",
        Options = ConfigSystem:ListConfigs(),
        Default = "default",
        Callback = function(option)
            ConfigSystem.CurrentConfig = option
        end
    })
    
    ConfigSection:AddButton({
        Name = "Refresh List",
        Callback = function()
            RefreshConfigList()
            Window:Notify({
                Title = "Configs",
                Content = "Config list refreshed!",
                Type = "Success"
            })
        end
    })
    
    ConfigSection:AddButton({
        Name = "Load Config",
        Callback = function()
            local success, message = ConfigSystem:LoadConfig()
            Window:Notify({
                Title = "Load Config",
                Content = message,
                Type = success and "Success" or "Error"
            })
        end
    })
    
    ConfigSection:AddButton({
        Name = "Save Config",
        Callback = function()
            local success, message = ConfigSystem:SaveConfig()
            Window:Notify({
                Title = "Save Config",
                Content = message,
                Type = success and "Success" or "Error"
            })
        end
    })
    
    ConfigSection:AddButton({
        Name = "Delete Config",
        Callback = function()
            local success, message = ConfigSystem:DeleteConfig(ConfigSystem.CurrentConfig)
            RefreshConfigList()
            Window:Notify({
                Title = "Delete Config",
                Content = message,
                Type = success and "Success" or "Error"
            })
        end
    })
    
    ConfigSection:AddToggle({
        Name = "Auto Save",
        Default = true,
        Callback = function(value)
            ConfigSystem.AutoSave = value
        end
    })
    
    ConfigSection:AddToggle({
        Name = "Auto Load",
        Default = false,
        Callback = function(value)
            ConfigSystem.AutoLoad = value
        end
    })
    
    return Window
end

return MoonHub