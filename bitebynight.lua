local Lighting = game:GetService("Lighting")
local Terrain = workspace:FindFirstChildOfClass("Terrain")

pcall(function()
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    Lighting.ShadowSoftness = 0
    Lighting.ClockTime = 14
    Lighting.Brightness = 2

    if Terrain then
        Terrain.WaterWaveSize = 0
        Terrain.WaterWaveSpeed = 0
        Terrain.WaterReflectance = 0
        Terrain.WaterTransparency = 1
        Terrain.Decoration = false
    end

    local WorkspaceDescendants = workspace:GetDescendants()
    for Index = 1, #WorkspaceDescendants do
        local Object = WorkspaceDescendants[Index]
        pcall(function()
            if Object:IsA("BasePart") or Object:IsA("MeshPart") or Object:IsA("UnionOperation") or Object:IsA("CornerWedgePart") or Object:IsA("TrussPart") then
                Object.Material = Enum.Material.SmoothPlastic
                Object.Reflectance = 0
                Object.CastShadow = false
            elseif Object:IsA("Decal") or Object:IsA("Texture") then
                Object.Transparency = 1
            elseif Object:IsA("ParticleEmitter") or Object:IsA("Trail") or Object:IsA("Sparkles") or Object:IsA("Smoke") or Object:IsA("Fire") or Object:IsA("SpotLight") then
                Object.Enabled = false
            elseif Object:IsA("Explosion") then
                Object.BlastPressure = 1
                Object.BlastRadius = 1
            elseif Object:IsA("PostEffect") or Object:IsA("BlurEffect") or Object:IsA("SunRaysEffect") or Object:IsA("ColorCorrectionEffect") or Object:IsA("BloomEffect") or Object:IsA("DepthOfFieldEffect") then
                Object.Enabled = false
            end
        end)
    end
end)

game.DescendantAdded:Connect(function(Object)
    pcall(function()
        if Object:IsA("BasePart") or Object:IsA("MeshPart") then
            Object.Material = Enum.Material.SmoothPlastic
            Object.Reflectance = 0
            Object.CastShadow = false
        elseif Object:IsA("Decal") or Object:IsA("Texture") then
            Object.Transparency = 1
        elseif Object:IsA("ParticleEmitter") or Object:IsA("Trail") or Object:IsA("Sparkles") or Object:IsA("Smoke") or Object:IsA("Fire") then
            Object.Enabled = false
        end
    end)
end)

pcall(function() settings().Physics.AllowSleep = true end)
pcall(function() settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Default end)
pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level01 end)

local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local V = "V.0.51"

local Window = Library:CreateWindow({
	Title = "Goat Hub",
	Footer = "Version: " .. V,
	Icon = 154858229,
	NotifySide = "Right",
	ShowCustomCursor = true,
})

local Tabs = {
	Info = Window:AddTab("Info", "info"),
	Main = Window:AddTab("Main", "swords"),
	Player = Window:AddTab("Player", "user"),
	Esp = Window:AddTab("Esp", "eye"),
	Discord = Window:AddTab("Discord", "message-square"),
	Settings = Window:AddTab("Settings", "settings")
}

local InfoGroup = Tabs.Info:AddLeftGroupbox("Information")
local MainGroup = Tabs.Main:AddLeftGroupbox("Main Features")
local PlayerGroup = Tabs.Player:AddLeftGroupbox("Player Settings")
local EspGroup = Tabs.Esp:AddLeftGroupbox("ESP Settings")
local DiscordGroup = Tabs.Discord:AddLeftGroupbox("Discord")
local SettingsGroup = Tabs.Settings:AddLeftGroupbox("Settings")
local ConfigGroup = Tabs.Settings:AddRightGroupbox("Configuration")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local CollectionService = game:GetService("CollectionService")
local MarketplaceService = game:GetService("MarketplaceService")

local infoGameName = MarketplaceService:GetProductInfo(game.PlaceId)

local ActiveNoCooldownPrompt = false
local ActiveDistanceEsp = false
local ActiveBigPrompt = false
local DisableLimitRangerEsp = false
local LimitRangerEsp = 100
local ValueRunSpeed = 24
local ActiveSpeedBoost = false
local ValueWalkSpeed = 15
local ActiveSpeedBoost2 = false
local ActiveEspKillers = false
local ActiveEspSurvivors = false
local ActiveEspGen = false
local AutoEscape = false
local AutoGen = false
local ActiveEspFuseBoxes = false
local FighterAutoParry = false
local ActiveEspBattery = false
local AutoBarricade = false
local AutoSafeSpot = false
local HitboxExpender = false
local ValueHE = 15
local ActiveEspTraps = false
local ActiveEspWireEyes = false
local AutoShakeWireEyes = false
local ActiveInfiniteStamina = false
local CanShake = true
local NoBlindness = false
local ActiveAntiDeafness = false
local CanGenerator = true
local ShakeTime = 0.5
local InvisibilityKiller = false
local ActiveNoclip = false
local AutoFarm = false
local CanGo = true
local ActivateJumping = false
local JumpPowerValue = 50
local State = "Idle"
local TimeForGenerator = 0
local AutoHighlightKillerCamera = false
local ParryDistance = 22
local AntiConfusion = false

local ActiveKillerAimbot = false
local AimbotTargetPlayer = nil

local oldNewIndex
oldNewIndex = hookmetamethod(game, "__newindex", newcclosure(function(t, k, v)
	if AutoBarricade and not checkcaller() and k == "Position" and typeof(t) == "Instance" and t.Name == "Frame" then
		local p = t.Parent
		if p and p.Name == "Container" then
			local b = p:FindFirstChild("Box")
			if b then
				v = UDim2.new(
					0, (b.AbsolutePosition.X + (b.AbsoluteSize.X / 2)) - p.AbsolutePosition.X,
					0, (b.AbsolutePosition.Y + (b.AbsoluteSize.Y / 2)) - p.AbsolutePosition.Y
				)
			end
		end
	end
	return oldNewIndex(t, k, v)
end))

local Version = InfoGroup:AddLabel("Version: " .. V)
InfoGroup:AddLabel("Game: " .. infoGameName.Name, true)
InfoGroup:AddLabel("PlaceId: " .. tostring(game.PlaceId))
InfoGroup:AddLabel("JobId: " .. tostring(game.JobId))
InfoGroup:AddLabel("IsStudio: " .. tostring(RunService:IsStudio()))
local ParagraphInfoServer = InfoGroup:AddLabel("Players: Loading...")

Library:Notify({
	Title = "Goat Hub Loaded",
	Description = "Welcome back, Boss! (Version " .. V .. ")",
	Time = 7.5
})

