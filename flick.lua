local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local Options = Library.Options
local Toggles = Library.Toggles

Library.ForceCheckbox = false
Library.ShowToggleFrameInKeybinds = true

pcall(function()
    Library.Scheme.AccentColor = Color3.fromRGB(0, 0, 255)
end)

local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace         = game:GetService("Workspace")
local VirtualUser       = game:GetService("VirtualUser")
local HttpService       = game:GetService("HttpService")

local lp  = Players.LocalPlayer
local cam = Workspace.CurrentCamera

local char = lp.Character
local root = char and char:FindFirstChild("HumanoidRootPart") or nil
local hum  = char and char:FindFirstChildOfClass("Humanoid") or nil

local cfg = {
    -- Base Combat
    Aimbot      = false,
    SmoothAim   = false,
    Smoothness  = 0.4,
    SilentAim   = false,
    FOV         = 150,
    AimPart     = "Head",
    WallCheck   = true,
    ShowFOV     = false,
    FOVColor    = Color3.fromRGB(30, 100, 255),
    FOVThick    = 1,
    
    -- Base Visuals
    ESP         = false,
    Boxes       = false,
    Names       = false,
    HealthBar   = false,
    Distance    = false,
    Skeleton    = false,
    Tracers     = false,
    TracerFrom  = "Bottom",
    Chams       = false,
    ChamsAlpha  = 0.5,
    BoxColor    = Color3.fromRGB(255, 255, 255),
    NameColor   = Color3.fromRGB(255, 255, 255),
    HPColor     = Color3.fromRGB(80, 255, 120),
    TracerColor = Color3.fromRGB(255, 255, 255),
    ChamsColor  = Color3.fromRGB(30, 100, 255),
    AntiAfk     = false,

    -- Merged Visuals (Rise Hub)
    RainbowESP         = false,
    RainbowSpeed       = 5,
    FullBright         = false,
    NoFog              = false,
    
    -- Merged Movement/Player (Rise Hub)
    WalkSpeed          = 16,
    NoVelocity         = false,
    BunnyHop           = false,
    BunnyHopDelay      = 1,
    XRay               = false,
    XRayTransparency   = 0.6,
    AutoRespawn        = false,
    AutoRespawnDelay   = 0,
    
    -- Merged Weapons/Combat Extras (Rise Hub)
    AutoFire           = false,
    AutoFireDelay      = 1.5,
    KnifeClose         = false,
    KnifeRange         = 10,
    ShowKnifeRange     = false,
    RGBGunKnife        = false,
    RGBType            = "Material",
    RGBSpeed           = 10,
    AutoApplySFX       = false,
    HitSFX             = "",
    CritSFX            = "",
    KnifeCratesCount   = 0,
    GunCratesCount     = 0,
}

-- [Variables & State Tracking for New Features]
local originaltransparencies = {}
local originallighting = {
    Brightness = game.Lighting.Brightness,
    Ambient = game.Lighting.Ambient,
    OutdoorAmbient = game.Lighting.OutdoorAmbient,
    FogEnd = game.Lighting.FogEnd,
    FogStart = game.Lighting.FogStart
}
local noVelocityConnection, bunnyHopConnection = nil, nil
local autoRespawnLastFire = 0
local isOpeningCrates = false
local autoFireConnection, isFiring, currentTarget = nil, false, nil
local knifeConnection, lastKnifeState, rangeSphere = nil, nil, nil
local rgbConnection, rgbReapplyConnection, lastGunTool = nil, nil, nil
local autoApplyConnection = nil
local rgbHue, rainbowhue, lastupdate = 0, 0, 0
local inLobby = false

-- Game Specific Remotes (Flick)
local CommandRemote, RollCrate, Sound_Request = nil, nil, nil
local AimWeapon, AimStateChanged, FireWeaponMobile, SwapWeapon = nil, nil, nil, nil
local CheckFire, CheckShot, ProjectileRender, ProjectileFinished = nil, nil, nil, nil

-- Setup Remotes
local function waitForRemote(path, name)
    if not path or not name then return nil end
    while not path:FindFirstChild(name) do task.wait(0.1) end
    return path:FindFirstChild(name)
end

task.spawn(function()
    local signalEvents = ReplicatedStorage:WaitForChild("SignalManager", 10)
    if signalEvents then 
        signalEvents = signalEvents:WaitForChild("SignalEvents", 10)
        if signalEvents then
            AimWeapon = waitForRemote(signalEvents, "AimWeapon")
            AimStateChanged = waitForRemote(signalEvents, "AimStateChanged")
            FireWeaponMobile = waitForRemote(signalEvents, "FireWeaponMoblie")
            SwapWeapon = waitForRemote(signalEvents, "SwapWeapon")
        end
    end

    local remotes = ReplicatedStorage:WaitForChild("Remotes", 10)
    if remotes then
        CommandRemote = waitForRemote(remotes, "Command")
        RollCrate = waitForRemote(remotes, "RollCrate")
    end

    local soundModule = ReplicatedStorage:FindFirstChild("SoundModule")
    if soundModule then Sound_Request = waitForRemote(soundModule, "Sound_RequestFromServer_C2S") end

    local clientRemotes = lp:FindFirstChild("ClientRemotes")
    if clientRemotes then
        CheckFire = waitForRemote(clientRemotes, "CheckFire")
        CheckShot = waitForRemote(clientRemotes, "CheckShot")
    end

    local gunModules = ReplicatedStorage:FindFirstChild("ModuleScripts")
    if gunModules and gunModules:FindFirstChild("GunModules") and gunModules.GunModules:FindFirstChild("Remote") then
        ProjectileRender = waitForRemote(gunModules.GunModules.Remote, "ProjectileRender")
        ProjectileFinished = waitForRemote(gunModules.GunModules.Remote, "ProjectileFinished")
    end
end)

local function checkLobbyStatus()
    local team = lp.Team
    inLobby = team and (team.Name == "Lobby") or false
end
lp:GetPropertyChangedSignal("Team"):Connect(checkLobbyStatus)
checkLobbyStatus()

