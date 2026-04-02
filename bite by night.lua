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
getgenv().InstantGen = false
getgenv().GenDelay = 0.5
getgenv().InfStamina = false
getgenv().FullBright = false

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

local function Solve(gui)
    local event = gui:FindFirstChild("Event", true)
    if event and event:IsA("RemoteEvent") then
        task.wait(getgenv().GenDelay)
        local data = { Lever = true, Switches = true, Wires = true }
        event:FireServer(data)
        event:FireServer("Exit")
        if gui:IsA("ScreenGui") then
            gui.Enabled = false
            task.delay(0.1, function() gui:Destroy() end)
        end
    end
end

LocalPlayer.PlayerGui.ChildAdded:Connect(function(child)
    if getgenv().InstantGen then
        task.wait(0.05)
        if child:FindFirstChild("MainFrame", true) and child:FindFirstChild("Generator", true) then
            Solve(child)
        end
    end
end)

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

                if valid then
                    local tag = v:FindFirstChild("SukunaTag")
                    if not tag then
                        local bg = Instance.new("BillboardGui", v)
                        bg.Name = "SukunaTag"
                        bg.AlwaysOnTop = true
                        bg.Size = UDim2.new(0, 100, 0, 50)
                        local lbl = Instance.new("TextLabel", bg)
                        lbl.BackgroundTransparency = 1
                        lbl.Size = UDim2.new(1, 0, 1, 0)
                        lbl.Font = Enum.Font.Code
                        lbl.TextSize = 12
                        lbl.TextStrokeTransparency = 0
                        tag = lbl
                    else
                        tag = tag:FindFirstChildOfClass("TextLabel")
                    end
                    if tag then
                        tag.Text = dName
                        tag.TextColor3 = color
                        tag.Visible = getgenv().SukunaESP.Enabled
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
    while task.wait(5) do
        ObjectESP()
    end
end)

local function GetHRP(model)
    return model and model:FindFirstChild("HumanoidRootPart")
end

local function SafeTeleport(targetPos)
    local char = LocalPlayer.Character
    local hrp = GetHRP(char)
    if hrp and targetPos then
        hrp.CFrame = CFrame.new(targetPos + Vector3.new(0, 3, 0))
    end
end

local function GetGameMap()
    return workspace:FindFirstChild("MAPS") and workspace.MAPS:FindFirstChild("GAME MAP")
end

function TP_Escape()
    local ep = workspace:FindFirstChild("IGNORE") and workspace.IGNORE:FindFirstChild("EscapePoint")
    if ep then
        SafeTeleport(ep.Position)
    else
        WindUI:Notify({Title = "Sukuna HUB", Content = "EscapePoint not found", Duration = 2})
    end
end

function TP_Generator()
    local map = GetGameMap()
    if map and map:FindFirstChild("Generators") then
        local nearest = nil
        local minDist = math.huge
        local hrp = GetHRP(LocalPlayer.Character)
        if not hrp then return end
        for _, gen in ipairs(map.Generators:GetChildren()) do
            if not gen:GetAttribute("Completed") then
                local dist = (hrp.Position - gen.Position).Magnitude
                if dist < minDist then
                    minDist = dist
                    nearest = gen
                end
            end
        end
        if nearest then SafeTeleport(nearest.Position) end
    end
end

function TP_Battery()
    local map = GetGameMap()
    if map and map:FindFirstChild("Batteries") then
        local nearest = nil
        local minDist = math.huge
        local hrp = GetHRP(LocalPlayer.Character)
        if not hrp then return end
        for _, bat in ipairs(map.Batteries:GetChildren()) do
            local dist = (hrp.Position - bat.Position).Magnitude
            if dist < minDist then
                minDist = dist
                nearest = bat
            end
        end
        if nearest then SafeTeleport(nearest.Position) end
    end
end

function TP_FuseBox()
    local map = GetGameMap()
    if map and map:FindFirstChild("FuseBoxes") then
        local nearest = nil
        local minDist = math.huge
        local hrp = GetHRP(LocalPlayer.Character)
        if not hrp then return end
        for _, fb in ipairs(map.FuseBoxes:GetChildren()) do
            if not fb:GetAttribute("Inserted") then
                local dist = (hrp.Position - fb.Position).Magnitude
                if dist < minDist then
                    minDist = dist
                    nearest = fb
                end
            end
        end
        if nearest then SafeTeleport(nearest.Position) end
    end