local function doShake(wireyesUI)
	task.spawn(function()
		local wireyesClient = wireyesUI:WaitForChild("WireyesClient", 2)
		if wireyesClient then
			local remote = wireyesClient:WaitForChild("WireyesEvent", 2)
			if remote then
				CanShake = false
				task.spawn(function()
					task.wait(ShakeTime)
					CanShake = true
				end)
				pcall(function() remote:FireServer("Shaking") end)
				task.wait(0.05)
				pcall(function() remote:FireServer("TakeOff", workspace:GetServerTimeNow()) end)
			end
		end
	end)
end

local function getServerInfo()
	local playerCount = #Players:GetPlayers()
	local maxPlayers = Players.MaxPlayers
	local isStudio = RunService:IsStudio()
	return {
		PlaceId = game.PlaceId,
		JobId = game.JobId,
		IsStudio = isStudio,
		CurrentPlayers = playerCount,
		MaxPlayers = maxPlayers
	}
end

local ESPs = {}
local Camera = workspace.CurrentCamera
local LineESPEnabled = false
local SavedCFrame = nil
local Teleported = false

local function CreateEsp(Char, Color, Text, Parent)
	if not Char or not Parent then return end
	if Char:FindFirstChild("ESP") and Char:FindFirstChildOfClass("Highlight") then return end
	
	local highlight = Char:FindFirstChildOfClass("Highlight") or Instance.new("Highlight")
	highlight.Name = "ESP_Highlight"
	highlight.Adornee = Char
	highlight.FillColor = Color
	highlight.FillTransparency = 1
	highlight.OutlineColor = Color
	highlight.OutlineTransparency = 0
	highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	highlight.Enabled = false
	highlight.Parent = Char
	
	local billboard = Char:FindFirstChild("ESP") or Instance.new("BillboardGui")
	billboard.Name = "ESP"
	billboard.Size = UDim2.new(10, 0, 2.5, 0)
	billboard.AlwaysOnTop = true
	billboard.StudsOffset = Vector3.new(0, -2, 0)
	billboard.Adornee = Parent
	billboard.Enabled = false
	billboard.Parent = Parent
	
	local label = billboard:FindFirstChildOfClass("TextLabel") or Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = Text
	label.TextColor3 = Color
	label.TextScaled = true
	label.Parent = billboard
	
	local line = Drawing.new("Line")
	line.Visible = false
	line.Color = Color
	line.Thickness = 1.5
	line.Transparency = 1
	
	table.insert(ESPs, { Char = Char, Highlight = highlight, Billboard = billboard, Label = label, Part = Parent, Line = line, Text = Text, Color = Color })
end

local LastAction = 0
local Cooldown = 0.5
local SPEED = 30

local function TweenTo(character, cf)
	local root = character:FindFirstChild("HumanoidRootPart") or character.PrimaryPart
	if not root then return end
	local distance = (root.Position - cf.Position).Magnitude
	local time = distance / SPEED
	local tween = TweenService:Create(root, TweenInfo.new(time, Enum.EasingStyle.Linear), {CFrame = cf})
	tween:Play()
	tween.Completed:Wait()
end

local function GetNearestSurvivor()
    local StatusTarget, ResultTarget = pcall(function()
        if AimbotTargetPlayer and AimbotTargetPlayer.Parent and AimbotTargetPlayer.Parent.Parent == workspace:FindFirstChild("PLAYERS") and workspace.PLAYERS:FindFirstChild("ALIVE") then
            local TargetHumanoid = AimbotTargetPlayer.Parent:FindFirstChild("Humanoid")
            if TargetHumanoid and TargetHumanoid.Health > 0 then
                return true
            end
        end
        return false
    end)
    
    if StatusTarget and ResultTarget == true then
        return AimbotTargetPlayer
    end

    pcall(function()
        if AimbotTargetPlayer and AimbotTargetPlayer.Parent then
            AimbotTargetPlayer.Size = Vector3.new(2, 2, 1)
        end
    end)

    AimbotTargetPlayer = nil
    local MinimumMagnitude = math.huge

    pcall(function()
        local AliveFolder = workspace:FindFirstChild("PLAYERS") and workspace.PLAYERS:FindFirstChild("ALIVE")
        if AliveFolder then
            local LocalCharacter = LocalPlayer.Character
            if LocalCharacter and LocalCharacter:FindFirstChild("HumanoidRootPart") then
                for _, SurvivorInstance in ipairs(AliveFolder:GetChildren()) do
                    if SurvivorInstance ~= LocalCharacter then
                        local SurvivorHumanoid = SurvivorInstance:FindFirstChild("Humanoid")
                        local SurvivorRootPart = SurvivorInstance:FindFirstChild("HumanoidRootPart")
                        if SurvivorHumanoid and SurvivorRootPart and SurvivorHumanoid.Health > 0 then
                            local CurrentMagnitude = (LocalCharacter.HumanoidRootPart.Position - SurvivorRootPart.Position).Magnitude
                            if CurrentMagnitude < MinimumMagnitude then
                                MinimumMagnitude = CurrentMagnitude
                                AimbotTargetPlayer = SurvivorRootPart
                            end
                        end
                    end
                end
            end
        end
    end)
    return AimbotTargetPlayer
end

SoundService.DescendantAdded:Connect(function(child)
	if ActiveAntiDeafness and child:IsA("EqualizerSoundEffect") then
		task.wait()
		child:Destroy()
	end
end)

