local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")

getgenv().SukunaESP = {
    Enabled = false,
    NormalColor = Color3.fromRGB(0, 255, 0),
    KillerColor = Color3.fromRGB(255, 0, 0),
    GenIncomplete = Color3.fromRGB(255, 165, 0),
    GenComplete = Color3.fromRGB(0, 255, 0),
    BatteryColor = Color3.fromRGB(0, 191, 255),
    FuseBoxColor = Color3.fromRGB(255, 255, 0),
    Chams = false,
    Boxes = false,
    Usernames = false,
    Generators = false,
    Batteries = false,
    FuseBoxes = false
}

getgenv().Noclip = false
getgenv().AutoGenerator = false
getgenv().GenDelay = 0.1
getgenv().InfStamina = false
getgenv().FullBright = false
getgenv().AutoRun = false
getgenv().SpeedChangerLoop = false
getgenv().CurrentWalkSpeed = 16
getgenv().AutoEscape = false
getgenv().NoDoors = false
getgenv().AutoBarricade = false

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if not checkcaller() and getgenv().AutoBarricade and typeof(self) == "Instance" then
        if method == "FireServer" and self.Name == "Event" and type(args[1]) == "number" then
            args[1] = 100
            return oldNamecall(self, unpack(args))
        elseif method == "SetAttribute" and args[1] == "HP" then
            args[2] = 100
            return oldNamecall(self, unpack(args))
        end
    end
    return oldNamecall(self, ...)
end)

local oldNewIndex
oldNewIndex = hookmetamethod(game, "__newindex", function(t, k, v)
    if not checkcaller() and getgenv().AutoBarricade and typeof(t) == "Instance" then
        if k == "Position" and t.Name == "Frame" then
            local parent = t.Parent
            if parent and parent.Name == "Container" then
                local centerPos = UDim2.new(0, parent.AbsoluteSize.X / 2, 0, parent.AbsoluteSize.Y / 2)
                return oldNewIndex(t, k, centerPos)
            end
        elseif k == "Offset" and t.Name == "UIGradient" then
            return oldNewIndex(t, k, Vector2.new(0.5, 0))
        end
    end
    return oldNewIndex(t, k, v)
end)

local function ApplyNoclip()
    if getgenv().Noclip and LocalPlayer.Character then
        for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end

RunService.Stepped:Connect(function()
    if getgenv().Noclip then
        ApplyNoclip()
    end
end)

local function ToggleInstantGen(state)
    getgenv().AutoGenerator = state
    
    if state then
        task.spawn(function()
            while getgenv().AutoGenerator do
                task.wait(getgenv().GenDelay)

                local Players = game:GetService("Players")
                local LocalPlayer = Players.LocalPlayer
                local char = LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")

                if hrp then
                    local activeUI = nil
                    local remoteEvent = nil

                    for _, gui in ipairs(LocalPlayer.PlayerGui:GetChildren()) do
                        if gui:IsA("ScreenGui") then
                            local mainFrame = gui:FindFirstChild("MainFrame", true)
                            local event = gui:FindFirstChild("Event", true)
                            
                            if mainFrame and event and event:IsA("RemoteEvent") then
                                activeUI = gui
                                remoteEvent = event
                                break
                            end
                        end
                    end

                    if activeUI and remoteEvent then
                        local data = { Lever = true, Switches = true, Wires = true }
                        remoteEvent:FireServer(data)
                        
                        activeUI:Destroy()
                        
                        task.wait(0.5)
                    else
                        local nearestPrompt = nil
                        local minDist = 20

                        for _, prompt in ipairs(workspace:GetDescendants()) do
                            if prompt:IsA("ProximityPrompt") and prompt.Enabled then
                                local parentPart = prompt.Parent
                                if parentPart and parentPart:IsA("BasePart") then
                                    local dist = (hrp.Position - parentPart.Position).Magnitude
                                    if dist < minDist then
                                        minDist = dist
                                        nearestPrompt = prompt
                                    end
                                end
                            end
                        end

                        if nearestPrompt then
                            fireproximityprompt(nearestPrompt)
                            task.wait(0.5)
                        end
                    end
                end
            end
        end)
    end
end

local function LockStamina()
    if LocalPlayer.Character then
        LocalPlayer.Character:SetAttribute("Stamina", 100)
    end
end

RunService.Heartbeat:Connect(function()
    if getgenv().InfStamina then LockStamina() end
end)

LocalPlayer.CharacterAdded:Connect(function(char)
    if getgenv().InfStamina then
        task.wait(1)
        char:SetAttribute("Stamina", 100)
    end
end)

