local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Config = {
FOV = 200,
AutoShoot = false,
InstaHit = false,
WallCheck = false,
NoRecoil = false,
DrawFOV = false,
ShootDelay = 0.1,
}

local lockedTargetPlayer = nil
local ESPs = {}
local originalTransparencies = {}
local xrayEnabled = false
local aimbotEnabled = false
local aimlockEnabled = false
local aimlockSmoothness = 0.4
local espEnabled = false
local espConnection
local aimlockConnection
local bulletHandler = nil
local originalFire = nil
local autoShootRunning = false

local function is_target_valid(player)
if not player or player == LocalPlayer then return false end
local character = player.Character
if not character then return false end
local humanoid = character:FindFirstChild("Humanoid")
if not humanoid or humanoid.Health <= 0 then return false end
local head = character:FindFirstChild("Head")
if not head then return false end
return true
end

local function in_fov(p)
local pos, vis = Camera:WorldToViewportPoint(p.Position)
if vis then
local distToCenter = (Vector2.new(pos.X, pos.Y) - Camera.ViewportSize/2).Magnitude
return distToCenter <= Config.FOV
end
return false
end

local function is_visible(p)
if not Config.WallCheck then return true end
local r = RaycastParams.new()
r.FilterDescendantsInstances = {LocalPlayer.Character, Camera}
r.FilterType = Enum.RaycastFilterType.Blacklist
local res = workspace:Raycast(Camera.CFrame.Position, (p.Position - Camera.CFrame.Position).Unit * (p.Position - Camera.CFrame.Position).Magnitude, r)
return not res or res.Instance:IsDescendantOf(p.Parent)
end

local function get_best_target()
local best_part = nil
local best_dist = math.huge

for _, player in ipairs(Players:GetPlayers()) do  
    if player == LocalPlayer then continue end  
    local character = player.Character  
    if not character then continue end  
    local head = character:FindFirstChild("Head")  
    local humanoid = character:FindFirstChild("Humanoid")  
    if not head or not humanoid or humanoid.Health <= 0 then continue end  

    if in_fov(head) and is_visible(head) then  
        local screen_pos, on_screen = Camera:WorldToViewportPoint(head.Position)  
        if on_screen then  
            local dist = (Vector2.new(screen_pos.X, screen_pos.Y) - Camera.ViewportSize/2).Magnitude  
            if dist < best_dist then  
                best_part = head  
                best_dist = dist  
            end  
        end  
    end  
end  
return best_part

end

local function applyNoRecoil(module)
if Config.NoRecoil and module and module.Recoil then
module.Recoil = Vector3.new(0,0,0)
end
end

local function setupNoRecoil()
local gunModules = ReplicatedStorage:FindFirstChild("ModuleScripts") and ReplicatedStorage.ModuleScripts:FindFirstChild("GunModules")
if gunModules then
for _, module in ipairs(gunModules:GetChildren()) do
applyNoRecoil(module)
end
gunModules.DescendantAdded:Connect(function(module)
applyNoRecoil(module)
end)
end
end

local function startAutoShoot()
if autoShootRunning then return end
autoShootRunning = true
coroutine.wrap(function()
while Config.AutoShoot and bulletHandler do
local target = get_best_target()
if target then
local force = Config.InstaHit and 10000 or 1000
bulletHandler.Fire({
Origin = Camera.CFrame.Position,
Direction = (target.Position - Camera.CFrame.Position).Unit,
Force = force
})
end
task.wait(Config.ShootDelay)
end
autoShootRunning = false
end)()
end

local function setupAimbot()
local module = ReplicatedStorage:FindFirstChild("ModuleScripts")
if module then
bulletHandler = module:FindFirstChild("GunModules") and module.GunModules:FindFirstChild("BulletHandler")
end
if not bulletHandler then
warn("BulletHandler not found, aimbot may not work")
return
end

originalFire = bulletHandler.Fire  
bulletHandler.Fire = function(data)  
    if aimbotEnabled then  
        local target_head = nil  
        if lockedTargetPlayer and is_target_valid(lockedTargetPlayer) then  
            target_head = lockedTargetPlayer.Character.Head  
        else  
            target_head = get_best_target()  
        end  
        if target_head then  
            data.Force = data.Force * 1000  
            data.Direction = (target_head.Position - data.Origin).Unit  
        end  
    end  
    return originalFire(data)  
end

end

local function restoreAimbot()
if bulletHandler and originalFire then
bulletHandler.Fire = originalFire
end
end

local function find_closest_player_to_screen_center()
local closest_player = nil
local closest_dist = math.huge
local screen_center = Camera.ViewportSize / 2