RunService.RenderStepped:Connect(function()
	task.spawn(function()
		local updatedInfo = getServerInfo()
		local updatedContent = string.format("Players: %d/%d", updatedInfo.CurrentPlayers, updatedInfo.MaxPlayers)
		if ParagraphInfoServer and ParagraphInfoServer.SetText then
			ParagraphInfoServer:SetText(updatedContent)
		end
	end)
	
	task.spawn(function()
		if not Camera then
			Camera = workspace.CurrentCamera
			return
		end
		
		local cameraPosition = Camera.CFrame.Position
		local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
		
		for _, esp in ipairs(ESPs) do
			local char, part, highlight, billboard, label, line = esp.Char, esp.Part, esp.Highlight, esp.Billboard, esp.Label, esp.Line
			
			if part and part.Parent and highlight and billboard then
				local distance = (cameraPosition - part.Position).Magnitude
				local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
				local withinRange = DisableLimitRangerEsp or distance <= LimitRangerEsp
				
				highlight.Enabled = withinRange and onScreen
				billboard.Enabled = withinRange and onScreen
				
				if ActiveDistanceEsp then
					label.Text = esp.Text .. " (" .. math.floor(distance + 0.5) .. " m)"
				else
					label.Text = esp.Text
				end
				
				local hum = char:FindFirstChildOfClass("Humanoid")
				if hum then
					label.Text = label.Text.."|" .. hum.Health.."/"..hum.MaxHealth.." HP"
				end
				
				if LineESPEnabled and onScreen and withinRange then
					line.Visible = true
					line.From = screenCenter
					line.To = Vector2.new(screenPos.X, screenPos.Y)
				else
					line.Visible = false
				end
			else
				if line then line.Visible = false end
			end
		end
	end)
	
	local Character = LocalPlayer.Character
	if Character then
		if ActiveInfiniteStamina then
			local mx = Character:GetAttribute("MaxStamina") or 100
			if (Character:GetAttribute("Stamina") or mx) < mx then
				Character:SetAttribute("Stamina", mx)
			end
		end
		
		if AutoShakeWireEyes and CanShake then
			local existing = LocalPlayer.PlayerGui:FindFirstChild("WireyesUI")
			if existing then
				doShake(existing)
			end
		end
		
		if NoBlindness then
			local blind = game:GetService("ReplicatedStorage").Modules.BlindnessModule:FindFirstChildOfClass("Atmosphere")
			if blind then blind:Destroy() end
		end
		
		if AutoFarm and tick() - LastAction >= Cooldown then
			task.spawn(function()
				if Character and Character.PrimaryPart and Character.Parent == workspace:FindFirstChild("PLAYERS") and Character.Parent.ALIVE then
					if CanGo then
						if not LocalPlayer.PlayerGui:FindFirstChild("Gen") then
							if not Character:FindFirstChild("Battery") then
								for _, child in pairs(workspace.IGNORE:GetChildren()) do
									if child.Name == "Battery" and child:IsA("BasePart") then
										local attachment = child:FindFirstChild("Attachment")
										local prompt = attachment and attachment:FindFirstChildOfClass("ProximityPrompt")
										if prompt then
											CanGo, State, LastAction = false, "Battery", tick()
											TweenTo(Character, child.CFrame)
											task.wait(0.05)
											fireproximityprompt(prompt)
											task.spawn(function()
												task.wait(prompt.HoldDuration + 0.1)
												CanGo, State = true, "Idle"
											end)
											break
										end
									end
								end
							else
								local map = workspace.MAPS:FindFirstChild("GAME MAP")
								if map and not LocalPlayer.PlayerGui:FindFirstChild("Gen") then
									local fuseFolder = map:FindFirstChild("FuseBoxes")
									if fuseFolder then
										for _, fuse in pairs(fuseFolder:GetChildren()) do
											if fuse:IsA("Model") then
												local root = fuse:FindFirstChild("HumanoidRootPart")
												local pos = fuse:FindFirstChild("Position")
												if root and pos then
													local attachment = root:FindFirstChildOfClass("Attachment")
													local prompt = attachment and attachment:FindFirstChildOfClass("ProximityPrompt")
													if prompt and prompt.Enabled then
														CanGo, State, LastAction = false, "Fuse", tick()
														TweenTo(Character, pos.CFrame + Vector3.new(0,2.5,0))
														task.wait(0.05)
														fireproximityprompt(prompt)
														task.spawn(function()
															task.wait(prompt.HoldDuration + 0.1)
															CanGo, State = true, "Idle"
														end)
														break
													end
												end
											end
										end
									end
								end
							end
						end
					end
					
					if CanGo and workspace.GAME.Tasks.Gens.Enabled.Value then
						local gens = workspace.MAPS:FindFirstChild("GAME MAP") and workspace.MAPS["GAME MAP"]:FindFirstChild("Generators")
						if gens and not LocalPlayer.PlayerGui:FindFirstChild("Gen") then
							for _, gen in pairs(gens:GetChildren()) do
								if gen.Name == "Generator" and gen:GetAttribute("Progress") < 100 then
									local root = gen:FindFirstChild("RootPart")
									if root then
										for _, atch in ipairs(root:GetChildren()) do
											if atch:IsA("Attachment") then
												local prompt = atch:FindFirstChildOfClass("ProximityPrompt")
												if prompt and prompt.Enabled then
													local point = gen:FindFirstChild(atch.Name)
													if point then
														CanGo, State, LastAction = false, "Gen", tick()
														TweenTo(Character, point.CFrame)
														task.wait(0.05)
														fireproximityprompt(prompt)
														task.spawn(function()
															task.wait(prompt.HoldDuration + 0.1)
															CanGo, State = true, "Idle"
														end)
														break
													end
												end
											end
										end
									end
								end
								if not CanGo then break end
							end
						end
					end
					
					if CanGo and workspace.GAME.CAN_ESCAPE.Value then
						local escapes = workspace.MAPS:FindFirstChild("GAME MAP") and workspace.MAPS["GAME MAP"]:FindFirstChild("Escapes")
						if escapes then
							for _, part in pairs(escapes:GetChildren()) do
								if part:IsA("BasePart") and part:GetAttribute("Enabled") then
									CanGo, State, LastAction = false, "Escape", tick()
									TweenTo(Character, part.CFrame)
									task.spawn(function()
										task.wait(0.5)
										CanGo, State = true, "Idle"
									end)
									break
								end
							end
						end
					end
				end
			end)
		end
		
		if ActivateJumping then
			local HUMM = Character:FindFirstChildOfClass("Humanoid")
			if HUMM then
				HUMM.UseJumpPower = ActivateJumping
				HUMM.JumpPower = JumpPowerValue
			end
		end
		
		if AutoSafeSpot and not AutoFarm then
			local hum = Character:FindFirstChildOfClass("Humanoid")
			if hum then
				if hum.Health > 35 then
					SavedCFrame = Character.PrimaryPart.CFrame
				elseif hum.Health <= 35 then
					Character.PrimaryPart.CFrame = CFrame.new(0,500,0)
				end
			end
		end
		
		if ActiveSpeedBoost then Character:SetAttribute("RunSpeed", ValueRunSpeed) end
		if ActiveSpeedBoost2 then Character:SetAttribute("WalkSpeed", ValueWalkSpeed) end
		
		if AutoEscape then
			local hrp = Character:FindFirstChild("HumanoidRootPart")
			if hrp then
				local map = workspace:FindFirstChild("MAPS") and workspace.MAPS:FindFirstChild("GAME MAP")
				if map and map:FindFirstChild("Escapes") then
					for _, obj in ipairs(map.Escapes:GetChildren()) do
						if obj:IsA("BasePart") or obj:IsA("Model") then
							local isReady = false
							local highlight = obj:FindFirstChildWhichIsA("Highlight", true)
							
							if highlight and highlight.Enabled then
								isReady = true
							elseif obj:GetAttribute("Enabled") == true or obj:GetAttribute("Open") == true then
								isReady = true
							end
							
							if isReady then
								local targetPos = obj:IsA("Model") and obj:GetPivot().Position or obj.Position
								hrp.CFrame = CFrame.new(targetPos + Vector3.new(0, 2, 0))
								AutoEscape = false
								break
							end
						end
					end
				end
			end
		end
	end

    pcall(function()
        if not ActiveKillerAimbot then
            pcall(function()
                if AimbotTargetPlayer and AimbotTargetPlayer.Parent then
                    AimbotTargetPlayer.Size = Vector3.new(2, 2, 1)
                    AimbotTargetPlayer = nil
                end
            end)
            return
        end
        local CurrentTarget = GetNearestSurvivor()
        if CurrentTarget then
            local CurrentLocalCharacter = LocalPlayer.Character
            if CurrentLocalCharacter and CurrentLocalCharacter:FindFirstChild("Humanoid") and CurrentLocalCharacter.Humanoid.Health > 0 then
                local AimCFrame = CFrame.new(Camera.CFrame.Position, CurrentTarget.Position)
                Camera.CFrame = Camera.CFrame:Lerp(AimCFrame, 0.08)
                CurrentTarget.Size = Vector3.new(25, 25, 25)
                CurrentTarget.CanCollide = false
                CurrentTarget.Transparency = 1
            end
        end
    end)
end)