local function SetFullBright(state)
    if state then
        Lighting.Brightness = 2
        Lighting.ClockTime = 12
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    else
        Lighting.Brightness = 1
        Lighting.ClockTime = 0
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = true
        Lighting.OutdoorAmbient = Color3.fromRGB(0, 0, 0)
    end
end

local Cache = {}

local function CreateDrawing(type, properties)
    local drawing = Drawing.new(type)
    for i, v in pairs(properties) do
        drawing[i] = v
    end
    return drawing
end

local function AddPlayerESP(player)
    if Cache[player] then return end
    Cache[player] = {
        Box = CreateDrawing("Square", {Thickness = 1, Filled = false, Transparency = 1, Visible = false}),
        Text = CreateDrawing("Text", {Size = 14, Center = true, Outline = true, Visible = false})
    }
end

local function UpdateESP()
    for player, drawings in pairs(Cache) do
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") and getgenv().SukunaESP.Enabled then
            local hrp = character.HumanoidRootPart
            local pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
            local isKiller = false
            if workspace:FindFirstChild("PLAYERS") and workspace.PLAYERS:FindFirstChild("KILLER") then
                isKiller = character:IsDescendantOf(workspace.PLAYERS.KILLER)
            end
            local color = isKiller and getgenv().SukunaESP.KillerColor or getgenv().SukunaESP.NormalColor

            if onScreen then
                if getgenv().SukunaESP.Boxes then
                    local sizeX = 2000 / pos.Z
                    local sizeY = 3000 / pos.Z
                    drawings.Box.Size = Vector2.new(sizeX, sizeY)
                    drawings.Box.Position = Vector2.new(pos.X - sizeX / 2, pos.Y - sizeY / 2)
                    drawings.Box.Color = color
                    drawings.Box.Visible = true
                else
                    drawings.Box.Visible = false
                end

                if getgenv().SukunaESP.Usernames then
                    drawings.Text.Position = Vector2.new(pos.X, pos.Y - (3500 / pos.Z) / 2 - 15)
                    drawings.Text.Text = (isKiller and "[KILLER] " or "") .. player.Name
                    drawings.Text.Color = color
                    drawings.Text.Visible = true
                else
                    drawings.Text.Visible = false
                end

                if getgenv().SukunaESP.Chams then
                    local highlight = character:FindFirstChild("SukunaHighlight") or Instance.new("Highlight", character)
                    highlight.Name = "SukunaHighlight"
                    highlight.FillColor = color
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.Enabled = true
                else
                    if character:FindFirstChild("SukunaHighlight") then
                        character.SukunaHighlight.Enabled = false
                    end
                end
            else
                drawings.Box.Visible = false
                drawings.Text.Visible = false
            end
        else
            drawings.Box.Visible = false
            drawings.Text.Visible = false
        end
    end
end