local function getrainbowcolor()
    local currenttime = tick()
    local speedmultiplier = 11 - cfg.RainbowSpeed
    local increment = 0.001 * speedmultiplier
    if currenttime - lastupdate >= 0.1 then
        rainbowhue = (rainbowhue + increment) % 1
        lastupdate = currenttime
    end
    return Color3.fromHSV(rainbowhue, 1, 1)
end

-- Base Utility Functions
local function alive(plr)
    if not plr or not plr.Character then return false end
    local h = plr.Character:FindFirstChildOfClass("Humanoid")
    return h ~= nil and h.Health > 0
end

local function getAimPart(plr)
    if not plr or not plr.Character then return nil end
    return plr.Character:FindFirstChild(cfg.AimPart) or plr.Character:FindFirstChild("HumanoidRootPart")
end

local function getClosestPlayerToCursor()
    local closestPlayer = nil
    local shortestDist  = cfg.ShowFOV and cfg.FOV or math.huge
    local mousePos      = UserInputService:GetMouseLocation()

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= lp and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local humanoid = player.Character:FindFirstChild("Humanoid")
            if humanoid and humanoid.Health > 0 then
                local targetPart = getAimPart(player)
                if targetPart then
                    local screenPos, onScreen = cam:WorldToViewportPoint(targetPart.Position)
                    if onScreen then
                        local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                        if cfg.WallCheck then
                            local ray = Ray.new(cam.CFrame.Position, (targetPart.Position - cam.CFrame.Position).Unit * 1000)
                            local hit = Workspace:FindPartOnRayWithIgnoreList(ray, {lp.Character})
                            if hit and hit:IsDescendantOf(player.Character) then
                                if dist < shortestDist then
                                    closestPlayer = player
                                    shortestDist  = dist
                                end
                            end
                        else
                            if dist < shortestDist then
                                closestPlayer = player
                                shortestDist  = dist
                            end
                        end
                    end
                end
            end
        end
    end
    return closestPlayer
end

local function doAimlock()
    if not cfg.Aimbot then return end
    local target = getClosestPlayerToCursor()
    if target and target.Character then
        local targetPart = getAimPart(target)
        if targetPart then
            local aimPos = targetPart.Position
            local camPos = cam.CFrame.Position
            local dir    = (aimPos - camPos).Unit
            if cfg.SmoothAim then
                local targetCF = CFrame.new(camPos, camPos + dir)
                cam.CFrame = cam.CFrame:Lerp(targetCF, cfg.Smoothness)
            else
                cam.CFrame = CFrame.new(camPos, camPos + dir)
            end
        end
    end
end

-- Auto-Fire Feature
local aiming = false
local function startAim(head)
    if aiming then return end
    if AimStateChanged then AimStateChanged:Fire(true) end
    if AimWeapon then AimWeapon:Fire(Enum.UserInputState.Begin) end
    cam.CFrame = CFrame.new(cam.CFrame.Position, head.Position)
    aiming = true
end
local function stopAim()
    if not aiming then return end
    if AimStateChanged then AimStateChanged:Fire(false) end
    if AimWeapon then AimWeapon:Fire(Enum.UserInputState.End) end
    aiming = false
end

local function fireOnce(head)
    if isFiring then return end
    isFiring = true
    local ts = os.clock()
    local muz = (lp.Character and lp.Character:FindFirstChild("Torso") and lp.Character.Torso.Position) or cam.CFrame.Position
    local hit = head.Position
    local dir = (hit - muz).Unit
    local vel = dir * 800

    if Sound_Request then Sound_Request:FireServer(lp.Character and lp.Character:FindFirstChild("Torso") or cam, "rbxassetid://3821795742") end
    if CheckFire then CheckFire:FireServer(ts, hit) end
    local cf = CFrame.lookAt(hit, muz)
    if CheckShot then CheckShot:FireServer(0,0,1,0.8, cf, muz, head, 6310, ts) end
    if ProjectileRender then ProjectileRender:FireServer(ts, lp.Character, muz, vel, 130, 1, Vector3.zero, 5, "Bullet") end
    if FireWeaponMobile then
        FireWeaponMobile:Fire(Enum.UserInputState.Begin)
        task.wait(0.1)
        FireWeaponMobile:Fire(Enum.UserInputState.End)
    end
    task.delay(0.1, function()
        if ProjectileFinished then ProjectileFinished:FireServer(ts, head.CFrame, "Gib_T", false, 15, "rbxassetid://2814354338") end
    end)
    task.delay(cfg.AutoFireDelay, function() isFiring = false end)
end

local function toggleAutoFire()
    if cfg.AutoFire then
        currentTarget = nil
        isFiring = false
        autoFireConnection = RunService.Heartbeat:Connect(function()
            if not cfg.AutoFire or inLobby then 
                if currentTarget then stopAim() currentTarget = nil end
                return 
            end
            local localHRP = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
            if not localHRP then return end
            
            local targetplayer = getClosestPlayerToCursor()
            if not targetplayer or not targetplayer.Character then
                if currentTarget then stopAim() currentTarget = nil end
                return
            end
            
            local head = targetplayer.Character:FindFirstChild("Head")
            local humTarget = targetplayer.Character:FindFirstChild("Humanoid")
            if not head or not humTarget or humTarget.Health <= 0 then
                if currentTarget then stopAim() currentTarget = nil end
                return
            end

            local origin = localHRP.Parent:FindFirstChild("Head") and localHRP.Parent.Head.Position or localHRP.Position
            local ray = Ray.new(origin, (head.Position - origin).Unit * 1000)
            local hit = Workspace:FindPartOnRayWithIgnoreList(ray, {lp.Character})
            if hit and not hit:IsDescendantOf(targetplayer.Character) then
                if currentTarget then stopAim() currentTarget = nil end
                return
            end

            if targetplayer ~= currentTarget then
                currentTarget = targetplayer
                startAim(head)
            end
            if not isFiring then fireOnce(head) end
        end)
    else
        if autoFireConnection then autoFireConnection:Disconnect() autoFireConnection = nil end
        currentTarget = nil
        isFiring = false
        stopAim()
    end
end