local TimeAutoHighlight = 0.1

LocalPlayer.PlayerGui.ChildAdded:Connect(function(child)
	if child.Name == "Camera" and AutoHighlightKillerCamera then
		local main = child:WaitForChild("Main", 2)
		if main then
			local locateRemote = main:WaitForChild("Locate", 2)
			if locateRemote then
				task.wait(TimeAutoHighlight)
				local killer = workspace:FindFirstChild("PLAYERS") and workspace.PLAYERS:FindFirstChild("KILLER") and workspace.PLAYERS.KILLER:FindFirstChildOfClass("Model")
				if killer and killer:FindFirstChild("HumanoidRootPart") then
					locateRemote:FireServer(killer)
				end
			end
		end
	end
	
	if child.Name == "Gen" and (AutoGen or AutoFarm) then
		task.spawn(function()
			task.wait(TimeForGenerator)
			local genMain = child:WaitForChild("GeneratorMain", 1)
			if genMain then
				genMain.Event:FireServer({Wires = true, Switches = true, Lever = true})
			end
		end)
	end
end)

CollectionService:GetInstanceAddedSignal("Confusion"):Connect(function(instance)
	if AntiConfusion and instance == LocalPlayer.Character then
		CollectionService:RemoveTag(instance, "Confusion")
	end
end)

local function KeepEsp(Char, Parent)
	if not Char or not Char:FindFirstChildOfClass("Highlight") then return end
	if not Parent or not Parent:FindFirstChildOfClass("BillboardGui") then return end
	for i = #ESPs, 1, -1 do
		local esp = ESPs[i]
		if esp.Char == Char then
			if esp.Highlight then esp.Highlight:Destroy() end
			if esp.Billboard then esp.Billboard:Destroy() end
			if esp.Line then esp.Line:Destroy() end
			table.remove(ESPs, i)
		end
	end
end

local function SetupCharacter(child, Map, Part)
	if not child:IsA("Model") then return end
	child.AncestryChanged:Connect(function(_, newParent)
		if not child:IsDescendantOf(Map) then
			KeepEsp(child, Part)
		end
	end)
end

EspGroup:AddToggle("EspSurvivorsToggle", {
	Text = "Esp Survivors", Default = false,
	Callback = function(Value)
		ActiveEspSurvivors = Value
		local alive = workspace:FindFirstChild("PLAYERS") and workspace.PLAYERS:FindFirstChild("ALIVE")
		if not alive then return end
		if ActiveEspSurvivors then
			for _, p in pairs(alive:GetChildren()) do
				if p:IsA("Model") and p.PrimaryPart and not p.PrimaryPart:FindFirstChildOfClass("BillboardGui") then
					if p:FindFirstChildOfClass("Highlight") then p:FindFirstChildOfClass("Highlight"):Destroy() end
					SetupCharacter(p, alive, p.PrimaryPart)
					CreateEsp(p, Color3.fromRGB(0,255,0), p.Name.." "..p:GetAttribute("Character"), p.PrimaryPart, 2)
				end
			end
		else
			for _, p in pairs(alive:GetChildren()) do
				if p:IsA("Model") and p.PrimaryPart and p:FindFirstChildOfClass("Highlight") and p.PrimaryPart:FindFirstChildOfClass("BillboardGui") then
					KeepEsp(p, p.PrimaryPart)
				end
			end
		end
	end
})

EspGroup:AddToggle("EspKillersToggle", {
	Text = "Esp Killers", Default = false,
	Callback = function(Value)
		ActiveEspKillers = Value
		local killerFolder = workspace:FindFirstChild("PLAYERS") and workspace.PLAYERS:FindFirstChild("KILLER")
		if not killerFolder then return end
		if ActiveEspKillers then
			for _, p in pairs(killerFolder:GetChildren()) do
				if p:IsA("Model") and (p:FindFirstChild("RootPart") or p:FindFirstChild("HumanoidRootPart")) then
					if p:FindFirstChildOfClass("Highlight") then p:FindFirstChildOfClass("Highlight"):Destroy() end
					local part = p:FindFirstChild("RootPart") or p:FindFirstChild("HumanoidRootPart")
					if p:GetAttribute("Character") == "Ennard" then part = p:FindFirstChild("HumanoidRootPart") end
					if not part:FindFirstChildOfClass("BillboardGui") then
						SetupCharacter(p, killerFolder, part)
						CreateEsp(p, Color3.fromRGB(255,0,0), p.Name.." "..p:GetAttribute("Character"), part, 2)
					end
				end
			end
		else
			for _, p in pairs(killerFolder:GetChildren()) do
				if p:IsA("Model") and (p:FindFirstChild("RootPart") or p:FindFirstChild("HumanoidRootPart")) and p:FindFirstChildOfClass("Highlight") then
					local part = p:FindFirstChild("RootPart") or p:FindFirstChild("HumanoidRootPart")
					if p:GetAttribute("Character") == "Ennard" then part = p:FindFirstChild("HumanoidRootPart") end
					if part:FindFirstChildOfClass("BillboardGui") then KeepEsp(p, part) end
				end
			end
		end
	end
})