local function ObjectESP()
    local GameMap = workspace:FindFirstChild("MAPS") and workspace.MAPS:FindFirstChild("GAME MAP")
    if not GameMap then return end

    local Objects = {
        {Folder = GameMap:FindFirstChild("Generators"), Name = "Generator", Type = "Gen"},
        {Folder = GameMap:FindFirstChild("Batteries"), Name = "Battery", Type = "Battery"},
        {Folder = GameMap:FindFirstChild("FuseBoxes"), Name = "FuseBox", Type = "Fuse"}
    }

    for _, objGroup in ipairs(Objects) do
        if objGroup.Folder then
            for _, v in ipairs(objGroup.Folder:GetChildren()) do
                local valid = false
                local color = Color3.new(1,1,1)
                local dName = objGroup.Name

                if objGroup.Type == "Gen" and getgenv().SukunaESP.Generators then
                    valid = true
                    color = v:GetAttribute("Completed") and getgenv().SukunaESP.GenComplete or getgenv().SukunaESP.GenIncomplete
                elseif objGroup.Type == "Battery" and getgenv().SukunaESP.Batteries then
                    valid = true
                    color = getgenv().SukunaESP.BatteryColor
                elseif objGroup.Type == "Fuse" and getgenv().SukunaESP.FuseBoxes then
                    valid = true
                    color = v:GetAttribute("Inserted") and getgenv().SukunaESP.GenComplete or getgenv().SukunaESP.FuseBoxColor
                end

                local bg = v:FindFirstChild("SukunaTag")

                if valid and getgenv().SukunaESP.Enabled then
                    if not bg then
                        bg = Instance.new("BillboardGui")
                        bg.Name = "SukunaTag"
                        bg.AlwaysOnTop = true
                        bg.Size = UDim2.new(0, 100, 0, 50)
                        
                        local targetPart = v:IsA("Model") and (v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart", true)) or v
                        bg.Adornee = targetPart
                        bg.Parent = v

                        local lbl = Instance.new("TextLabel", bg)
                        lbl.BackgroundTransparency = 1
                        lbl.Size = UDim2.new(1, 0, 1, 0)
                        lbl.Font = Enum.Font.Code
                        lbl.TextSize = 12
                        lbl.TextStrokeTransparency = 0
                    end

                    local lbl = bg:FindFirstChildOfClass("TextLabel")
                    if lbl then
                        lbl.Text = dName
                        lbl.TextColor3 = color
                    end
                    bg.Enabled = true
                else
                    if bg then
                        bg.Enabled = false
                    end
                end
            end
        end
    end
end

for _, p in ipairs(Players:GetPlayers()) do
    if p ~= LocalPlayer then AddPlayerESP(p) end
end
Players.PlayerAdded:Connect(function(p)
    if p ~= LocalPlayer then AddPlayerESP(p) end
end)

RunService.RenderStepped:Connect(UpdateESP)
task.spawn(function()
    while task.wait(1) do
        ObjectESP()
    end
end)


local function ToggleAutoRun(state)
    getgenv().AutoRun = state
    
    if state then
        task.spawn(function()
            while getgenv().AutoRun do
                task.wait() 
                
                local Players = game:GetService("Players")
                local LocalPlayer = Players.LocalPlayer
                local char = LocalPlayer.Character
                
                if char then
                    char:SetAttribute("WalkSpeed", 24)
                end
            end
            
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            local char = LocalPlayer.Character
            
            if char then
                char:SetAttribute("WalkSpeed", 16)
            end
        end)
    end
end

local function ChangeSpeed(speedValue)
    getgenv().CurrentWalkSpeed = speedValue
    
    if speedValue > 16 then
        if not getgenv().SpeedChangerLoop then
            getgenv().SpeedChangerLoop = true
            
            task.spawn(function()
                while getgenv().SpeedChangerLoop do
                    task.wait() 
                    
                    local Players = game:GetService("Players")
                    local LocalPlayer = Players.LocalPlayer
                    local char = LocalPlayer.Character
                    
                    if char then
                        char:SetAttribute("WalkSpeed", getgenv().CurrentWalkSpeed)
                    end
                end
            end)
        end
    else
        getgenv().SpeedChangerLoop = false
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local char = LocalPlayer.Character
        
        if char then
            char:SetAttribute("WalkSpeed", 16)
        end
    end
end

local function ToggleAutoEscape(state)
    getgenv().AutoEscape = state
    
    if state then
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        
        task.spawn(function()
            while getgenv().AutoEscape do
                local char = LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                
                if hrp then
                    for _, obj in ipairs(workspace:GetDescendants()) do
                        if obj.Name == "EscapePoint" or string.find(string.lower(obj.Name), "escape") then
                            if obj:IsA("BasePart") or obj:IsA("Model") then
                                local highlight = obj:FindFirstChildWhichIsA("Highlight", true)
                                local isReady = false
                                
                                if highlight and highlight.Enabled then
                                    isReady = true
                                elseif obj:GetAttribute("Open") == true then
                                    isReady = true
                                end
                                
                                if isReady then
                                    local targetPos = obj:IsA("Model") and obj:GetPivot().Position or obj.Position
                                    hrp.CFrame = CFrame.new(targetPos + Vector3.new(0, 2, 0))
                                    
                                    getgenv().AutoEscape = false
                                    return
                                end
                            end
                        end
                    end
                end
                task.wait(0.1)
            end
        end)
    end
end
local function ToggleNoDoors(state)
    getgenv().NoDoors = state
    if getgenv().NoDoors then
        local GameMap = workspace:FindFirstChild("MAPS") and workspace.MAPS:FindFirstChild("GAME MAP")
        if GameMap and GameMap:FindFirstChild("Doors") then
            GameMap.Doors:Destroy()
        end
    end
end

local Window = WindUI:CreateWindow({
    Title = "Sukuna HUB",
    Icon = "sword",
    Author = "Sukuna Hub",
    Folder = "Sukuna",
    Size = UDim2.fromScale(0.7, 0.75),
    Theme = "Dark",
    HasOutline = true,
    Resizable = true,
    SideBarWidth = 200,
    ScrollBarEnabled = true,
})

Window:SetToggleKey(Enum.KeyCode.RightControl)

local Tabs = {
    Main = Window:Tab({ Title = "Main", Icon = "house" }),
    Movement = Window:Tab({ Title = "Movement", Icon = "battery" }),
    World = Window:Tab({ Title = "World", Icon = "globe" }),
    ESP = Window:Tab({ Title = "ESP", Icon = "eye" }),
    Settings = Window:Tab({ Title = "Settings", Icon = "settings" })
}

Tabs.Main:Section({ Title = "Auto Generator & Auto Escape" })
Tabs.Main:Toggle({
    Title = "Auto Generator",
    Default = getgenv().AutoGenerator,
    Callback = function(state) ToggleInstantGen(state) end
})
Tabs.Main:Slider({
    Title = "Generator delay",
    Step = 0.05,
    Value = {Min = 0.1, Max = 2, Default = getgenv().GenDelay},
    Suffix = " sec",
    Callback = function(value) getgenv().GenDelay = value end
})
Tabs.Main:Toggle({
    Title = "Auto Escape",
    Default = getgenv().AutoEscape,
    Callback = function(state) ToggleAutoEscape(state) end
})
Tabs.Main:Section({ Title = "Auto Barricade (be careful its cant be off)" })
Tabs.Main:Toggle({
	Title = "Auto Barricade",
	Default = getgenv().AutoBarricade,
	Callback = function(state)
})
Tabs.Main:Section({ Title = "Infinite Stamina" })
Tabs.Main:Toggle({
    Title = "Infinite Stamina",
    Default = getgenv().InfStamina,
    Callback = function(state) getgenv().InfStamina = state end
})

Tabs.Movement:Section({ Title = "Auto Run & Speed changer" })
Tabs.Movement:Toggle({
    Title = "Auto Run",
    Default = getgenv().AutoRun,
    Callback = function(state) ToggleAutoRun(state) end
})
Tabs.Movement:Slider({
    Title = "Custom Speed Changer",
    Step = 1,
    Value = {Min = 16, Max = 100, Default = 16},
    Suffix = " WS",
    Callback = function(value) ChangeSpeed(value) end
})

Tabs.Movement:Section({ Title = "No clip" })
Tabs.Movement:Toggle({
    Title = "Noclip",
    Default = getgenv().Noclip,
    Callback = function(state) getgenv().Noclip = state end
})

Tabs.World:Section({ Title = "Visuals" })
Tabs.World:Toggle({
    Title = "FullBright",
    Default = getgenv().FullBright,
    Callback = function(state)
        getgenv().FullBright = state
        SetFullBright(state)
    end
})
Tabs.World:Section({ Title = "Map Modifications" })
Tabs.World:Toggle({
    Title = "No Doors (be careful you cant get doors back)",
    Default = false,
    Callback = function(state)
        ToggleNoDoors(state)
    end
})
Tabs.ESP:Section({ Title = "Esp" })
Tabs.ESP:Toggle({
    Title = "Enable All ESP",
    Default = getgenv().SukunaESP.Enabled,
    Callback = function(state) getgenv().SukunaESP.Enabled = state end
})

Tabs.ESP:Section({ Title = "Player ESP" })
Tabs.ESP:Toggle({
    Title = "Player Boxes",
    Default = getgenv().SukunaESP.Boxes,
    Callback = function(state) getgenv().SukunaESP.Boxes = state end
})
Tabs.ESP:Toggle({
    Title = "Player Names",
    Default = getgenv().SukunaESP.Usernames,
    Callback = function(state) getgenv().SukunaESP.Usernames = state end
})
Tabs.ESP:Toggle({
    Title = "Chams (Highlight)",
    Default = getgenv().SukunaESP.Chams,
    Callback = function(state) getgenv().SukunaESP.Chams = state end
})

Tabs.ESP:Section({ Title = "Object ESP" })
Tabs.ESP:Toggle({
    Title = "Generators",
    Default = getgenv().SukunaESP.Generators,
    Callback = function(state) getgenv().SukunaESP.Generators = state end
})
Tabs.ESP:Toggle({
    Title = "Batteries",
    Default = getgenv().SukunaESP.Batteries,
    Callback = function(state) getgenv().SukunaESP.Batteries = state end
})
Tabs.ESP:Toggle({
    Title = "Fuse Boxes",
    Default = getgenv().SukunaESP.FuseBoxes,
    Callback = function(state) getgenv().SukunaESP.FuseBoxes = state end
})

Tabs.Settings:Section({ Title = "Utilities" })
Tabs.Settings:Button({
    Title = "Refresh Noclip",
    Callback = function()
        if getgenv().Noclip and LocalPlayer.Character then
            ApplyNoclip()
            WindUI:Notify({ Title = "Sukuna HUB", Content = "Noclip refreshed", Duration = 2 })
        end
    end
})
Tabs.Settings:Section({ Title = "UI Options" })
Tabs.Settings:Button({
    Title = "Destroy UI",
    Callback = function() Window:Destroy() end
})

WindUI:Notify({
    Title = "Sukuna HUB",
    Content = "Loaded successfully",
    Duration = 3
})

print("Sukuna HUB loaded successfully")