-- Anti AFK
local afkConn = nil
local function setAntiAfk(state)
    if afkConn then afkConn:Disconnect() afkConn = nil end
    if not state then return end
    afkConn = lp.Idled:Connect(function()
        VirtualUser:Button2Down(Vector2.new(0, 0), CFrame.new())
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0, 0), CFrame.new())
    end)
end

-- Player & Movement Features
local function toggleNoVelocity()
    if cfg.NoVelocity then
        noVelocityConnection = RunService.Heartbeat:Connect(function()
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= lp and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = player.Character.HumanoidRootPart
                    hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                end
            end
        end)
    else
        if noVelocityConnection then noVelocityConnection:Disconnect() noVelocityConnection = nil end
    end
end

local function toggleBunnyHop()
    if cfg.BunnyHop then
        bunnyHopConnection = RunService.Heartbeat:Connect(function()
            local cr = lp.Character
            if cr and cr:FindFirstChild("Humanoid") then
                local h = cr.Humanoid
                if h:GetState() == Enum.HumanoidStateType.Running and h.FloorMaterial ~= Enum.Material.Air then
                    h:ChangeState(Enum.HumanoidStateType.Jumping)
                    task.wait(cfg.BunnyHopDelay)
                end
            end
        end)
    else
        if bunnyHopConnection then bunnyHopConnection:Disconnect() bunnyHopConnection = nil end
    end
end

local function updateXRay()
    if cfg.XRay then
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj:IsA("BasePart") and not obj:IsDescendantOf(lp.Character) then
                if not originaltransparencies[obj] then originaltransparencies[obj] = obj.Transparency end
                obj.Transparency = cfg.XRayTransparency
            end
        end
    else
        for obj, t in pairs(originaltransparencies) do
            if obj and obj.Parent then obj.Transparency = t end
        end
        originaltransparencies = {}
    end
end

task.spawn(function()
    while true do
        task.wait()
        -- Walkspeed
        if cfg.WalkSpeed > 16 and lp.Character and lp.Character:FindFirstChild("Humanoid") then
            lp.Character.Humanoid.WalkSpeed = cfg.WalkSpeed
        end
        -- Auto Respawn
        if cfg.AutoRespawn and not inLobby then
            if not Workspace:FindFirstChild(lp.Name) and (tick() - autoRespawnLastFire >= 1) then
                if CommandRemote then CommandRemote:FireServer("Play") end
                autoRespawnLastFire = tick()
            end
        end
        -- Lighting Updates
        if cfg.FullBright then
            game.Lighting.Brightness = 2
            game.Lighting.Ambient = Color3.fromRGB(255, 255, 255)
            game.Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        else
            game.Lighting.Brightness = originallighting.Brightness
            game.Lighting.Ambient = originallighting.Ambient
            game.Lighting.OutdoorAmbient = originallighting.OutdoorAmbient
        end
        
        if cfg.NoFog then
            game.Lighting.FogEnd = 100000
            game.Lighting.FogStart = 0
        else
            game.Lighting.FogEnd = originallighting.FogEnd
            game.Lighting.FogStart = originallighting.FogStart
        end
    end
end)

-- Weapon Features
local function updateKnifeRangeSphere()
    if not lp.Character or not lp.Character:FindFirstChild("HumanoidRootPart") then
        if rangeSphere then rangeSphere.Transparency = 1 end
        return
    end
    local rt = lp.Character.HumanoidRootPart
    if cfg.ShowKnifeRange then
        if not rangeSphere then
            rangeSphere = Instance.new("Part")
            rangeSphere.Name = "KnifeRangeSphere"
            rangeSphere.Shape = Enum.PartType.Ball
            rangeSphere.Material = Enum.Material.ForceField
            rangeSphere.CanCollide = false
            rangeSphere.Anchored = true
            rangeSphere.CastShadow = false
            rangeSphere.Parent = Workspace
        end
        rangeSphere.Size = Vector3.new(cfg.KnifeRange * 2, cfg.KnifeRange * 2, cfg.KnifeRange * 2)
        rangeSphere.CFrame = rt.CFrame
        rangeSphere.Color = Color3.fromRGB(255, 0, 0)
        rangeSphere.Transparency = 0.5
    else
        if rangeSphere then rangeSphere:Destroy() rangeSphere = nil end
    end
end

local function anyEnemyInRange()
    local rt = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
    if not rt then return false end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= lp and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (rt.Position - plr.Character.HumanoidRootPart.Position).Magnitude
            if dist <= cfg.KnifeRange then return true end
        end
    end
    return false
end

local function toggleKnifeSwitch()
    if cfg.KnifeClose then
        knifeConnection = RunService.Heartbeat:Connect(function()
            local inRange = anyEnemyInRange()
            if lastKnifeState == nil or lastKnifeState ~= inRange then
                if SwapWeapon then SwapWeapon:Fire() end
                lastKnifeState = inRange
            end
        end)
    else
        if knifeConnection then knifeConnection:Disconnect() knifeConnection = nil end
        lastKnifeState = nil
    end
end