EspGroup:AddToggle("EspGenToggle", {
	Text = "Esp Generators", Default = false,
	Callback = function(Value)
		ActiveEspGen = Value
		local map = workspace.MAPS:FindFirstChild("GAME MAP")
		if not map then return end
		if ActiveEspGen then
			for _, p in pairs(map.Generators:GetChildren()) do
				if p:IsA("Model") and p.PrimaryPart and not p:FindFirstChildOfClass("Highlight") and not p.PrimaryPart:FindFirstChildOfClass("BillboardGui") then
					CreateEsp(p, Color3.fromRGB(255,255,0), "Generators", p.PrimaryPart, 2)
				end
			end
		else
			for _, p in pairs(map.Generators:GetChildren()) do
				if p:IsA("Model") and p.PrimaryPart and p:FindFirstChildOfClass("Highlight") and p.PrimaryPart:FindFirstChildOfClass("BillboardGui") then
					KeepEsp(p, p.PrimaryPart)
				end
			end
		end
	end
})

EspGroup:AddToggle("EspFuseBoxesToggle", {
	Text = "Esp Fuse Boxes", Default = false,
	Callback = function(Value)
		ActiveEspFuseBoxes = Value
		local map = workspace.MAPS:FindFirstChild("GAME MAP")
		if not map or not map:FindFirstChild("FuseBoxes") then return end
		if ActiveEspFuseBoxes then
			for _, p in pairs(map.FuseBoxes:GetChildren()) do
				if p:IsA("Model") and p.PrimaryPart and not p.PrimaryPart:FindFirstChildOfClass("BillboardGui") then
					if p:FindFirstChildOfClass("Highlight") then p:FindFirstChildOfClass("Highlight"):Destroy() end
					CreateEsp(p, Color3.fromRGB(0,0,255), "Fuse Box", p.PrimaryPart, 2)
				end
			end
		else
			for _, p in pairs(map.FuseBoxes:GetChildren()) do
				if p:IsA("Model") and p.PrimaryPart and p:FindFirstChildOfClass("Highlight") and p.PrimaryPart:FindFirstChildOfClass("BillboardGui") then
					KeepEsp(p, p.PrimaryPart)
				end
			end
		end
	end
})

EspGroup:AddToggle("EspBatteryToggle", {
	Text = "Esp Battery", Default = false,
	Callback = function(Value)
		ActiveEspBattery = Value
		if ActiveEspBattery then
			for _, p in pairs(workspace.IGNORE:GetChildren()) do
				if p:IsA("BasePart") and p.Name == "Battery" and not p:FindFirstChildOfClass("BillboardGui") then
					if p:FindFirstChildOfClass("Highlight") then p:FindFirstChildOfClass("Highlight"):Destroy() end
					CreateEsp(p, Color3.fromRGB(0,0,255), "Battery", p, 2)
				end
			end
		else
			for _, p in pairs(workspace.IGNORE:GetChildren()) do
				if p:IsA("BasePart") and p.Name == "Battery" and p:FindFirstChildOfClass("Highlight") and p:FindFirstChildOfClass("BillboardGui") then
					KeepEsp(p, p)
				end
			end
		end
	end
})

EspGroup:AddToggle("EspTrapToggle", {
	Text = "Esp Traps", Default = false,
	Callback = function(Value)
		ActiveEspTraps = Value
		if ActiveEspTraps then
			for _, p in pairs(workspace.IGNORE:GetChildren()) do
				if p:IsA("Model") and p.Name == "Trap" and p.PrimaryPart and not p.PrimaryPart:FindFirstChildOfClass("BillboardGui") then
					if p:FindFirstChildOfClass("Highlight") then p:FindFirstChildOfClass("Highlight"):Destroy() end
					CreateEsp(p, Color3.fromRGB(255,0,0), "Trap", p.PrimaryPart, 2)
				end
			end
		else
			for _, p in pairs(workspace.IGNORE:GetChildren()) do
				if p:IsA("Model") and p.Name == "Trap" and p.PrimaryPart and p:FindFirstChildOfClass("Highlight") and p.PrimaryPart:FindFirstChildOfClass("BillboardGui") then
					KeepEsp(p, p.PrimaryPart)
				end
			end
		end
	end
})

EspGroup:AddToggle("EspWireEyesToggle", {
	Text = "Esp Wire Eyes", Default = false,
	Callback = function(Value)
		ActiveEspWireEyes = Value
		if ActiveEspWireEyes then
			for _, p in pairs(workspace.IGNORE:GetChildren()) do
				if p:IsA("Model") and p.Name == "Minion" and p.PrimaryPart and not p.PrimaryPart:FindFirstChildOfClass("BillboardGui") then
					if p:FindFirstChildOfClass("Highlight") then p:FindFirstChildOfClass("Highlight"):Destroy() end
					SetupCharacter(p, workspace.IGNORE, p.PrimaryPart)
					CreateEsp(p, Color3.fromRGB(255,0,0), "Wire Eyes", p.PrimaryPart, 2)
				end
			end
		else
			for _, p in pairs(workspace.IGNORE:GetChildren()) do
				if p:IsA("Model") and p.Name == "Minion" and p.PrimaryPart and p:FindFirstChildOfClass("Highlight") and p.PrimaryPart:FindFirstChildOfClass("BillboardGui") then
					KeepEsp(p, p.PrimaryPart)
				end
			end
		end
	end
})

MainGroup:AddToggle("ToggleKillerAimbot", {
    Text = "Smooth Aimbot + Hitbox Expander",
    Default = false,
    Callback = function(Value)
        ActiveKillerAimbot = Value
    end
})

MainGroup:AddButton({
	Text = "Delete Doors",
	Func = function()
		local map = workspace.MAPS:FindFirstChild("GAME MAP")
		if map and map:FindFirstChild("Doors") then
			map.Doors:Destroy()
		end
	end
})

MainGroup:AddButton({
	Text = "Play killer cutscene",
	Func = function()
		local killerFolder = workspace:FindFirstChild("PLAYERS") and workspace.PLAYERS:FindFirstChild("KILLER")
		local killer = killerFolder and killerFolder:FindFirstChildOfClass("Model")
		if killer and killer == LocalPlayer.Character then
			killer:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Dead)
		end
	end
})

MainGroup:AddButton({
	Text = "Skip cutscene",
	Func = function()
		local cutsceneRigs = game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Cutscenes"):WaitForChild("Rigs")
		local rigs = {"IntroCam", "IntroCamWithLight", "KillCam", "OutroCam"}
		for _, name in ipairs(rigs) do
			local rig = cutsceneRigs:FindFirstChild(name)
			if rig then rig:Destroy() end
		end
	end
})