for _, player in ipairs(Players:GetPlayers()) do  
    if player == LocalPlayer then continue end  
    local character = player.Character  
    if not character then continue end  
    local head = character:FindFirstChild("Head")  
    if not head then continue end  
    local humanoid = character:FindFirstChild("Humanoid")  
    if not humanoid or humanoid.Health <= 0 then continue end  

    if in_fov(head) and is_visible(head) then  
        local screen_pos, on_screen = Camera:WorldToViewportPoint(head.Position)  
        if not on_screen then continue end  
        local distance = (Vector2.new(screen_pos.X, screen_pos.Y) - screen_center).Magnitude  
        if distance < closest_dist then  
            closest_player = player  
            closest_dist = distance  
        end  
    end  
end  
return closest_player

end

local function aimlockLoop()
if not aimlockEnabled then return end

if not is_target_valid(lockedTargetPlayer) then  
    lockedTargetPlayer = find_closest_player_to_screen_center()  
    if lockedTargetPlayer then  
        WindUI:Notify({  
            Title = "Aimlock",  
            Content = "Locked onto: " .. lockedTargetPlayer.Name,  
            Duration = 2  
        })  
    end  
end  

if lockedTargetPlayer and is_target_valid(lockedTargetPlayer) then  
    local targetHead = lockedTargetPlayer.Character.Head  
    if targetHead then  
        local targetCFrame = CFrame.new(Camera.CFrame.Position, targetHead.Position)  
        Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, aimlockSmoothness)  
    end  
end

end

local function createESP(player)
local ESPHolder = {
Box = Drawing.new("Square"),
BoxOutline = Drawing.new("Square"),
HealthBar = Drawing.new("Line"),
HealthBarOutline = Drawing.new("Line")
}

ESPHolder.Box.Thickness = 2  
ESPHolder.Box.Filled = false  
ESPHolder.Box.Color = Color3.fromRGB(255, 0, 0)  
ESPHolder.Box.Visible = false  

ESPHolder.HealthBar.Thickness = 3  
ESPHolder.HealthBar.Color = Color3.fromRGB(0, 255, 0)  
ESPHolder.HealthBar.Visible = false  

ESPs[player] = ESPHolder  
return ESPHolder

end

local function updateESP()
if not espEnabled then
for _, holder in pairs(ESPs) do
holder.Box.Visible = false
holder.HealthBar.Visible = false
end
return
end

for _, player in ipairs(Players:GetPlayers()) do  
    if player == LocalPlayer then continue end  
    local holder = ESPs[player]  
    if not holder then  
        holder = createESP(player)  
    end  

    local character = player.Character  
    if character and character:FindFirstChild("HumanoidRootPart") then  
        local rootPart = character.HumanoidRootPart  
        local head = character:FindFirstChild("Head")  
        local humanoid = character:FindFirstChildOfClass("Humanoid")  

        if rootPart and head and humanoid and humanoid.Health > 0 then  
            local vector, onScreen = Camera:WorldToViewportPoint(rootPart.Position)  
            if onScreen then  
                local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))  
                local legPos = Camera:WorldToViewportPoint(rootPart.Position - Vector3.new(0, 3, 0))  
                local height = math.abs(headPos.Y - legPos.Y)  
                local width = height / 2  

                holder.Box.Size = Vector2.new(width, height)  
                holder.Box.Position = Vector2.new(vector.X - width/2, vector.Y - height/2)  
                holder.Box.Visible = true  

                local healthBarHeight = height * (humanoid.Health / humanoid.MaxHealth)  
                local healthBarX = vector.X - width/2 - 7  
                holder.HealthBar.From = Vector2.new(healthBarX, vector.Y + height/2)  
                holder.HealthBar.To = Vector2.new(healthBarX, vector.Y + height/2 - healthBarHeight)  
                holder.HealthBar.Visible = true  
            else  
                holder.Box.Visible = false  
                holder.HealthBar.Visible = false  
            end  
        else  
            holder.Box.Visible = false  
            holder.HealthBar.Visible = false  
        end  
    else  
        holder.Box.Visible = false  
        holder.HealthBar.Visible = false  
    end  
end

end

local function toggleXRay(state)
if state then
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj:IsA("BasePart") then
originalTransparencies[obj] = obj.Transparency
obj.Transparency = 0.7
end
end
else
for obj, transparency in pairs(originalTransparencies) do
if obj and obj.Parent then
obj.Transparency = transparency
end
end
originalTransparencies = {}
end
end

local fovCircle = nil
local function updateFOVCircle()
if Config.DrawFOV then
if not fovCircle then
fovCircle = Drawing.new("Circle")
fovCircle.Thickness = 2
fovCircle.NumSides = 64
fovCircle.Color = Color3.fromRGB(255, 255, 255)
fovCircle.Filled = false
fovCircle.Visible = true
fovCircle.Radius = Config.FOV
fovCircle.Position = Camera.ViewportSize / 2
else
fovCircle.Radius = Config.FOV
fovCircle.Position = Camera.ViewportSize / 2
fovCircle.Visible = true
end
elseif fovCircle then
fovCircle.Visible = false
end
end