local function applyRGBToGun(toolModel, hue)
    if not toolModel then return end
    local faces = Enum.NormalId:GetEnumItems()
    for _, part in ipairs(toolModel:GetDescendants()) do
        if part:IsA("UnionOperation") or part:IsA("BasePart") then
            part.Material = Enum.Material.Neon
            part.Color = Color3.fromHSV(hue, 1, 1)
            part.UsePartColor = true
            local light = part:FindFirstChildOfClass("SpotLight") or Instance.new("SpotLight")
            light.Color = Color3.fromHSV(hue, 1, 1)
            light.Range = 18
            light.Brightness = 5
            light.Face = faces[math.random(1, #faces)]
            light.Angle = 90
            light.Parent = part
        end
    end
end

local function applyHighlightToTool(tool, hue)
    if not tool or not cfg.RGBGunKnife or cfg.RGBType ~= "Highlight" then return end
    local highlight = tool:FindFirstChild("RGBHighlight") or Instance.new("Highlight")
    highlight.Name = "RGBHighlight"
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.FillColor = Color3.fromHSV(hue, 1, 1)
    highlight.OutlineColor = Color3.fromHSV(hue, 1, 1)
    highlight.Adornee = tool
    highlight.Parent = tool
end

local function toggleRGBGunKnife()
    if cfg.RGBGunKnife then
        local localTool = lp.Character and lp.Character:FindFirstChildWhichIsA("Tool")
        if localTool then lastGunTool = localTool end
        rgbConnection = RunService.Heartbeat:Connect(function()
            rgbHue = (rgbHue + (cfg.RGBSpeed / 5000)) % 1
            if lp.Character then
                for _, tool in ipairs(lp.Character:GetChildren()) do
                    if tool:IsA("Tool") then
                        if cfg.RGBType == "Material" then
                            for _, model in ipairs(tool:GetChildren()) do
                                if model:IsA("Model") then applyRGBToGun(model, rgbHue) end
                            end
                        elseif cfg.RGBType == "Highlight" then
                            applyHighlightToTool(tool, rgbHue)
                        end
                    end
                end
            end
        end)
        rgbReapplyConnection = RunService.Heartbeat:Connect(function()
            task.wait(1)
            if lastGunTool and lastGunTool.Parent then
                if cfg.RGBType == "Material" then
                    for _, model in ipairs(lastGunTool:GetChildren()) do
                        if model:IsA("Model") then applyRGBToGun(model, rgbHue) end
                    end
                elseif cfg.RGBType == "Highlight" then
                    applyHighlightToTool(lastGunTool, rgbHue)
                end
            end
        end)
    else
        if rgbConnection then rgbConnection:Disconnect() rgbConnection = nil end
        if rgbReapplyConnection then rgbReapplyConnection:Disconnect() rgbReapplyConnection = nil end
        if lastGunTool then
            for _, model in ipairs(lastGunTool:GetDescendants()) do
                if model:IsA("BasePart") or model:IsA("UnionOperation") then
                    local light = model:FindFirstChildOfClass("SpotLight")
                    if light then light:Destroy() end
                end
            end
            local highlight = lastGunTool:FindFirstChild("RGBHighlight")
            if highlight then highlight:Destroy() end
        end
    end
end

local function applyCustomSFX()
    local playerGui = lp:FindFirstChild("PlayerGui")
    if not playerGui then return end
    local effect = playerGui:FindFirstChild("Effect")
    if not effect then return end
    local hitSound = effect:FindFirstChild("Bang")
    local critSound = effect:FindFirstChild("Crit")
    if hitSound and cfg.HitSFX ~= "" then hitSound.SoundId = "rbxassetid://" .. cfg.HitSFX end
    if critSound and cfg.CritSFX ~= "" then critSound.SoundId = "rbxassetid://" .. cfg.CritSFX end
end

local function toggleAutoApplySFX()
    if cfg.AutoApplySFX then
        autoApplyConnection = RunService.Heartbeat:Connect(function()
            task.wait(1)
            applyCustomSFX()
        end)
    else
        if autoApplyConnection then autoApplyConnection:Disconnect() autoApplyConnection = nil end
    end
end

local function openCrates(crateType, count)
    if isOpeningCrates then return end
    isOpeningCrates = true
    task.spawn(function()
        for i = 1, count do
            if RollCrate then RollCrate:FireServer(crateType) end
            task.wait(0.1)
        end
        isOpeningCrates = false
    end)
end

-- ESP Rendering
local espStore   = {}
local chamsStore = {}

local skeleMap = {
    {"Head","UpperTorso"}, {"UpperTorso","LowerTorso"}, {"LowerTorso","LeftUpperLeg"},
    {"LowerTorso","RightUpperLeg"}, {"LeftUpperLeg","LeftLowerLeg"}, {"RightUpperLeg","RightLowerLeg"},
    {"LeftLowerLeg","LeftFoot"}, {"RightLowerLeg","RightFoot"}, {"UpperTorso","LeftUpperArm"},
    {"UpperTorso","RightUpperArm"}, {"LeftUpperArm","LeftLowerArm"}, {"RightUpperArm","RightLowerArm"},
    {"LeftLowerArm","LeftHand"}, {"RightLowerArm","RightHand"},
}

local function buildESP(plr)
    local d = {}
    local outline = Drawing.new("Square")
    outline.Visible   = false
    outline.Thickness = 3
    outline.Filled    = false
    outline.Color     = Color3.new(0, 0, 0)
    local box         = Drawing.new("Square")
    box.Visible       = false
    box.Thickness     = 1
    box.Filled        = false
    box.Color         = cfg.BoxColor
    local nameTag     = Drawing.new("Text")
    nameTag.Visible   = false
    nameTag.Size      = 13
    nameTag.Center    = true
    nameTag.Outline   = true
    nameTag.Color     = cfg.NameColor
    nameTag.Text      = plr.Name
    local hpBg        = Drawing.new("Square")
    hpBg.Visible      = false
    hpBg.Filled       = true
    hpBg.Color        = Color3.new(0, 0, 0)
    hpBg.Thickness    = 1
    local hpFill      = Drawing.new("Square")
    hpFill.Visible    = false
    hpFill.Filled     = true
    hpFill.Color      = cfg.HPColor
    hpFill.Thickness  = 1
    local distTag     = Drawing.new("Text")
    distTag.Visible   = false
    distTag.Size      = 12
    distTag.Center    = true
    distTag.Outline   = true
    distTag.Color     = cfg.NameColor
    local tracer      = Drawing.new("Line")
    tracer.Visible    = false
    tracer.Thickness  = 1
    tracer.Color      = cfg.TracerColor
    local bones = {}
    for _ = 1, #skeleMap do
        local ln     = Drawing.new("Line")
        ln.Visible   = false
        ln.Thickness = 1
        ln.Color     = Color3.new(1, 1, 1)
        table.insert(bones, ln)
    end
    d.outline = outline
    d.box     = box
    d.nameTag = nameTag
    d.hpBg    = hpBg
    d.hpFill  = hpFill
    d.distTag = distTag
    d.tracer  = tracer
    d.bones   = bones
    return d
end

local function wipeESP(d)
    if not d then return end
    for k, obj in pairs(d) do
        if k ~= "bones" then pcall(function() obj:Remove() end) end
    end
    if d.bones then
        for _, ln in ipairs(d.bones) do pcall(function() ln:Remove() end) end
    end
end

local function hideESP(d)
    if not d then return end
    for k, obj in pairs(d) do
        if k ~= "bones" then pcall(function() obj.Visible = false end) end
    end
    if d.bones then
        for _, ln in ipairs(d.bones) do pcall(function() ln.Visible = false end) end
    end
end

local function screenBounds(plr)
    if not plr.Character then return nil end
    local r = plr.Character:FindFirstChild("HumanoidRootPart")
    if not r then return nil end
    local halfX, halfY, halfZ = r.Size.X * 1.3 / 2, r.Size.Y * 3.4 / 2, r.Size.Z * 1.3 / 2
    local offsets = {
        Vector3.new(-halfX,-halfY,-halfZ), Vector3.new(halfX,-halfY,-halfZ),
        Vector3.new(-halfX, halfY,-halfZ), Vector3.new(halfX, halfY,-halfZ),
        Vector3.new(-halfX,-halfY, halfZ), Vector3.new(halfX,-halfY, halfZ),
        Vector3.new(-halfX, halfY, halfZ), Vector3.new(halfX, halfY, halfZ),
    }
    local mnX, mnY, mxX, mxY = math.huge, math.huge, -math.huge, -math.huge
    local anyVis = false
    for _, off in ipairs(offsets) do
        local wp = r.CFrame:PointToWorldSpace(off)
        local sp, on = cam:WorldToViewportPoint(wp)
        if on then anyVis = true end
        if sp.X < mnX then mnX = sp.X end
        if sp.Y < mnY then mnY = sp.Y end
        if sp.X > mxX then mxX = sp.X end
        if sp.Y > mxY then mxY = sp.Y end
    end
    if not anyVis then return nil end
    local sp2, vis2 = cam:WorldToViewportPoint(r.Position)
    if not vis2 then return nil end
    return { min = Vector2.new(mnX, mnY), max = Vector2.new(mxX, mxY), ctr = Vector2.new(sp2.X, sp2.Y) }
end

local function w2s(part)
    if not part then return nil, false end
    local sp, on = cam:WorldToViewportPoint(part.Position)
    return Vector2.new(sp.X, sp.Y), on
end

local function drawSkeleton(plr, d)
    if not d.bones then return end
    local c = cfg.RainbowESP and getrainbowcolor() or cfg.BoxColor
    for i, pair in ipairs(skeleMap) do
        local ln = d.bones[i]
        local pA = plr.Character and plr.Character:FindFirstChild(pair[1])
        local pB = plr.Character and plr.Character:FindFirstChild(pair[2])
        if pA and pB and cfg.Skeleton and cfg.ESP then
            local sA, onA = w2s(pA)
            local sB, onB = w2s(pB)
            if onA and onB then
                ln.Visible = true
                ln.From    = sA
                ln.To      = sB
                ln.Color   = c
            else
                ln.Visible = false
            end
        else
            ln.Visible = false
        end
    end
end

local function renderESP(plr)
    local d = espStore[plr]
    if not d then return end
    if not cfg.ESP or not alive(plr) then
        hideESP(d)
        return
    end
    local bounds = screenBounds(plr)
    if not bounds then hideESP(d) return end
    
    local mn, mx, ctr = bounds.min, bounds.max, bounds.ctr
    local bW, bH = mx.X - mn.X, mx.Y - mn.Y
    
    local dynColor = cfg.RainbowESP and getrainbowcolor() or cfg.BoxColor
    local dynNameColor = cfg.RainbowESP and dynColor or cfg.NameColor
    local dynTracerColor = cfg.RainbowESP and dynColor or cfg.TracerColor

    d.outline.Visible = cfg.Boxes
    d.box.Visible     = cfg.Boxes
    if cfg.Boxes then
        d.outline.Position = Vector2.new(mn.X - 1, mn.Y - 1)
        d.outline.Size     = Vector2.new(bW + 2, bH + 2)
        d.box.Color        = dynColor
        d.box.Position     = mn
        d.box.Size         = Vector2.new(bW, bH)
    end
    
    d.nameTag.Visible = cfg.Names
    if cfg.Names then
        d.nameTag.Color    = dynNameColor
        d.nameTag.Text     = plr.Name
        d.nameTag.Position = Vector2.new(ctr.X, mn.Y - 16)
    end
    
    d.hpBg.Visible   = cfg.HealthBar
    d.hpFill.Visible = cfg.HealthBar
    if cfg.HealthBar then
        local ph = plr.Character:FindFirstChildOfClass("Humanoid")
        if ph then
            local pct  = math.clamp(ph.Health / ph.MaxHealth, 0, 1)
            local barH = bH * pct
            d.hpBg.Position   = Vector2.new(mn.X - 5, mn.Y)
            d.hpBg.Size       = Vector2.new(3, bH)
            d.hpFill.Color    = cfg.HPColor
            d.hpFill.Position = Vector2.new(mn.X - 5, mn.Y + (bH - barH))
            d.hpFill.Size     = Vector2.new(3, barH)
        end
    end
    
    d.distTag.Visible = cfg.Distance
    if cfg.Distance and root then
        local r = plr.Character:FindFirstChild("HumanoidRootPart")
        if r then
            d.distTag.Color    = dynNameColor
            d.distTag.Text     = math.floor((r.Position - root.Position).Magnitude) .. "m"
            d.distTag.Position = Vector2.new(ctr.X, mx.Y + 2)
        end
    end
    
    d.tracer.Visible = cfg.Tracers
    if cfg.Tracers then
        local vp = cam.ViewportSize
        local fromX, fromY = vp.X / 2, vp.Y
        if cfg.TracerFrom == "Center" then fromY = vp.Y / 2 end
        if cfg.TracerFrom == "Top"    then fromY = 0        end
        d.tracer.Color = dynTracerColor
        d.tracer.From  = Vector2.new(fromX, fromY)
        d.tracer.To    = Vector2.new(ctr.X, mx.Y)
    end
    
    drawSkeleton(plr, d)
end

local function applyChams(plr)
    if chamsStore[plr] then
        for _, obj in ipairs(chamsStore[plr]) do pcall(function() obj:Destroy() end) end
        chamsStore[plr] = nil
    end
    if not cfg.Chams or not plr.Character then return end
    chamsStore[plr] = {}
    local dynChamsColor = cfg.RainbowESP and getrainbowcolor() or cfg.ChamsColor
    for _, part in ipairs(plr.Character:GetDescendants()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            local sel = Instance.new("SelectionBox")
            sel.Adornee = part
            sel.Color3 = dynChamsColor
            sel.LineThickness = 0
            sel.SurfaceTransparency = cfg.ChamsAlpha
            sel.SurfaceColor3 = dynChamsColor
            sel.Parent = part
            table.insert(chamsStore[plr], sel)
        end
    end
end

local function dropChams(plr)
    if not chamsStore[plr] then return end
    for _, obj in ipairs(chamsStore[plr]) do pcall(function() obj:Destroy() end) end
    chamsStore[plr] = nil
end

local function refreshChams()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= lp then
            if cfg.Chams then applyChams(plr) else dropChams(plr) end
        end
    end
end

-- ======================= GUI INITIALIZATION =======================

local Window = Library:CreateWindow({
    Title            = "",
    Footer           = "Hook Hub",
    Icon             = "rbxassetid://1000232242",
    IconSize         = UDim2.fromOffset(70, 65),
    ShowCustomCursor = true,
    AutoShow         = true,
    Center           = false,
    NotifySide       = "Right",
    CornerRadius     = 30,
})

local Tabs = {
    Combat   = Window:AddTab("Combat", "crosshair"),
    Weapons  = Window:AddTab("Weapons", "swords"), 
    Visual   = Window:AddTab("Visual", "eye"),
    Movement = Window:AddTab("Player", "walk"), 
    Misc     = Window:AddTab("Settings", "settings"),
    Credits  = Window:AddTab("Credits", "info"),
}

-- [COMBAT TAB]
local combatL = Tabs.Combat:AddLeftGroupbox("Aimbot")
local combatR = Tabs.Combat:AddRightGroupbox("Settings")

combatL:AddToggle("AimbotOn", { Text = "Aimbot", Default = false, Callback = function(v) cfg.Aimbot = v end })
combatL:AddToggle("SmoothAimOn", { Text = "Smooth Aim", Default = false, Callback = function(v) cfg.SmoothAim = v end })
combatL:AddToggle("SilentOn", { Text = "Silent Aim", Default = false, Callback = function(v) cfg.SilentAim = v end })
combatL:AddToggle("WallCheckToggle", { Text = "Wall Check", Default = true, Callback = function(v) cfg.WallCheck = v end })
combatL:AddDivider()
combatL:AddToggle("ShowFOVToggle", { Text = "FOV Circle", Default = false, Callback = function(v) cfg.ShowFOV = v end })
combatL:AddLabel("FOV Color"):AddColorPicker("FOVClr", { Default = Color3.fromRGB(30, 100, 255), Title = "FOV Color", Callback = function(v) cfg.FOVColor = v end })
combatL:AddSlider("FOVThickSlider", { Text = "FOV Thickness", Default = 1, Min = 1, Max = 5, Rounding = 0, Callback = function(v) cfg.FOVThick = v end })

combatR:AddSlider("FOVSize", { Text = "FOV Size", Default = 150, Min = 10, Max = 500, Rounding = 0, Callback = function(v) cfg.FOV = v end })
combatR:AddSlider("SmoothSlider", { Text = "Smoothness", Default = 40, Min = 1, Max = 100, Rounding = 0, Suffix = "%", Callback = function(v) cfg.Smoothness = v / 100 end })
combatR:AddDropdown("AimPartDrop", { Text = "Aim Part", Default = "Head", Values = {"Head", "HumanoidRootPart", "UpperTorso", "Torso"}, Callback = function(v) cfg.AimPart = v end })
combatR:AddDivider()
combatR:AddLabel("Aimbot Key"):AddKeyPicker("AimbotKey", { Default = "MB2", Mode = "Hold", NoUI = false, Text = "Aimbot Key", Callback = function() end })

-- [WEAPONS TAB]
local wpLeft = Tabs.Weapons:AddLeftGroupbox("Auto Functions")
local wpRight = Tabs.Weapons:AddRightGroupbox("Skins & SFX")

wpLeft:AddToggle("AutoFireOn", { Text = "Auto-Fire (Risky)", Default = false, Callback = function(v) cfg.AutoFire = v toggleAutoFire() end })
wpLeft:AddSlider("AutoFireDelayS", { Text = "Auto-Fire Delay", Default = 1.5, Min = 0.5, Max = 5, Rounding = 1, Suffix = "s", Callback = function(v) cfg.AutoFireDelay = v end })
wpLeft:AddDivider()
wpLeft:AddToggle("KnifeSwitchOn", { Text = "Auto Knife Switch", Default = false, Callback = function(v) cfg.KnifeClose = v toggleKnifeSwitch() end })
wpLeft:AddSlider("KnifeRangeS", { Text = "Knife Range", Default = 10, Min = 1, Max = 50, Rounding = 0, Callback = function(v) cfg.KnifeRange = v updateKnifeRangeSphere() end })
wpLeft:AddToggle("ShowKnifeRangeOn", { Text = "Show Knife Range", Default = false, Callback = function(v) cfg.ShowKnifeRange = v updateKnifeRangeSphere() end })
wpLeft:AddDivider()
wpLeft:AddSlider("KCrateS", { Text = "Knife Crates Amount", Default = 0, Min = 0, Max = 25, Rounding = 0, Callback = function(v) cfg.KnifeCratesCount = v end })
wpLeft:AddButton({ Text = "Open Knife Crates", Func = function() openCrates("KnifeCrate", cfg.KnifeCratesCount) end })
wpLeft:AddSlider("GCrateS", { Text = "Gun Crates Amount", Default = 0, Min = 0, Max = 15, Rounding = 0, Callback = function(v) cfg.GunCratesCount = v end })
wpLeft:AddButton({ Text = "Open Gun Crates", Func = function() openCrates("GunCrate", cfg.GunCratesCount) end })

wpRight:AddToggle("RGBWeaponsOn", { Text = "RGB Gun/Knife Skins", Default = false, Callback = function(v) cfg.RGBGunKnife = v toggleRGBGunKnife() end })
wpRight:AddDropdown("RGBTypeDrop", { Text = "RGB Type", Default = "Material", Values = {"Material", "Highlight"}, Callback = function(v) cfg.RGBType = v end })
wpRight:AddSlider("RGBSpeedS", { Text = "RGB Speed", Default = 10, Min = 1, Max = 50, Rounding = 0, Callback = function(v) cfg.RGBSpeed = v end })
wpRight:AddDivider()
wpRight:AddToggle("AutoSFXOn", { Text = "Custom SFX", Default = false, Callback = function(v) cfg.AutoApplySFX = v toggleAutoApplySFX() end })
wpRight:AddInput("HitSFXIn", { Default = "", Numeric = false, Finished = false, Text = "Hit SFX ID", Placeholder = "rbxassetid://...", Callback = function(v) cfg.HitSFX = v:gsub("rbxassetid://", "") end })
wpRight:AddInput("CritSFXIn", { Default = "", Numeric = false, Finished = false, Text = "Crit SFX ID", Placeholder = "rbxassetid://...", Callback = function(v) cfg.CritSFX = v:gsub("rbxassetid://", "") end })

-- [VISUAL TAB]
local espL = Tabs.Visual:AddLeftGroupbox("ESP Features")
local espR = Tabs.Visual:AddRightGroupbox("ESP Configs")
local wrld = Tabs.Visual:AddLeftGroupbox("World")

espL:AddToggle("ESPOn", { Text = "ESP Master", Default = false, Callback = function(v) 
    cfg.ESP = v
    if not v then
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= lp and espStore[plr] then hideESP(espStore[plr]) end
        end
    end
end})
espL:AddDivider()
espL:AddToggle("BoxesOn", { Text = "Boxes", Default = false, Callback = function(v) cfg.Boxes = v end })
espL:AddToggle("NamesOn", { Text = "Names", Default = false, Callback = function(v) cfg.Names = v end })
espL:AddToggle("HPOn", { Text = "Health Bars", Default = false, Callback = function(v) cfg.HealthBar = v end })
espL:AddToggle("DistOn", { Text = "Distance", Default = false, Callback = function(v) cfg.Distance = v end })
espL:AddToggle("SkelOn", { Text = "Skeleton", Default = false, Callback = function(v) cfg.Skeleton = v end })
espL:AddDivider()
espL:AddToggle("TracersOn", { Text = "Tracers", Default = false, Callback = function(v) cfg.Tracers = v end })
espL:AddDropdown("TracerOrigin", { Text = "Tracer Origin", Default = "Bottom", Values = {"Bottom", "Center", "Top"}, Callback = function(v) cfg.TracerFrom = v end })
espL:AddDivider()
espL:AddToggle("ChamsOn", { Text = "Chams", Default = false, Callback = function(v) cfg.Chams = v refreshChams() end })
espL:AddSlider("ChamsAlphaSlider", { Text = "Chams Transparency", Default = 50, Min = 0, Max = 100, Rounding = 0, Callback = function(v) cfg.ChamsAlpha = v / 100 refreshChams() end })

espR:AddToggle("RainbowESPOn", { Text = "Rainbow ESP Colors", Default = false, Callback = function(v) cfg.RainbowESP = v end })
espR:AddSlider("RainbowSpdS", { Text = "Rainbow Speed", Default = 5, Min = 1, Max = 10, Rounding = 0, Callback = function(v) cfg.RainbowSpeed = v end })
espR:AddDivider()
espR:AddLabel("Box Color"):AddColorPicker("BoxClr", { Default = Color3.fromRGB(255, 255, 255), Title = "Box Color", Callback = function(v) cfg.BoxColor = v for _, plr in ipairs(Players:GetPlayers()) do if espStore[plr] then espStore[plr].box.Color = v end end end })
espR:AddLabel("Name Color"):AddColorPicker("NameClr", { Default = Color3.fromRGB(255, 255, 255), Title = "Name Color", Callback = function(v) cfg.NameColor = v for _, plr in ipairs(Players:GetPlayers()) do if espStore[plr] then espStore[plr].nameTag.Color = v espStore[plr].distTag.Color = v end end end })
espR:AddLabel("Health Color"):AddColorPicker("HPClr", { Default = Color3.fromRGB(80, 255, 120), Title = "Health Color", Callback = function(v) cfg.HPColor = v for _, plr in ipairs(Players:GetPlayers()) do if espStore[plr] then espStore[plr].hpFill.Color = v end end end })
espR:AddLabel("Tracer Color"):AddColorPicker("TracerClr", { Default = Color3.fromRGB(255, 255, 255), Title = "Tracer Color", Callback = function(v) cfg.TracerColor = v for _, plr in ipairs(Players:GetPlayers()) do if espStore[plr] then espStore[plr].tracer.Color = v end end end })
espR:AddLabel("Chams Color"):AddColorPicker("ChamsClr", { Default = Color3.fromRGB(30, 100, 255), Title = "Chams Color", Callback = function(v) cfg.ChamsColor = v refreshChams() end })

wrld:AddToggle("XRayOn", { Text = "X-Ray Mode", Default = false, Callback = function(v) cfg.XRay = v updateXRay() end })
wrld:AddSlider("XRayTransp", { Text = "X-Ray Transparency", Default = 60, Min = 0, Max = 100, Rounding = 0, Callback = function(v) cfg.XRayTransparency = v / 100 updateXRay() end })
wrld:AddDivider()
wrld:AddToggle("FullBrightOn", { Text = "Full Bright", Default = false, Callback = function(v) cfg.FullBright = v end })
wrld:AddToggle("NoFogOn", { Text = "No Fog", Default = false, Callback = function(v) cfg.NoFog = v end })

-- [PLAYER / MOVEMENT TAB]
local movL = Tabs.Movement:AddLeftGroupbox("Movement Stats")
local movR = Tabs.Movement:AddRightGroupbox("Game State")

movL:AddSlider("WalkSpeedS", { Text = "WalkSpeed", Default = 16, Min = 16, Max = 50, Rounding = 0, Callback = function(v) cfg.WalkSpeed = v end })
movL:AddToggle("BunnyHopOn", { Text = "Bunny Hop", Default = false, Callback = function(v) cfg.BunnyHop = v toggleBunnyHop() end })
movL:AddSlider("BunnyHopDS", { Text = "Bunny Hop Delay", Default = 1, Min = 0, Max = 5, Rounding = 1, Callback = function(v) cfg.BunnyHopDelay = v end })
movL:AddToggle("NoVelocityOn", { Text = "Disable Knockback/Velocity", Default = false, Callback = function(v) cfg.NoVelocity = v toggleNoVelocity() end })

movR:AddToggle("AutoRespawnOn", { Text = "Auto Respawn", Default = false, Callback = function(v) cfg.AutoRespawn = v end })
movR:AddSlider("AutoRespawnDelS", { Text = "Respawn Delay", Default = 0, Min = 0, Max = 5, Rounding = 1, Callback = function(v) cfg.AutoRespawnDelay = v end })
movR:AddDivider()
movR:AddButton({ Text = "Join Game Lobby", Func = function() if CommandRemote then CommandRemote:FireServer("Lobby") end end })
movR:AddButton({ Text = "Join Active Play", Func = function() if CommandRemote then CommandRemote:FireServer("Play") end end })

-- [MISC & SETTINGS TAB]
local miscL = Tabs.Misc:AddLeftGroupbox("Info")
miscL:AddLabel("Hook Hub Extended")
miscL:AddDivider()
miscL:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", { Default = "RightShift", NoUI = true, Text = "Menu keybind", Callback = function() end })
Library.ToggleKeybind = Options.MenuKeybind
miscL:AddDivider()
miscL:AddToggle("AfkOn", { Text = "Anti AFK", Default = false, Callback = function(v) cfg.AntiAfk = v setAntiAfk(v) end })
miscL:AddDivider()
miscL:AddButton({ Text = "Test Notification", DoubleClick = false, Func = function() Library:Notify({ Title = "Hook Hub", Content = "Notifications working.", Duration = 3 }) end })
miscL:AddButton({ Text = "Reset Character", DoubleClick = false, Func = function() local c = lp.Character if c then local h = c:FindFirstChildOfClass("Humanoid") if h then h.Health = 0 end end end })
miscL:AddButton({ Text = "Rejoin Server", DoubleClick = true, Risky = true, Func = function() game:GetService("TeleportService"):Teleport(game.PlaceId, lp) end })

-- [CREDITS TAB]
local credsL = Tabs.Credits:AddLeftGroupbox("Information")
credsL:AddLabel("Made by Thukuna")


-- Config Management
SaveManager:SetLibrary(Library)
SaveManager:SetIgnoreIndexes({"MenuKeybind"})
SaveManager:SetFolder("ChillHub/Configs")
SaveManager:BuildConfigSection(Tabs.Misc)
SaveManager:LoadAutoloadConfig()

-- Core Loops
local fovCircle     = Drawing.new("Circle")
fovCircle.Visible   = false
fovCircle.Radius    = cfg.FOV
fovCircle.Thickness = cfg.FOVThick
fovCircle.Filled    = false
fovCircle.Color     = cfg.FOVColor

lp.CharacterAdded:Connect(function(c)
    char = c
    aiming = false
    currentTarget = nil
    task.spawn(function()
        root = c:WaitForChild("HumanoidRootPart", 5)
        hum  = c:FindFirstChildOfClass("Humanoid")
    end)
end)

if lp.Character then
    char = lp.Character
    root = char:FindFirstChild("HumanoidRootPart")
    hum  = char:FindFirstChildOfClass("Humanoid")
end

local function onJoin(plr)
    if plr == lp then return end
    espStore[plr] = buildESP(plr)
    plr.CharacterAdded:Connect(function()
        task.wait(0.5)
        if cfg.Chams then applyChams(plr) end
    end)
end

local function onLeave(plr)
    if espStore[plr] then wipeESP(espStore[plr]) espStore[plr] = nil end
    dropChams(plr)
end

for _, plr in ipairs(Players:GetPlayers()) do onJoin(plr) end
Players.PlayerAdded:Connect(onJoin)
Players.PlayerRemoving:Connect(onLeave)

RunService.Heartbeat:Connect(function()
    if not char then return end
    if not root then root = char:FindFirstChild("HumanoidRootPart") end
end)

RunService.RenderStepped:Connect(function()
    char = lp.Character or char
    if char then
        if not root then root = char:FindFirstChild("HumanoidRootPart") end
        if not hum  then hum  = char:FindFirstChildOfClass("Humanoid") end
    end

    local vp     = cam.ViewportSize
    local center = Vector2.new(vp.X / 2, vp.Y / 2)

    fovCircle.Position  = center
    fovCircle.Visible   = cfg.ShowFOV and (cfg.Aimbot or cfg.SilentAim)
    fovCircle.Radius    = cfg.FOV
    fovCircle.Color     = cfg.RainbowESP and getrainbowcolor() or cfg.FOVColor
    fovCircle.Thickness = cfg.FOVThick

    doAimlock()
    updateKnifeRangeSphere()
    
    if cfg.Chams and cfg.RainbowESP then refreshChams() end

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= lp then renderESP(plr) end
    end
end)

pcall(function()
    local BulletHandler = require(ReplicatedStorage.ModuleScripts.GunModules.BulletHandler)
    local oldFire = BulletHandler.Fire
    BulletHandler.Fire = function(arg1)
        if cfg.SilentAim and arg1 and arg1.Misc then
            local target = getClosestPlayerToCursor()
            if target and target.Character and target.Character:FindFirstChild("Head") then
                local headPos = target.Character.Head.Position
                arg1.Direction = (headPos - arg1.Origin).Unit
                arg1.Misc.CamCFrame = CFrame.new(arg1.Origin, headPos)
            end
        end
        return oldFire(arg1)
    end
end)