local animationTrack, steppedConnection, cameraConnection
local function ApplyInvisibility(enabled)
	local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	local hum = char:WaitForChild("Humanoid")
	local root = char:WaitForChild("HumanoidRootPart")
	local cam = workspace.CurrentCamera
	
	if not enabled then
		if animationTrack then animationTrack:Stop(); animationTrack = nil end
		if steppedConnection then steppedConnection:Disconnect(); steppedConnection = nil end
		if cameraConnection then cameraConnection:Disconnect(); cameraConnection = nil end
		cam.CameraSubject = hum
		local map = workspace.MAPS:FindFirstChild("GAME MAP")
		if map and map:FindFirstChild("Doors") then
			for _, part in pairs(map.Doors:GetDescendants()) do
				if part:IsA("BasePart") and part:GetAttribute("OriginalCollision") ~= nil then
					part.CanCollide = part:GetAttribute("OriginalCollision")
				end
			end
		end
		return
	end
	
	if char:GetAttribute("Team") == "Killer" then
		local cName = char:GetAttribute("Character")
		if cName ~= "Mimic" and cName ~= "Ennard" then return end
		
		for _, p in ipairs(char:GetDescendants()) do
			if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then p.CanCollide = false end
		end
		root.CanCollide = true
		cam.CameraSubject = root
		cameraConnection = cam:GetPropertyChangedSignal("CameraSubject"):Connect(function()
			if cam.CameraSubject ~= root then cam.CameraSubject = root end
		end)
		
		local map = workspace.MAPS:FindFirstChild("GAME MAP")
		if map and map:FindFirstChild("Doors") then
			for _, part in pairs(map.Doors:GetDescendants()) do
				if part:IsA("BasePart") and part.CanCollide then
					if part:GetAttribute("OriginalCollision") == nil then
						part:SetAttribute("OriginalCollision", part.CanCollide)
					end
					part.CanCollide = false
				end
			end
		end
		
		local anim = Instance.new("Animation")
		anim.AnimationId = (cName == "Mimic") and "rbxassetid://95483601477510" or "rbxassetid://111261793531584"
		
		local animator = hum:FindFirstChildOfClass("Animator") or Instance.new("Animator", hum)
		animationTrack = animator:LoadAnimation(anim)
		animationTrack.Priority = Enum.AnimationPriority.Action4
		animationTrack.Looped = false
		animationTrack:Play()
		task.wait(0.1)
		if animationTrack.Length > 0 then
			animationTrack.TimePosition = animationTrack.Length - 0.01
			animationTrack:AdjustSpeed(0)
		end
		
		steppedConnection = RunService.RenderStepped:Connect(function()
			if cam.CameraSubject ~= root then cam.CameraSubject = root end
		end)
	end
end

DiscordGroup:AddButton({
	Text = "Discord Link",
	Func = function()
		if setclipboard then setclipboard("https://discord.gg/E2TqYRsRP4") end
	end
})

MainGroup:AddToggle("ToggleAG", { Text = "Auto Generator", Default = false, Callback = function(s) AutoGen = s end })
MainGroup:AddToggle("ToggleAutoHighlightKillerAsSG", { Text = "Auto Highlight Killer", Default = false, Callback = function(s) AutoHighlightKillerCamera = s end })
MainGroup:AddToggle("ToggleAntiConfusion", { Text = "Anti Confusion", Default = false, Callback = function(s) AntiConfusion = s end })
MainGroup:AddToggle("ToggleAntiDeafness", {
	Text = "Anti Deafness", Default = false,
	Callback = function(Value)
		ActiveAntiDeafness = Value
		if ActiveAntiDeafness then
			for _, sg in pairs(SoundService:GetChildren()) do
				if sg:IsA("SoundGroup") then
					for _, eq in pairs(sg:GetDescendants()) do
						if eq:IsA("EqualizerSoundEffect") then eq:Destroy() end
					end
				end
			end
		end
	end
})

MainGroup:AddSlider("TimeForAH", { Text = "Time For Auto Highlight Killer", Min = 0, Max = 2.5, Default = 0.1, Rounding = 1, Callback = function(v) TimeAutoHighlight = v end })

local kFolder = workspace:FindFirstChild("PLAYERS") and workspace.PLAYERS:FindFirstChild("KILLER")
if kFolder then
	kFolder.ChildRemoved:Connect(function() ApplyInvisibility(false) end)
	kFolder.ChildAdded:Connect(function() if InvisibilityKiller then ApplyInvisibility(true) end end)
end

MainGroup:AddToggle("AutoFarmToggle", { Text = "Auto Farm", Default = false, Callback = function(v) AutoFarm = v end })
MainGroup:AddSlider("TimeForGeneratorSlider", { Text = "Time For Generator", Min = 0, Max = 3, Default = 0, Rounding = 2, Callback = function(v) TimeForGenerator = v end })
MainGroup:AddToggle("ToggleAutoParry", { Text = "Fighter - Auto Parry", Default = false, Callback = function(s) FighterAutoParry = s end })
MainGroup:AddToggle("ToggleBarricade", { Text = "Auto Barricade", Default = false, Callback = function(s) AutoBarricade = s end })

MainGroup:AddToggle("ToggleAutoSafeSpot", {
	Text = "Auto Safe spot", Default = false,
	Callback = function(state)
		AutoSafeSpot = state
		if not AutoSafeSpot and LocalPlayer.Character and LocalPlayer.Character.PrimaryPart and SavedCFrame then
			LocalPlayer.Character.PrimaryPart.CFrame = SavedCFrame
		end
	end
})

MainGroup:AddToggle("ToggleInvisibilityMimic", {
	Text = "Invisible Killer", Default = false,
	Callback = function(state)
		InvisibilityKiller = state
		ApplyInvisibility(state)
	end
})

MainGroup:AddToggle("NoCooldownpromptToggle", {
	Text = "Instant Prompt", Default = false,
	Callback = function(Value)
		ActiveNoCooldownPrompt = Value
		task.spawn(function()
			if ActiveNoCooldownPrompt then
				for _, p in pairs(workspace:GetDescendants()) do
					if p:IsA("ProximityPrompt") and p.HoldDuration ~= 0.1 then
						p:SetAttribute("HoldDurationOld", p.HoldDuration)
						p.HoldDuration = 0.1
					end
				end
			else
				for _, p in pairs(workspace:GetDescendants()) do
					if p:IsA("ProximityPrompt") and p:GetAttribute("HoldDurationOld") then
						p.HoldDuration = p:GetAttribute("HoldDurationOld")
					end
				end
			end
		end)
	end
})

local function Noclip()
	local char = LocalPlayer.Character
	if not char then return end
	if ActiveNoclip then
		for _, p in pairs(char:GetDescendants()) do
			if p:IsA("BasePart") and p.CanCollide then
				if p:GetAttribute("OldCollide") == nil then p:SetAttribute("OldCollide", p.CanCollide) end
				p.CanCollide = false
			end
		end
	else
		for _, p in pairs(char:GetDescendants()) do
			if p:IsA("BasePart") and p:GetAttribute("OldCollide") ~= nil then
				p.CanCollide = p:GetAttribute("OldCollide")
			end
		end
	end
end