end

function TP_Player()
    local alive = workspace:FindFirstChild("PLAYERS") and workspace.PLAYERS:FindFirstChild("ALIVE")
    if alive then
        local targets = alive:GetChildren()
        for _, target in ipairs(targets) do
            if target:IsA("Model") and target.Name ~= LocalPlayer.Name then
                local targetHrp = GetHRP(target)
                if targetHrp then
                    SafeTeleport(targetHrp.Position)
                    break
                end
            end
        end
    end
end

function TP_Killer()
    local killerFolder = workspace:FindFirstChild("PLAYERS") and workspace.PLAYERS:FindFirstChild("KILLER")
    if killerFolder then
        local killer = killerFolder:FindFirstChildWhichIsA("Model")
        local targetHrp = GetHRP(killer)
        if targetHrp then
            SafeTeleport(targetHrp.Position)
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
    World = Window:Tab({ Title = "World", Icon = "globe" }),
    Movement = Window:Tab({ Title = "Movement", Icon = "Battery" }),
    ESP = Window:Tab({ Title = "ESP", Icon = "eye" }),
    Teleports = Window:Tab({ Title = "Teleports", Icon = "star" }),
}

Tabs.Main:Section({ Title = "Noclip & Infinity Stamina" })
Tabs.Main:Toggle({
    Title = "Noclip",
    Default = getgenv().Noclip,
    Callback = function(state) getgenv().Noclip = state end
})
Tabs.Main:Toggle({
    Title = "Infinite Stamina",
    Default = getgenv().InfStamina,
    Callback = function(state) getgenv().InfStamina = state end
})

Tabs.World:Section({ Title = "Instant Generator" })
Tabs.World:Toggle({
    Title = "Instant Generator",
    Default = getgenv().InstantGen,
    Callback = function(state) getgenv().InstantGen = state end
})
Tabs.World:Slider({
    Title = "Generator Delay",
    Step = 0.05,
    Value = {Min = 0.1, Max = 2, Default = getgenv().GenDelay},
    Suffix = " seconds",
    Callback = function(value) getgenv().GenDelay = value end
})
Tabs.World:Section({ Title = "FullBright" })
Tabs.World:Toggle({
    Title = "FullBright",
    Default = getgenv().FullBright,
    Callback = function(state)
        getgenv().FullBright = state
        SetFullBright(state)
    end
})

Tabs.Movement:Section({ Title = "Settings" })
Tabs.Movement:Button({
    Title = "Refresh Noclip",
    Callback = function()
        if getgenv().Noclip and LocalPlayer.Character then
            ApplyNoclip()
            WindUI:Notify({ Title = "Sukuna HUB", Content = "Noclip refreshed", Duration = 2 })
        end
    end
})
Tabs.Movement:Button({
    Title = "Destroy UI",
    Callback = function() Window:Destroy() end
})

Tabs.ESP:Section({ Title = "General" })
Tabs.ESP:Toggle({
    Title = "Enable ESP",
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

Tabs.Teleports:Section({ Title = "Teleport to Locations" })
Tabs.Teleports:Button({
    Title = "Teleport to Escape",
    Callback = TP_Escape
})
Tabs.Teleports:Button({
    Title = "Teleport to Nearest Generator (Incomplete)",
    Callback = TP_Generator
})
Tabs.Teleports:Button({
    Title = "Teleport to Nearest Battery",
    Callback = TP_Battery
})
Tabs.Teleports:Button({
    Title = "Teleport to Nearest FuseBox (Missing)",
    Callback = TP_FuseBox
})
Tabs.Teleports:Button({
    Title = "Teleport to Random Alive Player",
    Callback = TP_Player
})
Tabs.Teleports:Button({
    Title = "Teleport to Killer",
    Callback = TP_Killer
})

WindUI:Notify({
    Title = "Sukuna HUB",
    Content = "Loaded successfully",
    Duration = 3
})

print("Sukuna HUB loaded successfully")