local Window = WindUI:CreateWindow({
Title = "Sukuna HUB",
Icon = "eye",
Author = "Sukuna Hub",
Folder = "SukunaLite",
Size = UDim2.fromScale(0.65, 0.7),
Theme = "Dark",
HasOutline = true,
Resizable = true,
SideBarWidth = 180,
ScrollBarEnabled = true,
})

Window:SetToggleKey(Enum.KeyCode.RightControl)

local Tabs = {
Combat = Window:Tab({ Title = "Combat", Icon = "crosshair" }),
Visuals = Window:Tab({ Title = "Visuals", Icon = "eye" }),
}

Tabs.Combat:Section({ Title = "Aimbot Settings" })
Tabs.Combat:Toggle({
Title = "Enable Aimbot",
Default = false,
Callback = function(state)
aimbotEnabled = state
if state and not bulletHandler then setupAimbot() end
end
})

Tabs.Combat:Section({ Title = "Aimlock Settings" })
Tabs.Combat:Toggle({
Title = "Enable Aimlock",
Default = false,
Callback = function(state)
aimlockEnabled = state
if state then
lockedTargetPlayer = find_closest_player_to_screen_center()
if lockedTargetPlayer then
WindUI:Notify({ Title = "Aimlock", Content = "Locked onto: " .. lockedTargetPlayer.Name, Duration = 2 })
else
WindUI:Notify({ Title = "Aimlock", Content = "No target found", Duration = 2 })
end
if not aimlockConnection then
aimlockConnection = RunService.RenderStepped:Connect(aimlockLoop)
end
else
if aimlockConnection then
aimlockConnection:Disconnect()
aimlockConnection = nil
end
lockedTargetPlayer = nil
end
end
})

Tabs.Combat:Slider({
Title = "Aimlock Smoothness",
Step = 0.05,
Value = { Min = 0.1, Max = 1, Default = 0.4 },
Callback = function(value) aimlockSmoothness = value end
})

Tabs.Combat:Button({
Title = "Select Target (click on player)",
Callback = function()
local mouse = UserInputService:GetMouseLocation()
local closest_player, closest_dist = nil, math.huge
for _, player in ipairs(Players:GetPlayers()) do
if player == LocalPlayer then continue end
local head = player.Character and player.Character:FindFirstChild("Head")
if head then
local screen_pos, on_screen = Camera:WorldToViewportPoint(head.Position)
if on_screen then
local dist = (Vector2.new(screen_pos.X, screen_pos.Y) - mouse).Magnitude
if dist < closest_dist then
closest_player = player
closest_dist = dist
end
end
end
end
if closest_player then
lockedTargetPlayer = closest_player
WindUI:Notify({ Title = "Aimlock", Content = "Manual lock: " .. closest_player.Name, Duration = 3 })
else
WindUI:Notify({ Title = "Aimlock", Content = "No target under cursor", Duration = 2 })
end
end
})

Tabs.Combat:Section({ Title = "FOV" })
Tabs.Combat:Slider({
Title = "FOV Radius (pixels)",
Step = 5,
Value = { Min = 50, Max = 500, Default = 200 },
Callback = function(value) Config.FOV = value; updateFOVCircle() end
})

Tabs.Visuals:Section({ Title = "ESP Settings" })
Tabs.Visuals:Toggle({
Title = "Enable ESP",
Default = false,
Callback = function(state)
espEnabled = state
if state then
if not espConnection then
espConnection = RunService.RenderStepped:Connect(updateESP)
end
else
if espConnection then
espConnection:Disconnect()
espConnection = nil
end
for _, holder in pairs(ESPs) do
holder.Box.Visible = false
holder.HealthBar.Visible = false
end
end
end
})

Tabs.Visuals:Section({ Title = "X-Ray Settings" })
Tabs.Visuals:Toggle({
Title = "Enable X-Ray",
Default = false,
Callback = function(state)
xrayEnabled = state
toggleXRay(state)
end
})

WindUI:Notify({
Title = "Sukuna HUB",
Content = "Loaded successfully!",
Duration = 3
})

print("Sukuna HUB loaded successfully")

Window.OnClose = function()
if espConnection then espConnection:Disconnect() end
if aimlockConnection then aimlockConnection:Disconnect() end
restoreAimbot()
if xrayEnabled then toggleXRay(false) end
for _, holder in pairs(ESPs) do
holder.Box:Remove()
holder.HealthBar:Remove()
end
if fovCircle then fovCircle:Remove() end
end

Camera:GetPropertyChangedSignal("ViewportSize"):Connect(updateFOVCircle)