PlayerGroup:AddToggle("PlayerNoclipToggle", { Text = "Noclip", Default = false, Callback = function(v) ActiveNoclip = v; Noclip() end })
LocalPlayer:GetPropertyChangedSignal("Character"):Connect(function() Noclip() end)

PlayerGroup:AddSlider("PlayerSpeedSlider", { Text = "Run Speed", Min = 0, Max = 50, Default = 24, Rounding = 0, Callback = function(v) ValueRunSpeed = v end })
PlayerGroup:AddToggle("PlayerActiveModifyingSpeedToggle", { Text = "Active Modifying Run Speed", Default = false, Callback = function(v) ActiveSpeedBoost = v end })
MainGroup:AddSlider("HESlider", { Text = "Hitbox Size", Min = 0, Max = 30, Default = 15, Rounding = 0, Callback = function(v) ValueHE = v end })
MainGroup:AddToggle("HitboxExpenderToggle", { Text = "Active Hitbox Expender", Default = false, Callback = function(v) HitboxExpender = v end })
PlayerGroup:AddSlider("PlayerSpeedSlider2", { Text = "Walk Speed", Min = 0, Max = 50, Default = 15, Rounding = 0, Callback = function(v) ValueWalkSpeed = v end })
PlayerGroup:AddToggle("PlayerActiveModifyingSpeedToggle2", { Text = "Active Modifying Walk Speed", Default = false, Callback = function(v) ActiveSpeedBoost2 = v end })
PlayerGroup:AddSlider("PlayerJumpPowerSlider", { Text = "Jump Power", Min = 0, Max = 100, Default = 50, Rounding = 0, Callback = function(v) JumpPowerValue = v end })
PlayerGroup:AddToggle("PlayerActiveModifyingJumpPowerToggle", {
	Text = "Active Modifying Jump Power", Default = false,
	Callback = function(v)
		ActivateJumping = v
		local char = LocalPlayer.Character
		if char and char:FindFirstChildOfClass("Humanoid") then
			local hum = char:FindFirstChildOfClass("Humanoid")
			hum.UseJumpPower = ActivateJumping
			hum.JumpPower = JumpPowerValue
		end
	end
})
PlayerGroup:AddToggle("PlayerInfiniteStaminaToggle", { Text = "Infinite Stamina", Default = false, Callback = function(v) ActiveInfiniteStamina = v end })
MainGroup:AddToggle("BigDistancePromptToggle", { Text = "Big Distance Prompt", Default = false, Callback = function(v) ActiveBigPrompt = v end })
MainGroup:AddToggle("AutoAutoEscapeButton", { Text = "Auto Escape", Default = false, Callback = function(v) AutoEscape = v end })
MainGroup:AddToggle("AutoShakeButton", { Text = "Auto Shake Wire Eyes", Default = false, Callback = function(v) AutoShakeWireEyes = v end })
MainGroup:AddSlider("ShakeTimeSlider", { Text = "Wire eyes Shake time", Min = 0.1, Max = 1, Default = 0.5, Rounding = 1, Callback = function(v) ShakeTime = v end })
MainGroup:AddToggle("NoBlindnessButton", { Text = "No Blindness", Default = false, Callback = function(v) NoBlindness = v end })

SettingsGroup:AddButton({ Text = "Unload Cheat", Func = function() Library:Unload() end })
SettingsGroup:AddSlider("LimitRangerEspSlider", { Text = "Limit Ranger for esp", Min = 25, Max = 1000, Default = 100, Rounding = 0, Callback = function(v) LimitRangerEsp = v end })
SettingsGroup:AddToggle("DisableLimitRangerEspToggle", { Text = "Disable Limit Ranger Esp", Default = false, Callback = function(v) DisableLimitRangerEsp = v end })
SettingsGroup:AddToggle("DistanceEspToggle", { Text = "Activate Distance For Esp", Default = false, Callback = function(v) ActiveDistanceEsp = v end })
SettingsGroup:AddToggle("TraitToggle", { Text = "Trait for esp", Default = false, Callback = function(v) LineESPEnabled = v end })

local CanParry = true

workspace.DescendantAdded:Connect(function(child)
	if child:IsA("BoxHandleAdornment") and HitboxExpender then
		child.Size = Vector3.new(ValueHE, ValueHE, ValueHE)
	end
	
	task.wait(0.75)
	
	if ActiveNoCooldownPrompt and child:IsA("ProximityPrompt") and child.HoldDuration ~= 0.1 then
		child:SetAttribute("HoldDurationOld", child.HoldDuration)
		child.HoldDuration = 0.1
	end
	
	if ActiveEspSurvivors then
		local alive = workspace:FindFirstChild("PLAYERS") and workspace.PLAYERS:FindFirstChild("ALIVE")
		if alive and child.Parent == alive and child:IsA("Model") and child.PrimaryPart and not child.PrimaryPart:FindFirstChildOfClass("BillboardGui") then
			if Players:GetPlayerFromCharacter(child) then
				if child:FindFirstChildOfClass("Highlight") then child:FindFirstChildOfClass("Highlight"):Destroy() end
				SetupCharacter(child, alive, child.PrimaryPart)
				CreateEsp(child, Color3.fromRGB(0,255,0), child.Name.." "..child:GetAttribute("Character"), child.PrimaryPart, 2)
			end
		end
	end
	
	if ActiveEspKillers then
		local kFol = workspace:FindFirstChild("PLAYERS") and workspace.PLAYERS:FindFirstChild("KILLER")
		if kFol and child.Parent == kFol and child:IsA("Model") and child:FindFirstChild("RootPart") and not child.RootPart:FindFirstChildOfClass("BillboardGui") then
			if Players:GetPlayerFromCharacter(child) then
				local part = child:FindFirstChild("RootPart") or child:FindFirstChild("HumanoidRootPart")
				if child:GetAttribute("Character") == "Ennard" then part = child:FindFirstChild("HumanoidRootPart") end
				if child:FindFirstChildOfClass("Highlight") then child:FindFirstChildOfClass("Highlight"):Destroy() end
				SetupCharacter(child, kFol, part)
				CreateEsp(child, Color3.fromRGB(255,0,0), child.Name.." "..child:GetAttribute("Character"), part, 2)
			end
		end
	end
	
	if ActiveEspGen then
		local map = workspace.MAPS:FindFirstChild("GAME MAP")
		if map and child.Parent == map:FindFirstChild("Generators") and child:IsA("Model") and child.PrimaryPart and not child:FindFirstChildOfClass("Highlight") and not child.PrimaryPart:FindFirstChildOfClass("BillboardGui") then
			CreateEsp(child, Color3.fromRGB(255,255,0), "Generator", child.PrimaryPart, 2)
		end
	end
	
	if ActiveEspFuseBoxes then
		local map = workspace.MAPS:FindFirstChild("GAME MAP")
		if map and child.Parent == map:FindFirstChild("FuseBoxes") and child:IsA("Model") and child.PrimaryPart and not child.PrimaryPart:FindFirstChildOfClass("BillboardGui") then
			if child:FindFirstChildOfClass("Highlight") then child:FindFirstChildOfClass("Highlight"):Destroy() end
			CreateEsp(child, Color3.fromRGB(0,0,255), "Fuse Box", child.PrimaryPart, 2)
		end
	end
	
	if ActiveEspTraps then
		if child.Parent == workspace.IGNORE and child.Name == "Trap" and child:IsA("Model") and child.PrimaryPart and not child.PrimaryPart:FindFirstChildOfClass("BillboardGui") then
			if child:FindFirstChildOfClass("Highlight") then child:FindFirstChildOfClass("Highlight"):Destroy() end
			CreateEsp(child, Color3.fromRGB(255,0,0), "Trap", child.PrimaryPart, 2)
		end
	end
	
	if ActiveEspWireEyes then
		if child.Parent == workspace.IGNORE and child.Name == "Minion" and child:IsA("Model") and child.PrimaryPart and not child.PrimaryPart:FindFirstChildOfClass("BillboardGui") then
			if child:FindFirstChildOfClass("Highlight") then child:FindFirstChildOfClass("Highlight"):Destroy() end
			SetupCharacter(child, workspace.IGNORE, child.PrimaryPart)
			CreateEsp(child, Color3.fromRGB(255,0,0), "Wire Eyes", child.PrimaryPart, 2)
		end
	end
	
	if ActiveEspBattery then
		if child.Parent == workspace.IGNORE and child.Name == "Battery" and child:IsA("BasePart") and not child:FindFirstChildOfClass("BillboardGui") then
			if child:FindFirstChildOfClass("Highlight") then child:FindFirstChildOfClass("Highlight"):Destroy() end
			CreateEsp(child, Color3.fromRGB(0,0,255), "Battery", child, 2)
		end
	end
end)

RunService.Heartbeat:Connect(function()
	if not FighterAutoParry or not CanParry then return end
	
	local char = LocalPlayer.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then return end
	local hrp = char.HumanoidRootPart
	
	if char:GetAttribute("IFrames") or char:GetAttribute("InAbility") or char:GetAttribute("Stun") then return end
	if char:GetAttribute("Team") ~= "Survivor" or char:GetAttribute("Character") ~= "Survivor-Fighter" then return end
	
	local kFol = workspace:FindFirstChild("PLAYERS") and workspace.PLAYERS:FindFirstChild("KILLER")
	if not kFol then return end
	
	for _, k in ipairs(kFol:GetChildren()) do
		if k:IsA("Model") and k:FindFirstChild("Highlight") then
			local root = k:FindFirstChild("RootPart") or k:FindFirstChild("HumanoidRootPart")
			if root and (root.Position - hrp.Position).Magnitude <= ParryDistance then
				CanParry = false
				task.spawn(function()
					local wMod = game:GetService("ReplicatedStorage").Modules:FindFirstChild("Warp")
					if wMod then
						local s, m = pcall(require, wMod)
						if s and m.Client then m.Client("Input"):Fire(true, {"Ability", 2}) end
					end
				end)
				task.delay(0.5, function() CanParry = true end)
				break
			end
		end
	end
end)

workspace.DescendantRemoving:Connect(function(child)
	if child:IsA("Model") then
		local alive = workspace:FindFirstChild("PLAYERS") and workspace.PLAYERS:FindFirstChild("ALIVE")
		local kFol = workspace:FindFirstChild("PLAYERS") and workspace.PLAYERS:FindFirstChild("KILLER")
		local map = workspace.MAPS:FindFirstChild("GAME MAP")
		
		if ActiveEspSurvivors and alive and child:IsDescendantOf(alive) and child.PrimaryPart then
			if child:FindFirstChildOfClass("Highlight") and child.PrimaryPart:FindFirstChildOfClass("BillboardGui") then
				KeepEsp(child, child.PrimaryPart)
			end
		end
		
		if ActiveEspKillers and kFol and child:IsDescendantOf(kFol) then
			local part = child:FindFirstChild("RootPart") or child:FindFirstChild("HumanoidRootPart")
			if child:GetAttribute("Character") == "Ennard" then part = child:FindFirstChild("HumanoidRootPart") end
			if part and child:FindFirstChildOfClass("Highlight") and part:FindFirstChildOfClass("BillboardGui") then
				KeepEsp(child, part)
			end
		end
		
		if ActiveEspGen and map and map:FindFirstChild("Generators") and child:IsDescendantOf(map.Generators) and child.PrimaryPart then
			if child:FindFirstChildOfClass("Highlight") and child.PrimaryPart:FindFirstChildOfClass("BillboardGui") then
				KeepEsp(child, child.PrimaryPart)
			end
		end
		
		if ActiveEspFuseBoxes and map and map:FindFirstChild("FuseBoxes") and child:IsDescendantOf(map.FuseBoxes) and child.PrimaryPart then
			if child:FindFirstChildOfClass("Highlight") and child.PrimaryPart:FindFirstChildOfClass("BillboardGui") then
				KeepEsp(child, child.PrimaryPart)
			end
		end
		
		if ActiveEspTraps and child:IsDescendantOf(workspace.IGNORE) and child.Name == "Traps" and child.PrimaryPart then
			if child:FindFirstChildOfClass("Highlight") and child.PrimaryPart:FindFirstChildOfClass("BillboardGui") then
				KeepEsp(child, child.PrimaryPart)
			end
		end
		
		if ActiveEspWireEyes and child:IsDescendantOf(workspace.IGNORE) and child.Name == "Minion" and child.PrimaryPart then
			if child:FindFirstChildOfClass("Highlight") and child.PrimaryPart:FindFirstChildOfClass("BillboardGui") then
				KeepEsp(child, child.PrimaryPart)
			end
		end
		
	elseif child:IsA("BasePart") then
		if ActiveEspBattery and child:IsDescendantOf(workspace.IGNORE) and child.Name == "Battery" then
			if child:FindFirstChildOfClass("Highlight") and child:FindFirstChildOfClass("BillboardGui") then
				KeepEsp(child, child)
			end
		end
	end
end)

SettingsGroup:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", { Default = "RightShift", NoUI = true, Text = "Menu keybind" })
Library.ToggleKeybind = Library.Options.MenuKeybind

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ "MenuKeybind" })

ThemeManager:SetFolder("GoatHub")
SaveManager:SetFolder("GoatHub/BiteByNight")

SaveManager:BuildConfigSection(Tabs.Settings)
ThemeManager:ApplyToTab(Tabs.Settings)

SaveManager:LoadAutoloadConfig()
