local WindUI

do
	local ok, result = pcall(function()
		return require("./src/Init")
	end)

	if ok then
		WindUI = result
	else
		if cloneref(game:GetService("RunService")):IsStudio() then
			WindUI = require(cloneref(ReplicatedStorage:WaitForChild("WindUI"):WaitForChild("Init")))
		else
			WindUI =
				loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
		end
	end
end

local isHighlightActive = false

local toolhighlightactive = false

local hawktuahactive = false

local isCorruptNatureEspActive = false

local isSurvivorUtilEspActive = false

local run = false

local delay

local isSurvivorHighlightActive = false

local givepizza = false

local connections = {}

local isKillerHighlightActive = false

local hideplayerbar = false

local VirtualBallsManager = game:GetService('VirtualInputManager')

local jumppowerenabled = false

local survivorutil = {
    "007n7",
    "BuildermanSentry",
    "BuildermanDispenser",
    "Pizza",
    "BuildermanSentryEffectRange"
}





local aimbot1x1sounds = {
    "rbxassetid://79782181585087",
    "rbxassetid://128711903717226"
}

local chanceaimbotsounds = {
    "rbxassetid://201858045",
    "rbxassetid://139012439429121"
}

local johnaimbotsounds = {
    "rbxassetid://109525294317144"
}

local jasonaimbotsounds = {
    "rbxassetid://112809109188560",
    "rbxassetid://102228729296384"
}

local shedaimbotsounds = {
    "rbxassetid://12222225",
    "rbxassetid://83851356262523"
}

local guestsounds = {
    "rbxassetid://609342351"
}

local hawktuahactivatesound = {
    "rbxassetid://110759725172567"
}

local hakariactive = false

local quietactive = false

local stam = false

local connection

local chanceaim = false

local chanceaimbotLoop

local jasonaimbotloop

local genshouldloop = false

local genactive = false

local aimbot1x1loop

local johnloop

local guestloop

local shedloop

local aimbot1x1 = false

local johnaim = false

local connection

local jasonaim = false

local shedaim = false

local guestaim = false

local Window = WindUI:CreateWindow({
	Title = "Chill Hub | Forsaken",
	Author = "By Happy thukuna",
	Folder = "Chill Hub",
	Icon = "",
	Theme = "Sky",
	IconSize = 21*1,
	Size = UDim2.fromOffset(600,500),
    HideSearchBar = false
})

local players = {}
for i, v in pairs(game:GetService("Players"):GetChildren()) do
    table.insert(players, v.Name)
end
table.sort(players)

local themes = {}
for themeName, _ in pairs(WindUI:GetThemes()) do
    table.insert(themes, themeName)
end
table.sort(themes)

Window.User:Enable()

local player = game.Players.LocalPlayer

local HomeTab = Window:Tab({Title = "Home", Icon = "house"})
local MainTab = Window:Tab({Title = "Main", Icon = "bolt"})
local MiscTab = Window:Tab({Title = "Misc", Icon = "book-open"})
local GeneratorTab = Window:Tab({Title = "Generator", Icon = "box"})
local PlayerTab = Window:Tab({Title = "Player", Icon = "user"})
local VisualTab = Window:Tab({Title = "Visuals", Icon = "eye"})
local AimbotTab = Window:Tab({Title = "Aimbot", Icon = "sword"})
local CombatTab = Window:Tab({Title = "Combat", Icon = "axe"})
local SettingsTab = Window:Tab({Title = "Settings", Icon = "settings"})

HomeTab:Section({Title = "Made by Happy Thukuna", Icon = ""})

MainTab:Section({Title = "Teleport"})

MainTab:Paragraph({Title = "Fixed Auto teleport players.", Desc = "auto teleport other player, can't cilck false becuase error, please click you name ("..player.Name..") and has to been stopped."})

MainTab:Dropdown({
    Title = "Select Teleport Player",
    Values = players,
    SearchBarEnabled = true,
    Value = players,
    Callback = function(option)
       upinnipu = option
    end
})

MainTab:Button({
    Title = "Script Teleport to Players",
    Desc = "if you want to Teleport player, if you got auto teleport others, click yourself name.",
    Callback = function()
     local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()
players = {}
 
for i,v in pairs(game:GetService("Players"):GetChildren()) do
   table.insert(players,v.Name)
end
local Window = OrionLib:MakeWindow({Name = "Yameme Hub [Teleport Players]", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})
local Tab = Window:MakeTab({
	Name = "Players",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab:AddDropdown({
	Name = "[ let teleport with player >:) ]",
	Default = players,
	Options = players,
	Callback = function(abc)
		Select = abc
	end    
})

Tab:AddButton({
	Name = "Start",
	Callback = function()
	while wait() do
      		 game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[Select].Character.HumanoidRootPart.CFrame
  	end
	  end    
})

Tab:AddButton({
	Name = "Stop",
	Callback = function()
      		 table.clear(players)
for i,v in pairs(game:GetService("Players"):GetChildren()) do
   table.insert(players,v.Name)
end
  	end    
})
    end
})

MainTab:Button({
    Title = "Teleport to Players",
    Desc = "make teleport player.",
    Callback = function()
    player.Character.HumanoidRootPart.CFrame = game.Players[upinnipu].Character.HumanoidRootPart.CFrame
       
     
    end
})

MainTab:Toggle({
    Title = "Auto Teleport to Players",
    Desc = "make teleport player.",
    Callback = function(state)
    if state then
        WindUI:Notify({ 
                    Title = "Error", 
                    Content = "Auto Teleport to Player has been error script meanwhile.",
                    Icon = "x",
                    Duration = 3
                })
        warn("Auto Teleport to Player - error script require meanwhile.")
    end
    end
})

MainTab:Section({Title = "Teleport Items"})

MainTab:Button({
    Title = "Bring all",
    Desc = "Take a for everything.",
    Callback = function()
       all = {}
       for i, v in pairs(workspace.Map.Ingame.Map:GetDescendants()) do
           table.insert(all, v)
        end

        for i, v in pairs(all) do
            if v.Name == "Medkit" and v.Name == "BloxyCola" then
                v.ItemRoot.CFrame = player.Character.HumanoidRootPart.CFrame
            end
        end
    end
})

MainTab:Button({
    Title = "Teleport to Medkit",
    Desc = "Take yourself.",
    Callback = function()
       local medkit = workspace.Map.Ingame.Map.Medkit.ItemRoot
       player.Character.HumanoidRootPart.CFrame = medkit.CFrame
    end
})

MainTab:Button({
    Title = "Teleport to Bloxy Cola",
    Desc = "Take yourself.",
    Callback = function()
       fakeloxy = workspace.Map.Ingame.Map.BloxyCola.ItemRoot
       player.Character.HumanoidRootPart.CFrame = fakeloxy.CFrame
    end
})

MiscTab:Section({Title = "Achievements"})

MiscTab:Paragraph({Title = "Unlock Achievements.", Desc = "if you want to clicker unlock Achievements all."})

MiscTab:Button({
    Title = "Unlocked Achievements all",
    Desc = "unlocked everything.",
    Callback = function()
        player.PlayerData.Achievements.General.SurvivorWins1.Value = "9999"
        player.PlayerData.Achievements.General.SurvivorWins2.Value = "9999"
        player.PlayerData.Achievements.General.SurvivorWins3.Value = "9999"
        player.PlayerData.Achievements.General.SurvivorWins4.Value = "9999"
        player.PlayerData.Achievements.General.SurvivorWins5.Value = "9999"
        print("inf level")

        player.PlayerData.Achievements.General.KillerWins1.Value = "9999"
        player.PlayerData.Achievements.General.KillerWins2.Value = "9999"
        player.PlayerData.Achievements.General.KillerWins3.Value = "9999"
        player.PlayerData.Achievements.General.KillerWins4.Value = "9999"
        player.PlayerData.Achievements.General.KillerWins5.Value = "9999"
        print("inf level")

        for i, v in pairs(player.PlayerData.Achievements.Challenges:GetDescendants()) do
           if v.Name then
               v.Value = true
           end
        end
        print("unknowj")

        for i, v in pairs(player.PlayerData.Achievements.Fun:GetDescendants()) do
           if v.Name then
               v.Value = true
           end
        end
        print("unknowj")

        for i, v in pairs(player.PlayerData.Achievements.KillerSpecific:GetDescendants()) do
           if v.Name then
               v.Value = true
           end
        end
        print("unknowj")

        for i, v in pairs(player.PlayerData.Achievements.SurvivorSpecific:GetDescendants()) do
           if v.Name then
               v.Value = true
           end
        end
        print("unknowj")

        for i, v in pairs(player.PlayerData.Achievements.Completionist:GetDescendants()) do
           if v.Name then
               v.Value = 99999
           end
        end
        print("unknowj")

        for i, v in pairs(player.PlayerData.Achievements.SurvivorMilestones:GetDescendants()) do
           if v.Name then
               v.Value = 99999
           end
        end
        print("unknowj")

        for i, v in pairs(player.PlayerData.Achievements.KillerMilestones:GetDescendants()) do
           if v.Name then
               v.Value = 99999
           end
        end
        print("unknowj")
    end
})

MiscTab:Divider()

MiscTab:Button({
    Title = "Infinite Win Survivor all",
    Desc = "Make Level Win Survivor to been infinite.",
    Callback = function()
        player.PlayerData.Achievements.General.SurvivorWins1.Value = "9999"
        player.PlayerData.Achievements.General.SurvivorWins2.Value = "9999"
        player.PlayerData.Achievements.General.SurvivorWins3.Value = "9999"
        player.PlayerData.Achievements.General.SurvivorWins4.Value = "9999"
        player.PlayerData.Achievements.General.SurvivorWins5.Value = "9999"
        print("inf level")
    end
})

MiscTab:Button({
    Title = "Infinite Win Killers all",
    Desc = "Make Level Win Killers to been infinite.",
    Callback = function()
        player.PlayerData.Achievements.General.KillerWins1.Value = "9999"
        player.PlayerData.Achievements.General.KillerWins2.Value = "9999"
        player.PlayerData.Achievements.General.KillerWins3.Value = "9999"
        player.PlayerData.Achievements.General.KillerWins4.Value = "9999"
        player.PlayerData.Achievements.General.KillerWins5.Value = "9999"
        print("inf level")
    end
})

MiscTab:Divider()

MiscTab:Button({
    Title = "Unlocked Challenges Survivor all",
    Desc = "Make Unlock Challenges.",
    Callback = function()
        for i, v in pairs(player.PlayerData.Achievements.Challenges:GetDescendants()) do
           if v.Name then
               v.Value = true
           end
        end
        print("unknowj")
    end
})

MiscTab:Divider()

MiscTab:Button({
    Title = "Unlocked Survivor Specifie all",
    Desc = "Make Unlock all.",
    Callback = function()
        for i, v in pairs(player.PlayerData.Achievements.SurvivorSpecific:GetDescendants()) do
           if v.Name then
               v.Value = true
           end
        end
        print("unknowj")
    end
})

MiscTab:Button({
    Title = "Unlocked Killer Specifie all",
    Desc = "Make Unlock all.",
    Callback = function()
        for i, v in pairs(player.PlayerData.Achievements.KillerSpecific:GetDescendants()) do
           if v.Name then
               v.Value = true
           end
        end
        print("unknowj")
    end
})

MiscTab:Divider()

MiscTab:Button({
    Title = "Unlocked Fun all",
    Desc = "Make Unlock all.",
    Callback = function()
        for i, v in pairs(player.PlayerData.Achievements.Fun:GetDescendants()) do
           if v.Name then
               v.Value = true
           end
        end
        print("unknowj")
    end
})

MiscTab:Divider()

MiscTab:Button({
    Title = "Unlocked Completionist all",
    Desc = "Make Unlock all.",
    Callback = function()
        for i, v in pairs(player.PlayerData.Achievements.Completionist:GetDescendants()) do
           if v.Name then
               v.Value = 9999
           end
        end
        print("unknowj")
    end
})

MiscTab:Divider()

MiscTab:Button({
    Title = "Infinite Level Survivor Milestones all",
    Desc = "Make Unlock all.",
    Callback = function()
        for i, v in pairs(player.PlayerData.Achievements.SurvivorsMilestones:GetDescendants()) do
           if v.Name then
               v.Value = 9999
           end
        end
        print("unknowj")
    end
})

MiscTab:Button({
    Title = "Infinite Level Killer Milestones all",
    Desc = "Make Unlock all.",
    Callback = function()
        for i, v in pairs(player.PlayerData.Achievements.KillersMilestones:GetDescendants()) do
           if v.Name then
               v.Value = 9999
           end
        end
        print("unknowj")
    end
})

MiscTab:Section({Title = "Others"})

MiscTab:Button({
    Title = "Infinite Level Survivor",
    Desc = "make infinite Level survivor.",
    Callback = function()
        for i, v in pairs(player.PlayerData.Stats.SurvivorStats:GetDescendants()) do
           if v.Name then
               v.Value = 9999
           end
        end
        print("unknowj")
    end
})

MiscTab:Button({
    Title = "Infinite Level Killer",
    Desc = "make infinite Level killer.",
    Callback = function()
        for i, v in pairs(player.PlayerData.Stats.KillerStats:GetDescendants()) do
           if v.Name then
               v.Value = 9999
           end
        end
        print("unknowj")
    end
})

MiscTab:Button({
    Title = "Infinite Level Currency",
    Desc = "make infinite Level currency.",
    Callback = function()
        for i, v in pairs(player.PlayerData.Stats.Currency:GetDescendants()) do
           if v.Name then
               v.Value = 9999999
           end
        end
        print("unknowj")
    end
})

MiscTab:Button({
    Title = "Infinite Level General",
    Desc = "make infinite Level general.",
    Callback = function()
    while wait() do
        for i, v in pairs(player.PlayerData.Stats.General:GetDescendants()) do
           if v.Name then
               v.Value = 9999999999999
           end
        end
    end
        print("unknowj")
    end
})

GeneratorTab:Section({Title = "Instant Generator"})

GeneratorTab:Paragraph({
    Title = "Instant Generator",
    Desc = "only slow, if you clicker likes fast, you got a kicked.",
})

GeneratorTab:Button({
    Title = "Instant Generator",
    Desc = "instant to generator.",
    Callback = function()
       for i, v in pairs(game.Workspace.Map.Ingame.Map:GetChildren()) do
            if v.name == "Generator" then
                v:WaitForChild("Remotes"):WaitForChild("RE"):FireServer()
            end
        end
    end
})

GeneratorTab:Keybind({
    Title = "Instant Generator solvet",
    Desc = "instant to solvet",
    Key = "H",
    Callback = function()
        for i, v in pairs(game.Workspace.Map.Ingame.Map:GetChildren()) do
            if v.name == "Generator" then
                v:WaitForChild("Remotes"):WaitForChild("RE"):FireServer()
            end
        end
    end
})

GeneratorTab:Section({Title = "Required Generator"})

GeneratorTab:Paragraph({
    Title = "Required Generator",
    Desc = "do not slider 0 - 4.9, you get kicked, only 5 - 15 can with no kicked.",
})

GeneratorTab:Slider({
    Title = "Required Generator",
    Value = { Min = 0, Max = 15, Default = 10 },
    Callback = function(value)
        gay = value
    end
})

GeneratorTab:Toggle({
    Title = "Auto Generator",
    Desc = "Auto to required generator.",
    Callback = function(state)
     local debounce = {}
        while state do
            task.wait(gay)
            for _, v in pairs(game.Workspace.Map.Ingame.Map:GetChildren()) do
                if v.Name == "Generator" then
                    
                    if not debounce[v] then
                        debounce[v] = true
                        v:WaitForChild("Remotes"):WaitForChild("RE"):FireServer()
                        task.delay(delay, function() debounce[v] = nil end)
                    end
                end
            end
        end
    end
})

GeneratorTab:Divider()

GeneratorTab:Toggle({
    Title = "Auto Generator 5s",
    Desc = "Auto to required generator 5s.",
    Callback = function(state)
     local debounce = {}
        while state do
            task.wait(5)
            for _, v in pairs(game.Workspace.Map.Ingame.Map:GetChildren()) do
                if v.Name == "Generator" then
                    
                    if not debounce[v] then
                        debounce[v] = true
                        v:WaitForChild("Remotes"):WaitForChild("RE"):FireServer()
                        task.delay(delay, function() debounce[v] = nil end)
                    end
                end
            end
        end
    end
})

GeneratorTab:Toggle({
    Title = "Auto Generator 10s",
    Desc = "Auto to required generator 10s.",
    Callback = function(state)
     local debounce = {}
        while state do
            task.wait(10)
            for _, v in pairs(game.Workspace.Map.Ingame.Map:GetChildren()) do
                if v.Name == "Generator" then
                    
                    if not debounce[v] then
                        debounce[v] = true
                        v:WaitForChild("Remotes"):WaitForChild("RE"):FireServer()
                        task.delay(delay, function() debounce[v] = nil end)
                    end
                end
            end
        end
    end
})

GeneratorTab:Toggle({
    Title = "Auto Generator 15s",
    Desc = "Auto to required generator 15s.",
    Callback = function(state)
     local debounce = {}
        while state do
            task.wait(15)
            for _, v in pairs(game.Workspace.Map.Ingame.Map:GetChildren()) do
                if v.Name == "Generator" then
                    
                    if not debounce[v] then
                        debounce[v] = true
                        v:WaitForChild("Remotes"):WaitForChild("RE"):FireServer()
                        task.delay(delay, function() debounce[v] = nil end)
                    end
                end
            end
        end
    end
})

MainTab:Section({Title = "Animation"})

MainTab:Paragraph({
    Title = "Emote Animation",
    Desc = "I been Coming soon to make all emote, anti paid.",
})

MainTab:Dropdown({
    Title = "Select Animation",
    Values = {"Hakari Dance", "Lag Train (New Emotes)", "Po-Ppi-po (New Emotes)", "Dance Alone (New Emotes)", "Wait", "Wave", "Miss Out Quiet (Outdated)", "Shucks", "[OLD] Hakari Dance", "Jumpstyle", "Sukuna", "Hotdog", "Chicken Dance", "Eggrolled", "Silly", "Pop Dance"},
    SearchBarEnabled = true,
    Value = "Hakari Dance",
    Callback = function(Select)
       abc = Select
    end
})

MainTab:Toggle({
    Title = "Start/Stop Animation",
    Desc = "Make you're dance with free emote.",
    Callback = function(state)
    
    
    if abc == "Hakari Dance" then
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
    
        if state then
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
    
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
    
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://138019937280193"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
    
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://109474987384441"
            sound.Parent = rootPart
            sound.Volume = 1
            sound.Looped = true
            sound:Play()
    
            local effect = game.ReplicatedStorage.Assets.Emotes.HakariDance.HakariBeamEffect:Clone()
            effect.Name = "PlayerEmoteVFX"
            effect.CFrame = char.PrimaryPart.CFrame * CFrame.new(0, -1, -0.3)
            effect.WeldConstraint.Part0 = char.PrimaryPart
            effect.WeldConstraint.Part1 = effect
            effect.Parent = char
            effect.CanCollide = false
    
            local args = {
                [1] = "PlayEmote",
                [2] = "Animations",
                [3] = "HakariDance"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
            end)
        else
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0 
    
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
    
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
    
            local effect = char:FindFirstChild("PlayerEmoteVFX")
            if effect then
                effect:Destroy()
            end
    
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://138019937280193" then
                    track:Stop()
                end
            end
        end
    end

if abc == "Po-Ppi-Po" then
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
    
        if state then
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
    
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
    
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://138019937280193"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
    
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://88477898725659"
            sound.Parent = rootPart
            sound.Volume = 1
            sound.Looped = true
            sound:Play()
    
            local effect = game.ReplicatedStorage.Assets.Emotes.HakariDance.HakariBeamEffect:Clone()
            effect.Name = "PlayerEmoteVFX"
            effect.CFrame = char.PrimaryPart.CFrame * CFrame.new(0, -1, -0.3)
            effect.WeldConstraint.Part0 = char.PrimaryPart
            effect.WeldConstraint.Part1 = effect
            effect.Parent = char
            effect.CanCollide = false
    
            local args = {
                [1] = "PlayEmote",
                [2] = "Animations",
                [3] = "HakariDance"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
            end)
        else
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0 
    
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
    
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
    
            local effect = char:FindFirstChild("PlayerEmoteVFX")
            if effect then
                effect:Destroy()
            end
    
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://138019937280193" then
                    track:Stop()
                end
            end
        end
    end
    
if abc == "[OLD] Hakari Dance" then
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
    
        if state then
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
    
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
    
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://138019937280193"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
    
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://88477898725659"
            sound.Parent = rootPart
            sound.Volume = 1
            sound.Looped = true
            sound:Play()
    
            local effect = game.ReplicatedStorage.Assets.Emotes.HakariDance.HakariBeamEffect:Clone()
            effect.Name = "PlayerEmoteVFX"
            effect.CFrame = char.PrimaryPart.CFrame * CFrame.new(0, -1, -0.3)
            effect.WeldConstraint.Part0 = char.PrimaryPart
            effect.WeldConstraint.Part1 = effect
            effect.Parent = char
            effect.CanCollide = false
    
            local args = {
                [1] = "PlayEmote",
                [2] = "Animations",
                [3] = "HakariDance"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
            end)
        else
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0 
    
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
    
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
    
            local effect = char:FindFirstChild("PlayerEmoteVFX")
            if effect then
                effect:Destroy()
            end
    
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://138019937280193" then
                    track:Stop()
                end
            end
        end
    end
    
    if abc == "Sukuna" then
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
    
        if state then
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
    
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
    
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://112276030300130"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
    
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://137906124003434"
            sound.Parent = rootPart
            sound.Volume = 1
            sound.Looped = true
            sound:Play()

            local effect = game.ReplicatedStorage.Assets.Emotes.Sukuna.DismantleFX:Clone()
            effect.Name = "PlayerEmoteVFX"
            effect.CFrame = char.PrimaryPart.CFrame * CFrame.new(0, -1, -0.3)
            effect.WeldConstraint.Part0 = char.PrimaryPart
            effect.WeldConstraint.Part1 = effect
            effect.Parent = char
            effect.CanCollide = false
    
            local args = {
                [1] = "PlayEmote",
                [2] = "Animations",
                [3] = "Sukuna"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
            end)
        else
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0 
    
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
    
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end

            local effect = char:FindFirstChild("PlayerEmoteVFX")
            if effect then
                effect:Destroy()
            end
    
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://112276030300130" then
                    track:Stop()
                end
            end
        end
    end

    if abc == "Hotdog" then
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
    
        if state then
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
    
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
    
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://70533211127594"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
    
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://75226719036096"
            sound.Parent = rootPart
            sound.Volume = 1
            sound.Looped = true
            sound:Play()
    
            local args = {
                [1] = "PlayEmote",
                [2] = "Animations",
                [3] = "Jumpstyle"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
            end)
        else
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0 
    
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
    
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
    
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://70533211127594" then
                    track:Stop()
                end
            end
        end
    end
    
     if abc == "Chicken Dance" then
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
    
        if state then
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
    
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
    
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://135702316328204"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
    
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://104235713087821"
            sound.Parent = rootPart
            sound.Volume = 1
            sound.Looped = true
            sound:Play()
    
            local args = {
                [1] = "PlayEmote",
                [2] = "Animations",
                [3] = "Chicken"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
            end)
        else
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0 
    
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
    
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
    
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://135702316328204" then
                    track:Stop()
                end
            end
        end
    end

    if abc == "Eggrolled" then
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
    
        if state then
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
    
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
    
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://93910549909381"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
    
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://131274843582926"
            sound.Parent = rootPart
            sound.Volume = 1
            sound.Looped = true
            sound:Play()
    
            local args = {
                [1] = "PlayEmote",
                [2] = "Animations",
                [3] = "Eggrolled"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
            end)
        else
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0 
    
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
    
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
    
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://93910549909381" then
                    track:Stop()
                end
            end
        end
    end

    if abc == "Pop Dance" then
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
    
        if state then
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
    
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
    
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://119907842673039"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
    
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://108553856293180"
            sound.Parent = rootPart
            sound.Volume = 1
            sound.Looped = true
            sound:Play()
    
            local args = {
                [1] = "PlayEmote",
                [2] = "Animations",
                [3] = "PopDance"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
            end)
        else
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0 
    
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
    
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
    
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://119907842673039" then
                    track:Stop()
                end
            end
        end
    end

    if abc == "Silly" then
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
    
        if state then
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
    
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
    
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://107716765704359"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
    
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://110142673940576"
            sound.Parent = rootPart
            sound.Volume = 1
            sound.Looped = true
            sound:Play()
    
            local args = {
                [1] = "PlayEmote",
                [2] = "Animations",
                [3] = "Eggrolled"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
            end)
        else
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0 
    
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
    
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
    
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://107716765704359" then
                    track:Stop()
                end
            end
        end
    end
    
    if abc == "Jumpstyle" then
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
    
        if state then
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
    
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
    
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://76148053209080"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
    
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://95018041323246"
            sound.Parent = rootPart
            sound.Volume = 1
            sound.Looped = true
            sound:Play()
    
            local args = {
                [1] = "PlayEmote",
                [2] = "Animations",
                [3] = "Jumpstyle"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
            end)
        else
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0 
    
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
    
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
    
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://76148053209080" then
                    track:Stop()
                end
            end
        end
    end

     if abc == "Lag Train (New Emotes)" then
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
    
        if state then
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
    
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
    
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://102222481833338"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
    
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://99999025144073"
            sound.Parent = rootPart
            sound.Volume = 1
            sound.Looped = true
            sound:Play()
    
            local args = {
                [1] = "PlayEmote",
                [2] = "Animations",
                [3] = "LagTrain"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
            end)
        else
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0 
    
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
    
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
    
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://102222481833338" then
                    track:Stop()
                end
            end
        end
    end

    if abc == "Po-Ppi-po (New Emotes)" then
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
    
        if state then
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
    
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
    
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://121015083880066"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
    
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://90648332675114"
            sound.Parent = rootPart
            sound.Volume = 1
            sound.Looped = true
            sound:Play()
    
            local args = {
                [1] = "PlayEmote",
                [2] = "Animations",
                [3] = "PoPpiPo"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
            end)
        else
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0 
    
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
    
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
    
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://121015083880066" then
                    track:Stop()
                end
            end
        end
    end


     if abc == "Wave" then
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
    
        if state then
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
    
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
    
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://128777973"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
    
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://154865749"
            sound.Parent = rootPart
            sound.Volume = 1
            sound.Looped = false
            sound:Play()
    
            local args = {
                [1] = "PlayEmote",
                [2] = "Animations",
                [3] = "Wait"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
            end)
        else
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0 
    
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
    
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
    
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://128777973" then
                    track:Stop()
                end
            end
        end
    end

    if abc == "Dance Alone (New Emotes)" then
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
    
        if state then
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
    
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
    
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://118913772889490"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
    
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://128503211488531"
            sound.Parent = rootPart
            sound.Volume = 1
            sound.Looped = false
            sound:Play()
    
            local args = {
                [1] = "PlayEmote",
                [2] = "Animations",
                [3] = "Wait"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
            end)
        else
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0 
    
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
    
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
    
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://118913772889490" then
                    track:Stop()
                end
            end
        end
    end

    if abc == "Wait" then
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
    
        if state then
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
    
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
    
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://119813505721636"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
    
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://123179402505565"
            sound.Parent = rootPart
            sound.Volume = 1
            sound.Looped = true
            sound:Play()
    
            local args = {
                [1] = "PlayEmote",
                [2] = "Animations",
                [3] = "Wait"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
            end)
        else
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0 
    
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
    
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
    
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://119813505721636" then
                    track:Stop()
                end
            end
        end
    end

    if abc == "Shucks" then
         local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
    
        if state then
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
        
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
        
           
            local emoteScript = require(game:GetService("ReplicatedStorage").Assets.Emotes.Shucks)
            emoteScript.Created({Character = char})
        
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://74238051754912"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
        
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://123236721947419"
            sound.Parent = rootPart
            sound.Volume = 0.5
            sound.Looped = false
            sound:Play()
        
            local args = {
                [1] = "PlayEmote",
                [2] = "Animations",
                [3] = "Shucks"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
        
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
        
                
                local saw = char:FindFirstChild("Saw")
                if saw then saw:Destroy() end
        
                local playerHand = char:FindFirstChild("PlayerEmoteHand")
                if playerHand then playerHand:Destroy() end
            end)
        else
    
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0
    
            local saw = char:FindFirstChild("Saw")
            if saw then saw:Destroy() end
    
            local playerHand = char:FindFirstChild("PlayerEmoteHand")
            if playerHand then playerHand:Destroy() end
    
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
    
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
    
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://74238051754912" then
                    track:Stop()
                end
            end
        end
    end

    end
})

MainTab:Keybind({
    Title = "Start/Stop Animation (Something went wrong)",
    Desc = "Make you're dance with free emote.",
    Value = "E",
    Callback = function(state)
    
    
    if abc == "Hakari Dance" then
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
    
        if state then
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
    
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
    
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://138019937280193"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
    
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://109474987384441"
            sound.Parent = rootPart
            sound.Volume = 1
            sound.Looped = true
            sound:Play()
    
            local effect = game.ReplicatedStorage.Assets.Emotes.HakariDance.HakariBeamEffect:Clone()
            effect.Name = "PlayerEmoteVFX"
            effect.CFrame = char.PrimaryPart.CFrame * CFrame.new(0, -1, -0.3)
            effect.WeldConstraint.Part0 = char.PrimaryPart
            effect.WeldConstraint.Part1 = effect
            effect.Parent = char
            effect.CanCollide = false
    
            local args = {
                [1] = "PlayEmote",
                [2] = "Animations",
                [3] = "HakariDance"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
            end)
        else
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0 
    
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
    
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
    
            local effect = char:FindFirstChild("PlayerEmoteVFX")
            if effect then
                effect:Destroy()
            end
    
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://138019937280193" then
                    track:Stop()
                end
            end
        end
    end

if abc == "Po-Ppi-Po" then
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
    
        if state then
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
    
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
    
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://138019937280193"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
    
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://88477898725659"
            sound.Parent = rootPart
            sound.Volume = 1
            sound.Looped = true
            sound:Play()
    
            local effect = game.ReplicatedStorage.Assets.Emotes.HakariDance.HakariBeamEffect:Clone()
            effect.Name = "PlayerEmoteVFX"
            effect.CFrame = char.PrimaryPart.CFrame * CFrame.new(0, -1, -0.3)
            effect.WeldConstraint.Part0 = char.PrimaryPart
            effect.WeldConstraint.Part1 = effect
            effect.Parent = char
            effect.CanCollide = false
    
            local args = {
                [1] = "PlayEmote",
                [2] = "Animations",
                [3] = "HakariDance"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
            end)
        else
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0 
    
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
    
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
    
            local effect = char:FindFirstChild("PlayerEmoteVFX")
            if effect then
                effect:Destroy()
            end
    
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://138019937280193" then
                    track:Stop()
                end
            end
        end
    end
    
if abc == "[OLD] Hakari Dance" then
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
    
        if state then
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
    
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
    
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://138019937280193"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
    
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://88477898725659"
            sound.Parent = rootPart
            sound.Volume = 1
            sound.Looped = true
            sound:Play()
    
            local effect = game.ReplicatedStorage.Assets.Emotes.HakariDance.HakariBeamEffect:Clone()
            effect.Name = "PlayerEmoteVFX"
            effect.CFrame = char.PrimaryPart.CFrame * CFrame.new(0, -1, -0.3)
            effect.WeldConstraint.Part0 = char.PrimaryPart
            effect.WeldConstraint.Part1 = effect
            effect.Parent = char
            effect.CanCollide = false
    
            local args = {
                [1] = "PlayEmote",
                [2] = "Animations",
                [3] = "HakariDance"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
            end)
        else
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0 
    
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
    
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
    
            local effect = char:FindFirstChild("PlayerEmoteVFX")
            if effect then
                effect:Destroy()
            end
    
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://138019937280193" then
                    track:Stop()
                end
            end
        end
    end
    
    if abc == "Sukuna" then
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
    
        if state then
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
    
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
    
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://112276030300130"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
    
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://137906124003434"
            sound.Parent = rootPart
            sound.Volume = 1
            sound.Looped = true
            sound:Play()

            local effect = game.ReplicatedStorage.Assets.Emotes.Sukuna.DismantleFX:Clone()
            effect.Name = "PlayerEmoteVFX"
            effect.CFrame = char.PrimaryPart.CFrame * CFrame.new(0, -1, -0.3)
            effect.WeldConstraint.Part0 = char.PrimaryPart
            effect.WeldConstraint.Part1 = effect
            effect.Parent = char
            effect.CanCollide = false
    
            local args = {
                [1] = "PlayEmote",
                [2] = "Animations",
                [3] = "Sukuna"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
            end)
        else
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0 
    
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
    
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end

            local effect = char:FindFirstChild("PlayerEmoteVFX")
            if effect then
                effect:Destroy()
            end
    
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://112276030300130" then
                    track:Stop()
                end
            end
        end
    end

    if abc == "Hotdog" then
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
    
        if state then
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
    
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
    
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://70533211127594"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
    
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://75226719036096"
            sound.Parent = rootPart
            sound.Volume = 1
            sound.Looped = true
            sound:Play()
    
            local args = {
                [1] = "PlayEmote",
                [2] = "Animations",
                [3] = "Jumpstyle"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
            end)
        else
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0 
    
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
    
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
    
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://70533211127594" then
                    track:Stop()
                end
            end
        end
    end
    
     if abc == "Chicken Dance" then
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
    
        if state then
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
    
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
    
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://135702316328204"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
    
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://104235713087821"
            sound.Parent = rootPart
            sound.Volume = 1
            sound.Looped = true
            sound:Play()
    
            local args = {
                [1] = "PlayEmote",
                [2] = "Animations",
                [3] = "Chicken"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
            end)
        else
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0 
    
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
    
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
    
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://135702316328204" then
                    track:Stop()
                end
            end
        end
    end

    if abc == "Eggrolled" then
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
    
        if state then
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
    
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
    
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://93910549909381"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
    
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://131274843582926"
            sound.Parent = rootPart
            sound.Volume = 1
            sound.Looped = true
            sound:Play()
    
            local args = {
                [1] = "PlayEmote",
                [2] = "Animations",
                [3] = "Eggrolled"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
            end)
        else
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0 
    
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
    
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
    
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://93910549909381" then
                    track:Stop()
                end
            end
        end
    end

    if abc == "Pop Dance" then
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
    
        if state then
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
    
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
    
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://119907842673039"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
    
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://108553856293180"
            sound.Parent = rootPart
            sound.Volume = 1
            sound.Looped = true
            sound:Play()
    
            local args = {
                [1] = "PlayEmote",
                [2] = "Animations",
                [3] = "PopDance"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
            end)
        else
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0 
    
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
    
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
    
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://119907842673039" then
                    track:Stop()
                end
            end
        end
    end

    if abc == "Silly" then
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
    
        if state then
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
    
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
    
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://107716765704359"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
    
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://110142673940576"
            sound.Parent = rootPart
            sound.Volume = 1
            sound.Looped = true
            sound:Play()
    
            local args = {
                [1] = "PlayEmote",
                [2] = "Animations",
                [3] = "Eggrolled"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
            end)
        else
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0 
    
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
    
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
    
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://107716765704359" then
                    track:Stop()
                end
            end
        end
    end
    
    if abc == "Jumpstyle" then
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
    
        if state then
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
    
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
    
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://76148053209080"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
    
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://95018041323246"
            sound.Parent = rootPart
            sound.Volume = 1
            sound.Looped = true
            sound:Play()
    
            local args = {
                [1] = "PlayEmote",
                [2] = "Animations",
                [3] = "Jumpstyle"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
            end)
        else
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0 
    
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
    
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
    
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://76148053209080" then
                    track:Stop()
                end
            end
        end
    end

     if abc == "Lag Train (New Emotes)" then
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
    
        if state then
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
    
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
    
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://102222481833338"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
    
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://99999025144073"
            sound.Parent = rootPart
            sound.Volume = 1
            sound.Looped = true
            sound:Play()
    
            local args = {
                [1] = "PlayEmote",
                [2] = "Animations",
                [3] = "LagTrain"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
            end)
        else
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0 
    
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
    
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
    
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://102222481833338" then
                    track:Stop()
                end
            end
        end
    end

    if abc == "Po-Ppi-po (New Emotes)" then
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
    
        if state then
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
    
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
    
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://121015083880066"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
    
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://90648332675114"
            sound.Parent = rootPart
            sound.Volume = 1
            sound.Looped = true
            sound:Play()
    
            local args = {
                [1] = "PlayEmote",
                [2] = "Animations",
                [3] = "PoPpiPo"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
            end)
        else
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0 
    
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
    
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
    
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://121015083880066" then
                    track:Stop()
                end
            end
        end
    end


     if abc == "Wave" then
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
    
        if state then
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
    
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
    
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://128777973"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
    
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://154865749"
            sound.Parent = rootPart
            sound.Volume = 1
            sound.Looped = false
            sound:Play()
    
            local args = {
                [1] = "PlayEmote",
                [2] = "Animations",
                [3] = "Wait"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
            end)
        else
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0 
    
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
    
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
    
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://128777973" then
                    track:Stop()
                end
            end
        end
    end

    if abc == "Dance Alone (New Emotes)" then
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
    
        if state then
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
    
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
    
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://118913772889490"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
    
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://128503211488531"
            sound.Parent = rootPart
            sound.Volume = 1
            sound.Looped = false
            sound:Play()
    
            local args = {
                [1] = "PlayEmote",
                [2] = "Animations",
                [3] = "Wait"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
            end)
        else
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0 
    
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
    
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
    
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://118913772889490" then
                    track:Stop()
                end
            end
        end
    end

    if abc == "Wait" then
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
    
        if state then
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
    
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
    
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://119813505721636"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
    
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://123179402505565"
            sound.Parent = rootPart
            sound.Volume = 1
            sound.Looped = true
            sound:Play()
    
            local args = {
                [1] = "PlayEmote",
                [2] = "Animations",
                [3] = "Wait"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
            end)
        else
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0 
    
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
    
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
    
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://119813505721636" then
                    track:Stop()
                end
            end
        end
    end

    if abc == "Shucks" then
         local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
    
        if state then
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
        
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
        
           
            local emoteScript = require(game:GetService("ReplicatedStorage").Assets.Emotes.Shucks)
            emoteScript.Created({Character = char})
        
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://74238051754912"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
        
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://123236721947419"
            sound.Parent = rootPart
            sound.Volume = 0.5
            sound.Looped = false
            sound:Play()
        
            local args = {
                [1] = "PlayEmote",
                [2] = "Animations",
                [3] = "Shucks"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
        
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
        
                
                local saw = char:FindFirstChild("Saw")
                if saw then saw:Destroy() end
        
                local playerHand = char:FindFirstChild("PlayerEmoteHand")
                if playerHand then playerHand:Destroy() end
            end)
        else
    
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0
    
            local saw = char:FindFirstChild("Saw")
            if saw then saw:Destroy() end
    
            local playerHand = char:FindFirstChild("PlayerEmoteHand")
            if playerHand then playerHand:Destroy() end
    
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
    
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
    
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://74238051754912" then
                    track:Stop()
                end
            end
        end
    end

    end
})

PlayerTab:Section({Title = "Stamina"})

PlayerTab:Slider({
    Title = "Gain Stamina",
    Value = { Min = 0, Max = 50, Default = 15 },
    Callback = function(value)
       ase = value
    end
})

PlayerTab:Button({
  Title = "Gain Stamina",
  Callback = function() 
        local Sprinting = game:GetService("ReplicatedStorage").Systems.Character.Game.Sprinting
        local m = require(Sprinting)
         m.StaminaGain = ase
  end
})

PlayerTab:Divider()

PlayerTab:Slider({
    Title = "Max Stamina",
    Value = { Min = 0, Max = 100, Default = 100 },
    Callback = function(value)
       s = value
    end
})

PlayerTab:Button({
  Title = "Max Stamina",
  Callback = function() 
        local Sprinting = game:GetService("ReplicatedStorage").Systems.Character.Game.Sprinting
        local m = require(Sprinting)
         m.MaxStaming = s
  end
})

PlayerTab:Divider()

PlayerTab:Slider({
    Title = "Loss Stamina",
    Value = { Min = 0, Max = 50, Default = 10 },
    Callback = function(value)
       asees = value
    end
})

PlayerTab:Button({
  Title = "Loss Stamina",
  Callback = function() 
        local Sprinting = game:GetService("ReplicatedStorage").Systems.Character.Game.Sprinting
        local m = require(Sprinting)
         m.StaminaLoss = asees
  end
})

PlayerTab:Divider()

PlayerTab:Slider({
    Title = "Sprint Stamina",
    Value = { Min = 0, Max = 50, Default = 27 },
    Callback = function(value)
       aser = value
    end
})

PlayerTab:Button({
  Title = "Sprint Stamina",
  Callback = function() 
        local Sprinting = game:GetService("ReplicatedStorage").Systems.Character.Game.Sprinting
        local m = require(Sprinting)
         m.SprintSpeed = aser
  end
})

PlayerTab:Divider()

PlayerTab:Toggle({
    Title = "Infinite Stamina",
    Callback = function(state)
    local stamscript = require(game.ReplicatedStorage.Systems.Character.Game.Sprinting)
        
        local connection
        connection = game:GetService("RunService").Heartbeat:Connect(function()
            if not state then
                connection:Disconnect()
                stamscript.StaminaLossDisabled = nil
                return
            end
            stamscript.StaminaLossDisabled = function() 
            end
        end)
    end
})

PlayerTab:Section({Title = "Filp"})

PlayerTab:Button({
    Title = "Script Frontfilp",
    Desc = "script in filp.",
    Callback = function()
    local ScreenGui = Instance.new("ScreenGui")
local TextButton = Instance.new("TextButton")
 
--Properties:
 
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
 
TextButton.Parent = ScreenGui
TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextButton.BorderSizePixel = 0
TextButton.Position = UDim2.new(0.168367356, 0, 0.473272473, 0)
TextButton.Size = UDim2.new(0, 128, 0, 50)
TextButton.Font = Enum.Font.SourceSans
TextButton.Text = "FrontFilp"
TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
TextButton.TextScaled = true
TextButton.TextSize = 14.000
TextButton.TextWrapped = true
 
-- Scripts:
 
local function BSMJ_fake_script() -- TextButton.LocalScript 
	local script = Instance.new('LocalScript', TextButton)
 
	local UIS = game:GetService("UserInputService")
	function dragify(Frame)
		dragToggle = nil
		local dragSpeed = 0
		dragInput = nil
		dragStart = nil
		local dragPos = nil
		function updateInput(input)
			local Delta = input.Position - dragStart
			local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
			game:GetService("TweenService"):Create(Frame, TweenInfo.new(0.25), {Position = Position}):Play()
		end
		Frame.InputBegan:Connect(function(input)
			if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and UIS:GetFocusedTextBox() == nil then
				dragToggle = true
				dragStart = input.Position
				startPos = Frame.Position
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragToggle = false
					end
				end)
			end
		end)
		Frame.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				dragInput = input
			end
		end)
		game:GetService("UserInputService").InputChanged:Connect(function(input)
			if input == dragInput and dragToggle then
				updateInput(input)
			end
		end)
	end
 
	dragify(script.Parent)
end
coroutine.wrap(BSMJ_fake_script)()
local function UANMBQM_fake_script() -- TextButton.LocalScript 
	local script = Instance.new('LocalScript', TextButton)
 
	script.Parent.MouseButton1Down:Connect(function()
		local char = player.Character
		local hum = char.Humanoid
		local animator = hum.Animator
		local hrp = char.HumanoidRootPart
 
 
		if animator then
			for _, v in pairs(animator:GetPlayingAnimationTracks()) do
				v:Stop()
			end
		end
 
		hum:ChangeState(Enum.HumanoidStateType.Physics)
		hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
		hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
		hum:SetStateEnabled(Enum.HumanoidStateType.Running, false)
		hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
		hum:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
 
		local duration = 0.45
		local steps = 120
		local startCFrame = hrp.CFrame
		local forwardVector = startCFrame.LookVector
		local upVector = Vector3.new(0, 1, 0)
		task.spawn(function()
			local startTime = tick()
			for i = 1, steps do
				local t = i / steps
				local height = 4 * (t - t ^ 2) * 10
				local nextPos = startCFrame.Position + forwardVector * (35 * t) + upVector * height
				local rotation = startCFrame.Rotation * CFrame.Angles(-math.rad(i * (360 / steps)), 0, 0)
 
				hrp.CFrame = CFrame.new(nextPos) * rotation
				local elapsedTime = tick() - startTime
				local expectedTime = (duration / steps) * i
				local waitTime = expectedTime - elapsedTime
				if waitTime > 0 then
					task.wait(waitTime)
				end
			end
 
			hrp.CFrame = CFrame.new(startCFrame.Position + forwardVector * 35) * startCFrame.Rotation
			hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
			hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
			hum:SetStateEnabled(Enum.HumanoidStateType.Running, true)
			hum:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
			hum:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
			hum:ChangeState(Enum.HumanoidStateType.Running)
 
 
		end)
	end)
end
coroutine.wrap(UANMBQM_fake_script)()
    end
})

PlayerTab:Button({
    Title = "Script Backfilp",
    Desc = "script in filp.",
    Callback = function()
    local ScreenGui = Instance.new("ScreenGui")
local TextButton = Instance.new("TextButton")
 
--Properties:
 
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
 
TextButton.Parent = ScreenGui
TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextButton.BorderSizePixel = 0
TextButton.Position = UDim2.new(0.168367356, 0, 0.473272473, 0)
TextButton.Size = UDim2.new(0, 128, 0, 50)
TextButton.Font = Enum.Font.SourceSans
TextButton.Text = "Backfilp"
TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
TextButton.TextScaled = true
TextButton.TextSize = 14.000
TextButton.TextWrapped = true
 
-- Scripts:
 
local function BSMJ_fake_script() -- TextButton.LocalScript 
	local script = Instance.new('LocalScript', TextButton)
 
	local UIS = game:GetService("UserInputService")
	function dragify(Frame)
		dragToggle = nil
		local dragSpeed = 0
		dragInput = nil
		dragStart = nil
		local dragPos = nil
		function updateInput(input)
			local Delta = input.Position - dragStart
			local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
			game:GetService("TweenService"):Create(Frame, TweenInfo.new(0.25), {Position = Position}):Play()
		end
		Frame.InputBegan:Connect(function(input)
			if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and UIS:GetFocusedTextBox() == nil then
				dragToggle = true
				dragStart = input.Position
				startPos = Frame.Position
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragToggle = false
					end
				end)
			end
		end)
		Frame.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				dragInput = input
			end
		end)
		game:GetService("UserInputService").InputChanged:Connect(function(input)
			if input == dragInput and dragToggle then
				updateInput(input)
			end
		end)
	end
 
	dragify(script.Parent)
end
coroutine.wrap(BSMJ_fake_script)()
local function UANMBQM_fake_script() -- TextButton.LocalScript 
	local script = Instance.new('LocalScript', TextButton)
 
	script.Parent.MouseButton1Down:Connect(function()
		local char = player.Character
		local hum = char.Humanoid
		local animator = hum.Animator
		local hrp = char.HumanoidRootPart
 
 
		if animator then
			for _, v in pairs(animator:GetPlayingAnimationTracks()) do
				v:Stop()
			end
		end
 
		hum:ChangeState(Enum.HumanoidStateType.Physics)
		hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
		hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
		hum:SetStateEnabled(Enum.HumanoidStateType.Running, false)
		hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
		hum:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
 
		local duration = 0.45
		local steps = 120
		local startCFrame = hrp.CFrame
		local forwardVector = startCFrame.LookVector
		local upVector = Vector3.new(0, 1, 0)
		task.spawn(function()
			local startTime = tick()
			for i = 1, steps do
				local t = i / steps
				local height = 4 * (t - t ^ 2) * 10
				local nextPos = startCFrame.Position + forwardVector * (35 * t) + upVector * height
				local rotation = startCFrame.Rotation * CFrame.Angles(-math.rad(i * (360 / steps)), 0, 0)
 
				hrp.CFrame = CFrame.new(nextPos) * rotation
				local elapsedTime = tick() - startTime
				local expectedTime = (duration / steps) * i
				local waitTime = expectedTime - elapsedTime
				if waitTime > 0 then
					task.wait(waitTime)
				end
			end
 
			hrp.CFrame = CFrame.new(startCFrame.Position + forwardVector * 35) * startCFrame.Rotation
			hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
			hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
			hum:SetStateEnabled(Enum.HumanoidStateType.Running, true)
			hum:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
			hum:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
			hum:ChangeState(Enum.HumanoidStateType.Running)
 
 
		end)
	end)
end
coroutine.wrap(UANMBQM_fake_script)()
    end
})

PlayerTab:Divider()


PlayerTab:Keybind({
    Title = "Frontfilp",
    Value = "F",
    Callback = function()
    local char = player.Character
		local hum = char.Humanoid
		local animator = hum.Animator
		local hrp = char.HumanoidRootPart
 
 
		if animator then
			for _, v in pairs(animator:GetPlayingAnimationTracks()) do
				v:Stop()
			end
		end
 
		hum:ChangeState(Enum.HumanoidStateType.Physics)
		hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
		hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
		hum:SetStateEnabled(Enum.HumanoidStateType.Running, false)
		hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
		hum:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
 
		local duration = 0.45
		local steps = 120
		local startCFrame = hrp.CFrame
		local forwardVector = startCFrame.LookVector
		local upVector = Vector3.new(0, 1, 0)
		task.spawn(function()
			local startTime = tick()
			for i = 1, steps do
				local t = i / steps
				local height = 4 * (t - t ^ 2) * 10
				local nextPos = startCFrame.Position + forwardVector * (35 * t) + upVector * height
				local rotation = startCFrame.Rotation * CFrame.Angles(-math.rad(i * (360 / steps)), 0, 0)
 
				hrp.CFrame = CFrame.new(nextPos) * rotation
				local elapsedTime = tick() - startTime
				local expectedTime = (duration / steps) * i
				local waitTime = expectedTime - elapsedTime
				if waitTime > 0 then
					task.wait(waitTime)
				end
			end
 
			hrp.CFrame = CFrame.new(startCFrame.Position + forwardVector * 35) * startCFrame.Rotation
			hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
			hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
			hum:SetStateEnabled(Enum.HumanoidStateType.Running, true)
			hum:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
			hum:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
			hum:ChangeState(Enum.HumanoidStateType.Running)
 
 
		end)
    end
})

PlayerTab:Keybind({
    Title = "Backfilp",
    Value = "B",
    Callback = function()
    local char = player.Character
		local hum = char.Humanoid
		local animator = hum.Animator
		local hrp = char.HumanoidRootPart
 
 
		if animator then
			for _, v in pairs(animator:GetPlayingAnimationTracks()) do
				v:Stop()
			end
		end
 
		hum:ChangeState(Enum.HumanoidStateType.Physics)
		hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
		hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
		hum:SetStateEnabled(Enum.HumanoidStateType.Running, false)
		hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
		hum:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
 
		local duration = 0.45
		local steps = 120
		local startCFrame = hrp.CFrame
		local forwardVector = startCFrame.LookVector
		local upVector = Vector3.new(0, 1, 0)
		task.spawn(function()
			local startTime = tick()
			for i = 1, steps do
				local t = i / steps
				local height = 4 * (t - t ^ 2) * 10
				local nextPos = startCFrame.Position + forwardVector * (35 * t) + upVector * height
				local rotation = startCFrame.Rotation * CFrame.Angles(-math.rad(i * (360 / steps)), 0, 0)
 
				hrp.CFrame = CFrame.new(nextPos) * rotation
				local elapsedTime = tick() - startTime
				local expectedTime = (duration / steps) * i
				local waitTime = expectedTime - elapsedTime
				if waitTime > 0 then
					task.wait(waitTime)
				end
			end
 
			hrp.CFrame = CFrame.new(startCFrame.Position + forwardVector * 35) * startCFrame.Rotation
			hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
			hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
			hum:SetStateEnabled(Enum.HumanoidStateType.Running, true)
			hum:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
			hum:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
			hum:ChangeState(Enum.HumanoidStateType.Running)
 
 
		end)
    end
})

PlayerTab:Section({Title = "Others"})

PlayerTab:Paragraph({
    Title = "Warning",
    Desc = "do not speed like faster, you we're kicked, just slower.",
})

PlayerTab:Slider({
    Title = "Delay Walkspeed",
    Value = { Min = 0, Max = 100, Default = 1 },
    Callback = function(abcd)
       ayamgoreng = abcd
    end
})

PlayerTab:Toggle({
    Title = "Enable/Disable Walkspeed",
    Callback = function(state)
       if state then
        game.Players.LocalPlayer.Character.SpeedMultipliers.Sprinting.Value = ayamgoreng
       else
        game.Players.LocalPlayer.Character.SpeedMultipliers.Sprinting.Value = 1
       end
    end
})

PlayerTab:Divider()

PlayerTab:Slider({
    Title = "Delay Jumppower",
    Value = { Min = 0, Max = 50, Default = 0 },
    Callback = function(abcd)
       ayamgorengs = abcd
    end
})

PlayerTab:Toggle({
    Title = "Enable/Disable Jumppower",
    Callback = function(state)
       if state then
         game.Players.LocalPlayer.Character.Humanoid.JumpPower = ayamgorengs
       else
         game.Players.LocalPlayer.Character.Humanoid.JumpPower = 0
       end
    end
})

PlayerTab:Divider()

PlayerTab:Slider({
    Title = "Delay FOV Multipliers",
    Value = { Min = 0, Max = 2, Default = 1 },
    Callback = function(abcd)
       ayamgorengss = abcd
    end
})

PlayerTab:Toggle({
    Title = "Enable/Disable FOV Multipliers",
    Callback = function(state)
       if state then
         game.Players.LocalPlayer.Character.FOVMultipliers.FOVSetting.Value = ayamgorengss
       else
         game.Players.LocalPlayer.Character.FOVMultipliers.FOVSetting.Value = 1
       end
    end
})

PlayerTab:Divider()

PlayerTab:Button({
    Title = "Rejoin",
    Callback = function()
    -- unknown
    end
})

VisualTab:Section({Title = "ESP Color"})

VisualTab:Colorpicker({
    Title = "ESP Survivor Color",
    Desc = "esp survivor to select if want color.",
    Default = Color3.fromRGB(200, 98, 167),
    Callback = function(ty)
       rd = ty
    end
})

VisualTab:Colorpicker({
    Title = "ESP Killer Color",
    Desc = "esp killer to select if want color.",
    Default = Color3.fromRGB(74, 210, 231),
    Callback = function(ty)
       rde = ty
    end
})

VisualTab:Colorpicker({
    Title = "ESP John Doe Spike Color",
    Desc = "esp John doe Spike to select if want color.",
    Default = Color3.fromRGB(74, 210, 75),
    Callback = function(ty)
       rdes = ty
    end
})

VisualTab:Colorpicker({
    Title = "ESP Builderman Color",
    Desc = "esp Builderman to select if want color.",
    Default = Color3.fromRGB(255, 255, 75),
    Callback = function(ty)
       rdese = ty
    end
})

VisualTab:Colorpicker({
    Title = "ESP Npc 1x1x1x1 Color",
    Desc = "esp Npc 1x1x1x1 to select if want color.",
    Default = Color3.fromRGB(151, 146, 255),
    Callback = function(ty)
       rdeses = ty
    end
})

VisualTab:Colorpicker({
    Title = "ESP Npc C00lkidd Color",
    Desc = "esp Npc C00lkidd to select if want color.",
    Default = Color3.fromRGB(186, 255, 255),
    Callback = function(ty)
       rdesese = ty
    end
})

VisualTab:Colorpicker({
    Title = "ESP Generator Color",
    Desc = "esp Generator to select if want color.",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(ty)
       rdeseset = ty
    end
})

VisualTab:Colorpicker({
    Title = "ESP Item Color",
    Desc = "esp Item to select if want color.",
    Default = Color3.fromRGB(67, 67, 67),
    Callback = function(ty)
       rdesesete = ty
    end
})

VisualTab:Section({Title = "ESP Original"})

VisualTab:Toggle({
    Title = "ESP Survivor",
    Desc = "esp survivor to select.",
    Callback = function(state)
       local function applySurvivorHighlight(model)
            if model:IsA("Model") and model:FindFirstChild("Head") then
                local existingBillboard = model.Head:FindFirstChild("billboard")
                local existingHighlight = model:FindFirstChild("HiThere")
                
                if state then
                    if not existingBillboard then
                        local billboard = Instance.new("BillboardGui")
                        billboard.Name = "billboard"
                        billboard.Size = UDim2.new(0, 100, 0, 50)
                        billboard.StudsOffset = Vector3.new(0, 2, 0)
                        billboard.AlwaysOnTop = true
                        billboard.Parent = model.Head
                        
                        local textLabel = Instance.new("TextLabel", billboard)
                        textLabel.Size = UDim2.new(1, 0, 1, 0)
                        textLabel.Text = model.Name
                        textLabel.TextColor3 = Color3.new(1, 1, 1)
                        textLabel.TextStrokeTransparency = 0
                        textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
                        textLabel.BackgroundTransparency = 1
                    end
    
                    if not existingHighlight then
                        local highlight = Instance.new("Highlight")
                        highlight.Name = "HiThere"
                        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        highlight.FillColor = Color3.fromRGB(rd)
                        highlight.Parent = model
                    end
                else
                    if existingBillboard then
                        existingBillboard:Destroy()
                    end
                    if existingHighlight then
                        existingHighlight:Destroy()
                    end
                end
            end
        end
    
        for _, v in pairs(game.Workspace.Players.Survivors:GetChildren()) do
            applySurvivorHighlight(v)
        end
    
        game.Workspace.Players.Survivors.ChildAdded:Connect(function(child)
            applySurvivorHighlight(child)
        end)
    end
})

VisualTab:Toggle({
    Title = "ESP Killer",
    Desc = "esp killer to select.",
    Callback = function(state)
       local function applySurvivorHighlight(model)
            if model:IsA("Model") and model:FindFirstChild("Head") then
                local existingBillboard = model.Head:FindFirstChild("billboard")
                local existingHighlight = model:FindFirstChild("HiThere")
                
                if state then
                    if not existingBillboard then
                        local billboard = Instance.new("BillboardGui")
                        billboard.Name = "billboard"
                        billboard.Size = UDim2.new(0, 100, 0, 50)
                        billboard.StudsOffset = Vector3.new(0, 2, 0)
                        billboard.AlwaysOnTop = true
                        billboard.Parent = model.Head
                        
                        local textLabel = Instance.new("TextLabel", billboard)
                        textLabel.Size = UDim2.new(1, 0, 1, 0)
                        textLabel.Text = model.Name
                        textLabel.TextColor3 = Color3.new(1, 1, 1)
                        textLabel.TextStrokeTransparency = 0
                        textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
                        textLabel.BackgroundTransparency = 1
                    end
    
                    if not existingHighlight then
                        local highlight = Instance.new("Highlight")
                        highlight.Name = "HiThere"
                        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        highlight.FillColor = Color3.fromRGB(rde)
                        highlight.Parent = model
                    end
                else
                    if existingBillboard then
                        existingBillboard:Destroy()
                    end
                    if existingHighlight then
                        existingHighlight:Destroy()
                    end
                end
            end
        end
    
        for _, v in pairs(game.Workspace.Players.Killers:GetChildren()) do
            applySurvivorHighlight(v)
        end
    
        game.Workspace.Players.Killers.ChildAdded:Connect(function(child)
            applySurvivorHighlight(child)
        end)
    end
})

VisualTab:Toggle({
    Title = "ESP John Doe Spike",
    Desc = "esp john doe spike to select.",
    Callback = function(state)
       local function applySurvivorHighlight(model)
            if model:IsA("Model") and model:FindFirstChild("Head") then
                local existingBillboard = model.Head:FindFirstChild("billboard")
                local existingHighlight = model:FindFirstChild("HiThere")
                
                if state then
                    if not existingBillboard then
                        local billboard = Instance.new("BillboardGui")
                        billboard.Name = "billboard"
                        billboard.Size = UDim2.new(0, 100, 0, 50)
                        billboard.StudsOffset = Vector3.new(0, 2, 0)
                        billboard.AlwaysOnTop = true
                        billboard.Parent = model.Head
                        
                        local textLabel = Instance.new("TextLabel", billboard)
                        textLabel.Size = UDim2.new(1, 0, 1, 0)
                        textLabel.Text = model.Name
                        textLabel.TextColor3 = Color3.new(1, 1, 1)
                        textLabel.TextStrokeTransparency = 0
                        textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
                        textLabel.BackgroundTransparency = 1
                    end
    
                    if not existingHighlight then
                        local highlight = Instance.new("Highlight")
                        highlight.Name = "HiThere"
                        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        highlight.FillColor = Color3.fromRGB(rdes)
                        highlight.Parent = model
                    end
                else
                    if existingBillboard then
                        existingBillboard:Destroy()
                    end
                    if existingHighlight then
                        existingHighlight:Destroy()
                    end
                end
            end
        end
    
        for _, v in pairs(game.Workspace.Map.Ingame.Spike:GetChildren()) do
            applySurvivorHighlight(v)
        end
    
        game.Workspace.Map.Ingame.Spike.ChildAdded:Connect(function(child)
            applySurvivorHighlight(child)
        end)
    end
})


VisualTab:Toggle({
    Title = "ESP Builderman dipenser",
    Desc = "esp Builderman dipenser to select.",
    Callback = function(state)
       local function applySurvivorHighlight(model)
            if model:IsA("Model") and model:FindFirstChild("Head") then
                local existingBillboard = model.Head:FindFirstChild("billboard")
                local existingHighlight = model:FindFirstChild("HiThere")
                
                if state then
                    if not existingBillboard then
                        local billboard = Instance.new("BillboardGui")
                        billboard.Name = "billboard"
                        billboard.Size = UDim2.new(0, 100, 0, 50)
                        billboard.StudsOffset = Vector3.new(0, 2, 0)
                        billboard.AlwaysOnTop = true
                        billboard.Parent = model.Head
                        
                        local textLabel = Instance.new("TextLabel", billboard)
                        textLabel.Size = UDim2.new(1, 0, 1, 0)
                        textLabel.Text = model.Name
                        textLabel.TextColor3 = Color3.new(1, 1, 1)
                        textLabel.TextStrokeTransparency = 0
                        textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
                        textLabel.BackgroundTransparency = 1
                    end
    
                    if not existingHighlight then
                        local highlight = Instance.new("Highlight")
                        highlight.Name = "HiThere"
                        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        highlight.FillColor = Color3.fromRGB(rdese)
                        highlight.Parent = model
                    end
                else
                    if existingBillboard then
                        existingBillboard:Destroy()
                    end
                    if existingHighlight then
                        existingHighlight:Destroy()
                    end
                end
            end
        end
    
        for _, v in pairs(game.Workspace.Map.Ingame.BuildermanDispenser:GetChildren()) do
            applySurvivorHighlight(v)
        end
    
        game.Workspace.Map.Ingame.BuildermanDispenser.ChildAdded:Connect(function(child)
            applySurvivorHighlight(child)
        end)
    end
})

VisualTab:Toggle({
    Title = "ESP Npc 1x1x1x1",
    Desc = "esp npc 1x1x1x1 to select.",
    Callback = function(state)
      --ty
    end
})


VisualTab:Toggle({
    Title = "ESP Npc c00lkidd",
    Desc = "esp npc c00lkidd to select.",
    Callback = function(state)
         for i, v in pairs(game.Workspace.Map.Ingame:GetChildren()) do
            if v:IsA("Model") then
                local existingHighlight = v:FindFirstChild("CorruptNatureHighlight")
                if state then
                    if not existingHighlight then
                        if v.Name == "HumanoidRootProjectile" or v.Name == "PizzaDeliveryRig" or v.Name == "Bunny" or v.Name == "Mafiaso1" or v.Name == "Mafiaso2" or v.Name == "Mafiaso3" then
                            local highlight = Instance.new("Highlight")
                            highlight.Name = "CorruptNatureHighlight"
                            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                            highlight.Color3 = Color3.fromRGB(rdesese)
                            highlight.Parent = v
                        end
                    end
                else
                    if existingHighlight then
                        existingHighlight:Destroy()
                    end
                end
            end
        end
    end
})

VisualTab:Toggle({
    Title = "ESP Generator",
    Desc = "esp generator to select.",
    Callback = function(state)
      local function applyGeneratorHighlight(generator)
            if generator.Name == "Generator" then
                local existingHighlight = generator:FindFirstChild("GeneratorHighlight")
                local progress = generator:FindFirstChild("Progress")
                
                if state then
                    if not existingHighlight then
                        local genhighlight = Instance.new("Highlight")
                        genhighlight.Parent = generator
                        genhighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        genhighlight.Name = "GeneratorHighlight"
                        genhighlight.Color3 = Color3.fromRGB(rdeseset)
                    end
                else
                    if existingHighlight then
                        existingHighlight:Destroy()
                    end
                    return
                end
    
                if progress then
                    if progress.Value == 100 then
                        local highlight = generator:FindFirstChild("GeneratorHighlight")
                        if highlight then
                            highlight:Destroy()
                        end
                        return
                    end
    
                    progress:GetPropertyChangedSignal("Value"):Connect(function()
                        if progress.Value == 100 then
                            local highlight = generator:FindFirstChild("GeneratorHighlight")
                            if highlight then
                                highlight:Destroy()
                            end
                        elseif isHighlightActive and not generator:FindFirstChild("GeneratorHighlight") then
                            local genhighlight = Instance.new("Highlight")
                            genhighlight.Parent = generator
                            genhighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                            genhighlight.Name = "GeneratorHighlight"
                        end
                    end)
                end
            end
        end
    
        for _, v in pairs(game.Workspace.Map.Ingame.Map:GetChildren()) do
            applyGeneratorHighlight(v)
        end
    
        game.Workspace.Map.Ingame.Map.ChildAdded:Connect(function(child)
            applyGeneratorHighlight(child)
        end)
    end
})

VisualTab:Toggle({
    Title = "ESP Item",
    Desc = "esp item to select.",
    Callback = function(state)
         local function applyHighlight(tool)
            if state then
                local existinghighlight = tool:FindFirstChild("ToolHighlight")
                if not existinghighlight then
                    local toolhighlight = Instance.new("Highlight")
                    toolhighlight.Name = "ToolHighlight"
                    toolhighlight.Parent = tool
                    toolhighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    
                    if tool.Name == "Medkit" then
                        toolhighlight.FillColor = Color3.fromRGB(rdesesete)
                    elseif tool.Name == "BloxyCola" then
                        toolhighlight.FillColor = Color3.fromRGB(88, 57, 39)
                    end
                end
            else
                local existinghighlight = tool:FindFirstChild("ToolHighlight")
                if existinghighlight then
                    existinghighlight:Destroy()
                end
            end
        end
        
        for _, v in pairs(game.Workspace.Map.Ingame.Map:GetChildren()) do
            if v:IsA("Tool") then
                applyHighlight(v)
            end
        end
        
        game.Workspace.Map.Ingame.Map.ChildAdded:Connect(function(child)
            if child:IsA("Tool") then
                applyHighlight(child)
            end
        end)
    end
})

AimbotTab:Section({Title = "Survivor Aimbot"})

AimbotTab:Toggle({
    Title = "Aimbot Two Time",
    Desc = "Knife to two time with aimbot.",
    Callback = function(state)
            game:GetService("ReplicatedStorage").Modules.Network.RemoteEvent:FireServer("SetDevice", state and "Mobile" or "PC")
    end
})

AimbotTab:Toggle({
    Title = "Aimbot Guest1337",
    Desc = "hand to guest1337 with aimbot.",
    Callback = function(state)
           if state then
            shedloop = game.Players.LocalPlayer.Character.HumanoidRootPart.ChildAdded:Connect(function(child)
                if not state then return end
                for _, v in pairs(guestsounds) do
                    if child.Name == v then
                        local killersFolder = game.Workspace.Players:FindFirstChild("Killers")
                        if killersFolder then
                            local killer = killersFolder:FindFirstChildOfClass("Model")
                            if killer and killer:FindFirstChild("HumanoidRootPart") then
                                local killerHRP = killer.HumanoidRootPart
                                local playerHRP = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                                if playerHRP then
                                    local num = 1
                                    local maxIterations = 100
    
                                    while num <= maxIterations do
                                        task.wait(0.01)
                                        num = num + 1
                                        workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, killerHRP.Position)
                                        playerHRP.CFrame = CFrame.lookAt(playerHRP.Position, killerHRP.Position)
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        else
            if guestloop then
                guestloop:Disconnect()
                guestloop = nil
            end
        end
    end
})

AimbotTab:Toggle({
    Title = "Aimbot Shedletsky",
    Desc = "sword to shedletsky with aimbot.",
    Callback = function(state)
    if state then
            shedloop = game.Players.LocalPlayer.Character.Sword.ChildAdded:Connect(function(child)
                if not state then return end
                for _, v in pairs(shedaimbotsounds) do
                    if child.Name == v then
                        local killersFolder = game.Workspace.Players:FindFirstChild("Killers")
                        if killersFolder then
                            local killer = killersFolder:FindFirstChildOfClass("Model")
                            if killer and killer:FindFirstChild("HumanoidRootPart") then
                                local killerHRP = killer.HumanoidRootPart
                                local playerHRP = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                                if playerHRP then
                                    local num = 1
                                    local maxIterations = 100
    
                                    while num <= maxIterations do
                                        task.wait(0.01)
                                        num = num + 1
                                        workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, killerHRP.Position)
                                        playerHRP.CFrame = CFrame.lookAt(playerHRP.Position, killerHRP.Position)
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        else
            if shedloop then
                shedloop:Disconnect()
                shedloop = nil
            end
        end
    end
})

AimbotTab:Toggle({
    Title = "Aimbot Chance",
    Desc = "gun to chance with aimbot.",
    Callback = function(state)
    if state then
            chanceaimbotLoop = game.Players.LocalPlayer.Character.HumanoidRootPart.ChildAdded:Connect(function(child)
                if not state then return end
                for _, v in pairs(chanceaimbotsounds) do
                    if child.Name == v  then
                        local killer = game.Workspace.Players:FindFirstChild("Killers"):FindFirstChildOfClass("Model")
                        if killer and killer:FindFirstChild("HumanoidRootPart") then
                            local killerHRP = killer.HumanoidRootPart
                            local playerHRP = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            if playerHRP then
                                local direction = (killerHRP.Position - playerHRP.Position).Unit
                                local num = 1
                                local maxIterations = 100
                            
                                
                                    while num <= maxIterations do
                                        task.wait(0.01)
                                        num = num + 1
                                        workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, killerHRP.Position)
                                        playerHRP.CFrame = CFrame.lookAt(playerHRP.Position, Vector3.new(killerHRP.Position.X, killerHRP.Position.Y, killerHRP.Position.Z))
                                    end
                                
                            
                            end
                        end
                    end
                end
            end)
        else
            if chanceaimbotLoop then
                chanceaimbotLoop:Disconnect()
                chanceaimbotLoop = nil
            end
        end
    end
})

AimbotTab:Section({Title = "Killers Aimbot"})

AimbotTab:Toggle({
    Title = "Aimbot c00lkidd",
    Desc = "hand to c00lkidd with aimbot.",
    Callback = function(state)
            game:GetService("ReplicatedStorage").Modules.Network.RemoteEvent:FireServer("SetDevice", state and "Mobile" or "PC")
    end
})

AimbotTab:Toggle({
    Title = "Aimbot Guest666",
    Desc = "eat to guest666 with aimbot.",
    Callback = function(state)
            game:GetService("ReplicatedStorage").Modules.Network.RemoteEvent:FireServer("SetDevice", state and "Mobile" or "PC")
    end
})

AimbotTab:Toggle({
    Title = "Aimbot Nosferatu",
    Desc = "bat to nosferatu with aimbot.",
    Callback = function(state)
            game:GetService("ReplicatedStorage").Modules.Network.RemoteEvent:FireServer("SetDevice", state and "Mobile" or "PC")
    end
})

AimbotTab:Toggle({
    Title = "Aimbot Noli",
    Desc = "error generator to noli with aimbot.",
    Callback = function(state)
            game:GetService("ReplicatedStorage").Modules.Network.RemoteEvent:FireServer("SetDevice", state and "Mobile" or "PC")
    end
})

AimbotTab:Toggle({
    Title = "Aimbot John doe",
    Desc = "spike to john doe with aimbot.",
    Callback = function(state)
          if state then
                johnloop = game.Players.LocalPlayer.Character.HumanoidRootPart.ChildAdded:Connect(function(child)
                    if not state then return end
                    for _, v in pairs(johnaimbotsounds) do
                        if child.Name == v then
                           
                            local survivors = {}
                            for _, player in pairs(game.Players:GetPlayers()) do
                                if player ~= game.Players.LocalPlayer then
                                    local character = player.Character
                                    if character and character:FindFirstChild("HumanoidRootPart") then
                                        table.insert(survivors, character)
                                    end
                                end
                            end
        
                           
                            local nearestSurvivor = nil
                            local shortestDistance = math.huge  
                            
                            for _, survivor in pairs(survivors) do
                                local survivorHRP = survivor.HumanoidRootPart
                                local playerHRP = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                                
                                if playerHRP then
                                    local distance = (survivorHRP.Position - playerHRP.Position).Magnitude
                                    if distance < shortestDistance then
                                        shortestDistance = distance
                                        nearestSurvivor = survivor
                                    end
                                end
                            end
                            
                          
                            if nearestSurvivor then
                                local nearestHRP = nearestSurvivor.HumanoidRootPart
                                local playerHRP = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                                local maxIterations = 330
                                if playerHRP then
                                    local direction = (nearestHRP.Position - playerHRP.Position).Unit
                                    local num = 1
                                   
                                        
                                        while num <= maxIterations do
                                            task.wait(0.01)
                                            num = num + 1
                                            workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, nearestHRP.Position)
                                            playerHRP.CFrame = CFrame.lookAt(playerHRP.Position, Vector3.new(nearestHRP.Position.X, nearestHRP.Position.Y, nearestHRP.Position.Z))
                    
                                    end
                                end
                            end
                        end
                    end
                end)
            else
                if johnloop then
                    johnloop:Disconnect()
                    johnloop = nil
                end
            end
    end
})

AimbotTab:Toggle({
    Title = "Aimbot 1x1x1x1",
    Desc = "sword to 1x1x1x1 with aimbot.",
    Callback = function(state)
    if state then
            aimbot1x1loop = game.Players.LocalPlayer.Character.HumanoidRootPart.ChildAdded:Connect(function(child)
                if not aimbot1x1 then return end
                for _, v in pairs(aimbot1x1sounds) do
                    if child.Name == v then
                        local survivors = {}
                        for _, player in pairs(game.Players:GetPlayers()) do
                            if player ~= game.Players.LocalPlayer then
                                local character = player.Character
                                if character and character:FindFirstChild("HumanoidRootPart") then
                                    table.insert(survivors, character)
                                end
                            end
                        end
    
                        local nearestSurvivor = nil
                        local shortestDistance = math.huge  
                        
                        for _, survivor in pairs(survivors) do
                            local survivorHRP = survivor.HumanoidRootPart
                            local playerHRP = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            
                            if playerHRP then
                                local distance = (survivorHRP.Position - playerHRP.Position).Magnitude
                                if distance < shortestDistance then
                                    shortestDistance = distance
                                    nearestSurvivor = survivor
                                end
                            end
                        end
                        
                        if nearestSurvivor then
                            local nearestHRP = nearestSurvivor.HumanoidRootPart
                            local playerHRP = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            
                            if playerHRP then
                                local direction = (nearestHRP.Position - playerHRP.Position).Unit
                                local num = 1
                                local maxIterations = 100 
    
                                
                                    if child.Name == "rbxassetid://79782181585087" then
                                        maxIterations = 220  
                                    end
    
                                while num <= maxIterations do
                                    task.wait(0.01)
                                    num = num + 1
                                    workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, nearestHRP.Position)
                                    playerHRP.CFrame = CFrame.lookAt(playerHRP.Position, Vector3.new(nearestHRP.Position.X, nearestHRP.Position.Y, nearestHRP.Position.Z))
                                end
                            
                            end
                        end
                    end
                end
            end)
        else
            if aimbot1x1loop then
                aimbot1x1loop:Disconnect()
                aimbot1x1loop = nil
            end
        end
    end
})

AimbotTab:Toggle({
    Title = "Aimbot Slasher",
    Desc = "knife to slasher with aimbot.",
    Callback = function(state)
    if state then
                jasonaimbotloop = game.Players.LocalPlayer.Character.HumanoidRootPart.ChildAdded:Connect(function(child)
                    if not state then return end
                    for _, v in pairs(jasonaimbotsounds) do
                        if child.Name == v then
                           
                            local survivors = {}
                            for _, player in pairs(game.Players:GetPlayers()) do
                                if player ~= game.Players.LocalPlayer then
                                    local character = player.Character
                                    if character and character:FindFirstChild("HumanoidRootPart") then
                                        table.insert(survivors, character)
                                    end
                                end
                            end
        
                           
                            local nearestSurvivor = nil
                            local shortestDistance = math.huge  
                            
                            for _, survivor in pairs(survivors) do
                                local survivorHRP = survivor.HumanoidRootPart
                                local playerHRP = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                                
                                if playerHRP then
                                    local distance = (survivorHRP.Position - playerHRP.Position).Magnitude
                                    if distance < shortestDistance then
                                        shortestDistance = distance
                                        nearestSurvivor = survivor
                                    end
                                end
                            end
                            
                          
                            if nearestSurvivor then
                                local nearestHRP = nearestSurvivor.HumanoidRootPart
                                local playerHRP = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                                local maxIterations = 70
                                if playerHRP then
                                    local direction = (nearestHRP.Position - playerHRP.Position).Unit
                                    local num = 1
                                   
                                        
                                        while num <= maxIterations do
                                            task.wait(0.01)
                                            num = num + 1
                                            
                                            playerHRP.CFrame = CFrame.lookAt(playerHRP.Position, Vector3.new(nearestHRP.Position.X, nearestHRP.Position.Y, nearestHRP.Position.Z))
                    
                                    end
                                end
                            end
                        end
                    end
                end)
            else
                if jasonaimbotloop then
                    jasonaimbotloop:Disconnect()
                    jasonaimbotloop = nil
                end
            end
    end
})

CombatTab:Section({Title = "Survivor Combat"})


local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local PlayerGui = lp:WaitForChild("PlayerGui")
local Humanoid, Animator
local StarterGui  = game:GetService("StarterGui")
local TestService = game:GetService("TestService")
local ChatEvents = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
local SayMessageRequest = ChatEvents and ChatEvents:FindFirstChild("SayMessageRequest")

local autoBlockTriggerSounds = {
    ["102228729296384"] = true,
    ["140242176732868"] = true,
    ["112809109188560"] = true,
    ["136323728355613"] = true,
    ["115026634746636"] = true,
    ["84116622032112"] = true,
    ["108907358619313"] = true,
    ["127793641088496"] = true,
    ["86174610237192"] = true,
    ["95079963655241"] = true,
    ["101199185291628"] = true,
    ["119942598489800"] = true,
    ["84307400688050"] = true,
    ["113037804008732"] = true,
    ["105200830849301"] = true,
    ["75330693422988"] = true,
    ["82221759983649"] = true,
    ["81702359653578"] = true,
    ["108610718831698"] = true,
    ["112395455254818"] = true,
    ["109431876587852"] = true,
    ["109348678063422"] = true,
    ["85853080745515"] = true,
    ["12222216"] = true,
    ["105840448036441"] = true,
    ["114742322778642"] = true,
    ["119583605486352"] = true,
    ["79980897195554"] = true,
    ["71805956520207"] = true,
    ["79391273191671"] = true,
    ["89004992452376"] = true,
    ["101553872555606"] = true,
    ["101698569375359"] = true,
    ["106300477136129"] = true,
    ["116581754553533"] = true,
    ["117231507259853"] = true,
    ["119089145505438"] = true,
    ["121954639447247"] = true,
    ["125213046326879"] = true,
    ["131406927389838"] = true,
    ["71834552297085"] = true, -- Guest666 leap ability thingy
    ["805165833096"] = true,
}

-- Prevent repeated aim triggers for the same animation track
local lastAimTrigger = {}   -- keys = AnimationTrack, value = timestamp when we triggered
local AIM_WINDOW = 0.5      -- how long to aim (seconds)
local AIM_COOLDOWN = 0.6    -- don't retrigger within this many seconds

-- add once, outside the RenderStepped loop
local _lastPunchMessageTime = _lastPunchMessageTime or 0
local MESSAGE_PUNCH_COOLDOWN = 0.6 -- overall throttle (seconds)
local _punchPrevPlaying = _punchPrevPlaying or {} -- persist between frames

local _lastBlockMessageTime = _lastBlockMessageTime or 0
local MESSAGE_BLOCK_COOLDOWN = 0.6 -- overall throttle (seconds)
local _blockPrevPlaying = _blockPrevPlaying or {} -- persist between frames


local autoBlockTriggerAnims = {
    "126830014841198", "126355327951215", "121086746534252", "18885909645",
    "98456918873918", "105458270463374", "83829782357897", "125403313786645",
    "118298475669935", "82113744478546", "70371667919898", "99135633258223",
    "97167027849946", "109230267448394", "139835501033932", "126896426760253",
    "109667959938617", "126681776859538", "129976080405072", "121293883585738",
    "81639435858902", "137314737492715",
    "92173139187970", "122709416391", "879895330952"
}

-- State Variables
local autoBlockOn = false
local autoBlockAudioOn = false

local doubleblocktech = false
local blockdelay = 0
local looseFacing = true
local detectionRange = 18
local messageWhenAutoBlockOn = false
local messageWhenAutoBlock = ""
-- local fasterAudioAB = false (this is scrapped. im too lazy to remove it)
local Debris = game:GetService("Debris")
-- Anti-flick toggle state
local antiFlickOn = false
-- how many anti-flick parts to spawn (default 4)
local antiFlickParts = 4

-- optional: base distance in front of killer for the first part
local antiFlickBaseOffset = 2.7

-- optional: distance step between successive parts
local antiFlickOffsetStep = 0

local antiFlickDelay = 0 -- seconds to wait before parts spawn (default 0 = instant)
local PRED_SECONDS_FORWARD = 0.25   -- seconds ahead for linear prediction
local PRED_SECONDS_LATERAL  = 0.18  -- seconds ahead for lateral prediction
local PRED_MAX_FORWARD      = 6     -- clamp (studs)
local PRED_MAX_LATERAL      = 4     -- clamp (studs)
local ANG_TURN_MULTIPLIER   = 0.6   -- how much angular velocity contributes to lateral offset
local SMOOTHING_LERP        = 0.22  -- smoothing for sampled velocity/angular vel
local stagger  = 0.02

local killerState = {} -- [model] = { prevPos, prevLook, vel(Vector3), angVel(number) }

-- prediction multiplier: 1.0 is normal, up to 10.0
-- prediction multipliers
local predictionStrength = 1        -- forward/lateral (1x .. 10x)
local predictionTurnStrength = 1    -- turning strength (1x .. 10x)
-- multiplier for blue block parts size (1.0 = default)
local blockPartsSizeMultiplier = 1

local autoAdjustDBTFBPS = false
local _savedManualAntiFlickDelay = antiFlickDelay or 0 -- keep user's manual value when toggle is turned off

-- map of killer name (lowercase) -> antiFlickDelay value you requested
local killerDelayMap = {
    ["c00lkidd"] = 0,
    ["jason"]    = 0.013,
    ["slasher"]  = 0.01,
    ["1x1x1x1"]  = 0.15,
    ["johndoe"]  = 0.33,
    ["noli"]     = 0.15,
}

local predictiveBlockOn = false
local edgeKillerDelay = 3
local killerInRangeSince = nil
local predictiveCooldown = 0
-- auto punch
local predictionValue = 4

local hitboxDraggingTech = false
local _hitboxDraggingDebounce = false
local HITBOX_DRAG_DURATION = 1.4
local HITBOX_DETECT_RADIUS = 6
local Dspeed = 5.6 -- you can tweak these numbers
local Ddelay = 0

local killerNames = {"c00lkidd", "Jason", "JohnDoe", "1x1x1x1", "Noli", "Slasher", "Sixer"}
local autoPunchOn = false
local messageWhenAutoPunchOn = false
local messageWhenAutoPunch = ""
local flingPunchOn = false
local flingPower = 10000
local hiddenfling = false
local aimPunch = false

local customBlockEnabled = false
local customBlockAnimId = ""
local customblockdelay = 2
local customPunchEnabled = false
local customPunchAnimId = ""
local custompunchdelay = 2.7

local espEnabled = false
local KillersFolder = workspace:WaitForChild("Players"):WaitForChild("Killers")

local lastBlockTime = 0
local lastPunchTime = 0


local blockAnimIds = {
"72722244508749",
"96959123077498",
"95802026624883"
}
local punchAnimIds = {
"87259391926321",
"140703210927645",
"136007065400978",
"136007065400978",
"129843313690921",
"129843313690921",
"86709774283672",
"87259391926321",
"129843313690921",
"129843313690921",
"108807732150251",
"138040001965654",
"86096387000557",
"86096387000557"
}

local chargeAnimIds = {
    "106014898538300"
}

local customChargeEnabled = false
local customChargeAnimId = ""
local chargeAnimIds = { "106014898528300" }


local cachedAnimator = nil
local function refreshAnimator()
    local char = lp.Character
    if not char then
        cachedAnimator = nil
        return
    end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        local anim = hum:FindFirstChildOfClass("Animator")
        cachedAnimator = anim or nil
    else
        cachedAnimator = nil
    end
end

lp.CharacterAdded:Connect(function(char)
    task.wait(0.5) -- allow Humanoid/Animator to be created
    refreshAnimator()
end)

-- ===== performance improvements for Sound Auto Block =====
-- cached UI / refs
local cachedPlayerGui = PlayerGui
local cachedPunchBtn, cachedBlockBtn, cachedCharges, cachedCooldown, cachedChargeBtn, cachedCloneBtn = nil, nil, nil, nil, nil, nil
local detectionRangeSq = detectionRange * detectionRange

local function refreshUIRefs()
    -- ensure we have the most up-to-date references for MainUI and ability buttons
    cachedPlayerGui = lp:FindFirstChild("PlayerGui") or PlayerGui
    local main = cachedPlayerGui and cachedPlayerGui:FindFirstChild("MainUI")
    if main then
        local ability = main:FindFirstChild("AbilityContainer")
        cachedPunchBtn = ability and ability:FindFirstChild("Punch")
        cachedBlockBtn = ability and ability:FindFirstChild("Block")
        cachedChargeBtn = ability and ability:FindFirstChild("Charge")
        cachedCloneBtn = ability and ability:FindFirstChild("Clone")
        cachedCharges = cachedPunchBtn and cachedPunchBtn:FindFirstChild("Charges")
        cachedCooldown = cachedBlockBtn and cachedBlockBtn:FindFirstChild("CooldownTime")
    else
        cachedPunchBtn, cachedBlockBtn, cachedCharges, cachedCooldown, cachedChargeBtn, cachedCloneBtn = nil, nil, nil, nil, nil, nil
    end
end

-- call once at startup
refreshUIRefs()

-- refresh on GUI or character changes (keeps caches fresh)
if cachedPlayerGui then
    cachedPlayerGui.ChildAdded:Connect(function(child)
        if child.Name == "MainUI" then
            task.delay(0.02, refreshUIRefs)
        end
    end)
end

local facingCheckEnabled = true
local customFacingDot = -0.3

-- Optimized facing check
local function isFacing(localRoot, targetRoot)
    -- fast global reads
    local enabled = facingCheckEnabled
    if not enabled then return true end

    local loose = looseFacing

    -- difference vector (one allocation, unavoidable)
    local dx = localRoot.Position.X - targetRoot.Position.X
    local dy = localRoot.Position.Y - targetRoot.Position.Y
    local dz = localRoot.Position.Z - targetRoot.Position.Z

    -- magnitude (sqrt) once; handle zero-distance safely
    local mag = math.sqrt(dx*dx + dy*dy + dz*dz)
    if mag == 0 then
        -- if positions coincide treat as "facing" (matches permissive behavior)
        return true
    end
    local invMag = 1 / mag

    -- unit direction components (no new Vector3 allocation)
    local ux, uy, uz = dx * invMag, dy * invMag, dz * invMag

    -- cache look vector components
    local lv = targetRoot.CFrame.LookVector
    local lx, ly, lz = lv.X, lv.Y, lv.Z

    -- dot product (fast scalar math)
    local dot = lx * ux + ly * uy + lz * uz

    -- same logic as original, but explicit for clarity/branch prediction
    return dot > (customFacingDot or -0.3)
end

-- ===== Facing Check Visual (fixed) =====
local facingVisualOn = false
local facingVisuals = {} -- [killer] = visual

local function updateFacingVisual(killer, visual)
    if not (killer and visual and visual.Parent) then return end
    local hrp = killer:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    -- calculate angle from DOT threshold (safe-clamp)
    local dot = math.clamp(customFacingDot or -0.3, -1, 1)
    local angle = math.acos(dot)              -- radians, 0..pi
    local frac = angle / math.pi              -- 0..1 (0 = very narrow cone, 1 = very wide)

    -- scale radius between a small fraction and full detectionRange
    local minFrac = 0.20                      -- tune: smallest disc is 20% of detectionRange
    local radius = math.max(1, detectionRange * (minFrac + (1 - minFrac) * frac))
    visual.Radius = radius
    visual.Height = 0.12

    -- place the disc in front of the killer; move slightly less forward for narrow cones
    local forwardDist = detectionRange * (0.35 + 0.15 * frac) -- tune if you like
    local yOffset = -(hrp.Size.Y / 2 + 0.05)
    visual.CFrame = CFrame.new(0, yOffset, -forwardDist) * CFrame.Angles(math.rad(90), 0, 0)

    -- determine local player's HRP and whether they are inside range & facing
    local myRoot = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
    local inRange = false
    local facingOkay = false

    if myRoot and hrp then
        local dist = (hrp.Position - myRoot.Position).Magnitude
        inRange = dist <= detectionRange
        facingOkay = (not facingCheckEnabled) or (type(isFacing) == "function" and isFacing(myRoot, hrp))
    end

    -- color / transparency
    if inRange and facingOkay then
        visual.Color3 = Color3.fromRGB(0, 255, 0)
        visual.Transparency = 0.40
    else
        visual.Color3 = Color3.fromRGB(255, 255, 0) -- show yellow when not both conditions
        visual.Transparency = 0.85
    end
end

local function addFacingVisual(killer)
    if not killer or not killer:IsA("Model") then return end
    if facingVisuals[killer] then return end
    local hrp = killer:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local visual = Instance.new("CylinderHandleAdornment")
    visual.Name = "FacingCheckVisual"
    visual.Adornee = hrp
    visual.AlwaysOnTop = true
    visual.ZIndex = 2
    visual.Transparency = 0.55
    visual.Color3 = Color3.fromRGB(0, 255, 0) -- green

    visual.Parent = hrp
    facingVisuals[killer] = visual

    -- initialize placement immediately
    updateFacingVisual(killer, visual)
end

local function removeFacingVisual(killer)
    local v = facingVisuals[killer]
    if v then
        v:Destroy()
        facingVisuals[killer] = nil
    end
end

local function refreshFacingVisuals()
    for _, k in ipairs(KillersFolder:GetChildren()) do
        if facingVisualOn then
            -- make sure HRP exists before creating
            local hrp = k:FindFirstChild("HumanoidRootPart") or k:WaitForChild("HumanoidRootPart", 5)
            if hrp then addFacingVisual(k) end
        else
            removeFacingVisual(k)
        end
    end
end

-- keep visuals in sync every frame (ensures size/mode changes apply immediately)
RunService.RenderStepped:Connect(function()
    for killer, visual in pairs(facingVisuals) do
        -- if the killer was removed/died, clean up
        if not killer.Parent or not killer:FindFirstChild("HumanoidRootPart") then
            removeFacingVisual(killer)
        else
            updateFacingVisual(killer, visual)
        end
    end
end)

-- Keep visuals for newly added/removed killers
KillersFolder.ChildAdded:Connect(function(killer)
    if facingVisualOn then
        task.spawn(function()
            local hrp = killer:WaitForChild("HumanoidRootPart", 5)
            if hrp then addFacingVisual(killer) end
        end)
    end
end)
KillersFolder.ChildRemoved:Connect(function(killer) removeFacingVisual(killer) end)

-- ===== Facing Check Visual (paste after detectionCircles / addKillerCircle) =====
local detectionCircles = {} -- store all killer circles
local killerCirclesVisible = false

-- Function to add circle to a killer
-- replace your addKillerCircle with this
local function addKillerCircle(killer)
    if not killer:FindFirstChild("HumanoidRootPart") then return end
    if detectionCircles[killer] then return end

    local hrp = killer.HumanoidRootPart
    local circle = Instance.new("CylinderHandleAdornment")
    circle.Name = "KillerDetectionCircle"
    circle.Adornee = hrp
    circle.Color3 = Color3.fromRGB(255, 0, 0)
    circle.AlwaysOnTop = true
    circle.ZIndex = 1
    circle.Transparency = 0.6
    circle.Radius = detectionRange            -- <- use detectionRange exactly
    circle.Height = 0.12                      -- thin disc
    -- place the disc at the feet of the HumanoidRootPart (CFrame is relative to Adornee)
    local yOffset = -(hrp.Size.Y / 2 + 0.05)  -- a little below HRP origin
    circle.CFrame = CFrame.new(0, yOffset, 0) * CFrame.Angles(math.rad(90), 0, 0)
    circle.Parent = hrp

    detectionCircles[killer] = circle
end

-- Update radius when detectionRange changes (and on render)


-- Function to remove circle from a killer
local function removeKillerCircle(killer)
    if detectionCircles[killer] then
        detectionCircles[killer]:Destroy()
        detectionCircles[killer] = nil
    end
end

-- Refresh all circles
local function refreshKillerCircles()
    for _, killer in ipairs(KillersFolder:GetChildren()) do
        if killerCirclesVisible then
            addKillerCircle(killer)
        else
            removeKillerCircle(killer)
        end
    end
end

-- Keep radius updated
RunService.RenderStepped:Connect(function()
    for killer, circle in pairs(detectionCircles) do
        if circle and circle.Parent then
            circle.Radius = detectionRange
        end
    end
end)

-- Hook into killers being added/removed
KillersFolder.ChildAdded:Connect(function(killer)
    if killerCirclesVisible then
        task.spawn(function()
            -- Wait until HRP exists (max 5s timeout)
            local hrp = killer:WaitForChild("HumanoidRootPart", 5)
            if hrp then
                addKillerCircle(killer)
            end
        end)
    end
end)

KillersFolder.ChildRemoved:Connect(function(killer)
    removeKillerCircle(killer)
end)


local autoblocktype = "Block"

local StarterGui = game:GetService("StarterGui")

-- simple notification
local function SendNotif(title, text, duration)
    StarterGui:SetCore("SendNotification", {
        Title = title or "Hello",
        Text = text or "hi",
        Duration = duration or 4 -- seconds
    })
end

lp.CharacterAdded:Connect(function()
    task.delay(0.5, refreshUIRefs)
end)

local function getNearestKillerModel()
    local myChar = lp.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end

    local closest, closestDist = nil, math.huge
    for _, k in ipairs(KillersFolder:GetChildren()) do
        if k and k:IsA("Model") then
            local hrp = k:FindFirstChild("HumanoidRootPart")
            if hrp then
                local d = (hrp.Position - myRoot.Position).Magnitude
                if d < closestDist then
                    closest, closestDist = k, d
                end
            end
        end
    end
    return closest
end

local function applyDelayForKillerModel(killerModel)
    if not killerModel then
        -- no killer found -> restore manual value
        if antiFlickDelay ~= _savedManualAntiFlickDelay then
            antiFlickDelay = _savedManualAntiFlickDelay
            print(("Auto-DBTFBPS: no killer -> restore antiFlickDelay = %s"):format(tostring(antiFlickDelay)))
        end
        return
    end

    local key = (tostring(killerModel.Name) or ""):lower()
    local mapped = killerDelayMap[key]

    if mapped ~= nil then
        if antiFlickDelay ~= mapped then
            antiFlickDelay = mapped
            print(("Auto-DBTFBPS: matched killer '%s' -> antiFlickDelay = %s"):format(killerModel.Name, tostring(mapped)))
        end
    else
        -- killer not in mapping: restore manual value (avoid surprising changes)
        if antiFlickDelay ~= _savedManualAntiFlickDelay then
            antiFlickDelay = _savedManualAntiFlickDelay
            print(("Auto-DBTFBPS: killer '%s' not mapped -> restore antiFlickDelay = %s"):format(killerModel.Name, tostring(_savedManualAntiFlickDelay)))
        end
    end
end

-- small throttled heartbeat loop (runs only when toggle enabled)
local adjustTicker = 0
RunService.Heartbeat:Connect(function(dt)
    if not autoAdjustDBTFBPS then return end
    adjustTicker = adjustTicker + dt
    if adjustTicker < 0.15 then return end -- check ~every 0.15s
    adjustTicker = 0

    local nearest = getNearestKillerModel()
    applyDelayForKillerModel(nearest)
end)

-- immediate update helper when killers spawn/leave or user toggles
local function doImmediateUpdate()
    if not autoAdjustDBTFBPS then return end
    local nearest = getNearestKillerModel()
    applyDelayForKillerModel(nearest)
end

-- respond quickly when killers are added/removed (so toggle reacts immediately)
KillersFolder.ChildAdded:Connect(function() task.delay(0.05, doImmediateUpdate) end)
KillersFolder.ChildRemoved:Connect(function() task.delay(0.05, doImmediateUpdate) end)

local detectorChargeIds = (type(chargeAnimIds) == "table" and chargeAnimIds) or {}

-- Optional: detect a custom charge anim id (if you already use these vars elsewhere)
-- set customChargeEnabled = true and customChargeAnimId = "123456" elsewhere in your script to detect custom anim too
-- local customChargeEnabled = false
-- local customChargeAnimId = ""

-- Override speed (same as your noli script)
local ORIGINAL_DASH_SPEED = 60

-- Toggle / runtime state
local controlChargeEnabled = false
local controlChargeActive = false
local overrideConnection = nil

-- Save/restore for humanoid original values
local savedHumanoidState = {}

local function getHumanoid()
    if not lp or not lp.Character then return nil end
    return lp.Character:FindFirstChildOfClass("Humanoid")
end

local function saveHumState(hum)
    if not hum then return end
    if savedHumanoidState[hum] then return end
    local s = {}
    pcall(function()
        s.WalkSpeed = hum.WalkSpeed
        -- support either JumpPower or JumpHeight
        local ok, _ = pcall(function() s.JumpPower = hum.JumpPower end)
        if not ok then
            pcall(function() s.JumpPower = hum.JumpHeight end)
        end
        -- AutoRotate might not exist on all Humanoids; try to capture if possible
        local ok2, ar = pcall(function() return hum.AutoRotate end)
        if ok2 then s.AutoRotate = ar end
        s.PlatformStand = hum.PlatformStand
    end)
    savedHumanoidState[hum] = s
end

local function restoreHumState(hum)
    if not hum then return end
    local s = savedHumanoidState[hum]
    if not s then return end
    pcall(function()
        if s.WalkSpeed ~= nil then hum.WalkSpeed = s.WalkSpeed end
        if s.JumpPower ~= nil then
            local ok, _ = pcall(function() hum.JumpPower = s.JumpPower end)
            if not ok then pcall(function() hum.JumpHeight = s.JumpPower end) end
        end
        if s.AutoRotate ~= nil then pcall(function() hum.AutoRotate = s.AutoRotate end) end
        if s.PlatformStand ~= nil then hum.PlatformStand = s.PlatformStand end
    end)
    savedHumanoidState[hum] = nil
end

-- Start the override (forces dash movement similar to noli void rush)
local function startOverride()
    if controlChargeActive then return end
    local hum = getHumanoid()
    if not hum then return end

    controlChargeActive = true
    saveHumState(hum)

    -- Make sure humanoid is set to dash state
    pcall(function()
        hum.WalkSpeed = ORIGINAL_DASH_SPEED
        hum.AutoRotate = false
    end)

    -- RenderStepped connection to force forward movement every frame (like your noli function)
    overrideConnection = RunService.RenderStepped:Connect(function()
        local humanoid = getHumanoid()
        local rootPart = humanoid and humanoid.Parent and humanoid.Parent:FindFirstChild("HumanoidRootPart")
        if not humanoid or not rootPart then return end

        -- ensure speed + autorotate each frame (helps if some other code fights it)
        pcall(function()
            humanoid.WalkSpeed = ORIGINAL_DASH_SPEED
            humanoid.AutoRotate = false
        end)

        local direction = rootPart.CFrame.LookVector
        local horizontal = Vector3.new(direction.X, 0, direction.Z)
        if horizontal.Magnitude > 0 then
            humanoid:Move(horizontal.Unit)
        else
            humanoid:Move(Vector3.new(0,0,0))
        end
    end)
end

-- Stop the override and restore humanoid state
local function stopOverride()
    if not controlChargeActive then return end
    controlChargeActive = false

    -- disconnect override loop
    if overrideConnection then
        pcall(function() overrideConnection:Disconnect() end)
        overrideConnection = nil
    end

    -- restore humanoid fields
    local hum = getHumanoid()
    if hum then
        pcall(function()
            -- restore saved values if present
            restoreHumState(hum)
            -- ensure we stop movement
            humanoid:Move(Vector3.new(0,0,0))
        end)
    end
end

-- Internal detection: look for playing anim tracks that match charge IDs or custom ID
local function detectChargeAnimation()
    local hum = getHumanoid()
    if not hum then return false end
    for _, track in ipairs(hum:GetPlayingAnimationTracks()) do
        local ok, animId = pcall(function()
            return tostring(track.Animation and track.Animation.AnimationId or ""):match("%d+")
        end)
        if ok and animId and animId ~= "" then
            if detectorChargeIds and table.find(detectorChargeIds, animId) then
                return true
            end
            if (type(customChargeEnabled) == "boolean" and customChargeEnabled) and customChargeAnimId and tostring(customChargeAnimId) ~= "" then
                if tostring(animId) == tostring(customChargeAnimId) then
                    return true
                end
            end
        end
    end
    return false
end

-- Public toggle control
local function ControlCharge_SetEnabled(val)
    controlChargeEnabled = val and true or false
    if not controlChargeEnabled and controlChargeActive then
        stopOverride()
    end
end

-- Main loop: check detection each RenderStepped (uses same cadence as noli script)
RunService.RenderStepped:Connect(function()
    if not controlChargeEnabled then
        if controlChargeActive then stopOverride() end
        return
    end

    -- If humanoid dies or character resets, ensure override cleared
    local hum = getHumanoid()
    if not hum then
        if controlChargeActive then stopOverride() end
        return
    end

    local isCharging = detectChargeAnimation()

    if isCharging then
        if not controlChargeActive then
            startOverride()
        end
    else
        if controlChargeActive then
            stopOverride()
        end
    end
end)

-- Keep humanoid state fresh on CharacterAdded
lp.CharacterAdded:Connect(function(char)
    -- small wait to let Humanoid exist
    task.spawn(function()
        local hum = char:WaitForChild("Humanoid", 2)
        if hum then
            -- optionally prime saved state (not necessary)
        end
    end)
end)

-- Expose toggle function globally for other script parts or for hotkeys
_G.ControlCharge_SetEnabled = ControlCharge_SetEnabled

-- Example usage:
-- _G.ControlCharge_SetEnabled(true)  -- enable detection/override
-- _G.ControlCharge_SetEnabled(false) -- disable
-- =======================================================================

-- Rayfield GUI for Control Charge (paste near your other CustomAnimationsTab UI code)
-- Requires CustomAnimationsTab from your Rayfield Window (already present in your big script)

-- initialize global defaults so the control block can read them
_G.ControlCharge_DashSpeed = _G.ControlCharge_DashSpeed or 60
_G.ControlCharge_CustomEnabled = _G.ControlCharge_CustomEnabled or false
_G.ControlCharge_CustomAnimId = _G.ControlCharge_CustomAnimId or ""

local function addESP(obj)
    if not obj:IsA("Model") then return end
    if not obj:FindFirstChild("HumanoidRootPart") then return end

    local plr = Players:GetPlayerFromCharacter(obj)
    if not plr then return end -- ✅ only add ESP if it's a player character

    -- Prevent duplicates
    if obj:FindFirstChild("ESP_Highlight") then return end

    -- Highlight
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillColor = Color3.fromRGB(255, 0, 0)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Adornee = obj
    highlight.Parent = obj

    -- Billboard
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Billboard"
    billboard.Size = UDim2.new(0, 100, 0, 50)
    billboard.AlwaysOnTop = true
    billboard.Adornee = obj:FindFirstChild("HumanoidRootPart")
    billboard.Parent = obj

    local textLabel = Instance.new("TextLabel")
    textLabel.Name = "ESP_Text"
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.Text = obj.Name
    textLabel.Parent = billboard
end

-- Function to clear ESP
local function clearESP(obj)
    if obj:FindFirstChild("ESP_Highlight") then
        obj.ESP_Highlight:Destroy()
    end
    if obj:FindFirstChild("ESP_Billboard") then
        obj.ESP_Billboard:Destroy()
    end
end

-- Function to refresh all ESP
local function refreshESP()
    if not espEnabled then
        for _, killer in pairs(KillersFolder:GetChildren()) do
            clearESP(killer)
        end
        return
    end

    for _, killer in pairs(KillersFolder:GetChildren()) do
        addESP(killer)
    end
end


-- Modify ChildAdded connection:
KillersFolder.ChildAdded:Connect(function(child)
    if espEnabled then
        task.wait(0.1) -- wait for HRP
        addESP(child)
    end
end)


KillersFolder.ChildRemoved:Connect(function(child)
    clearESP(child)
end)

-- Distance updater
RunService.RenderStepped:Connect(function()
    if not espEnabled then return end
    local char = lp.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    for _, killer in pairs(KillersFolder:GetChildren()) do
        local billboard = killer:FindFirstChild("ESP_Billboard")
        if billboard and billboard:FindFirstChild("ESP_Text") and killer:FindFirstChild("HumanoidRootPart") then
            local dist = (killer.HumanoidRootPart.Position - hrp.Position).Magnitude
            billboard.ESP_Text.Text = string.format("%s\n[%d]", killer.Name, dist)
        end
    end
end)

local _LP = Players.LocalPlayer
local _isFacing = isFacing
local _fireRemoteBlock = fireRemoteBlock
local _fireRemotePunch = fireRemotePunch
local _cachedBlockBtn = cachedBlockBtn
local _cachedCooldown = cachedCooldown            -- these may be updated by refreshUIRefs
local _cachedCharges = cachedCharges
local LOCAL_BLOCK_COOLDOWN = 0.7   -- optimistic local cooldown (tune as needed)
local lastLocalBlockTime = 0

-- Helpers
local function fireRemoteBlock()
local args = {"UseActorAbility", "Block"}
ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end

local function fireRemotePunch()
local args = {"UseActorAbility", "Punch"}
ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end



-- replace existing playCustomAnim with this
local function playCustomAnim(animId, isPunch)
    if not Humanoid then
        warn("Humanoid missing")
        return
    end

    if not animId or animId == "" then
        warn("No animation ID provided")
        return
    end

    local now = tick()
    local lastTime = isPunch and lastPunchTime or lastBlockTime
    if now - lastTime < 1 then
        return
    end

    -- Stop other known anims (unchanged)
    for _, track in ipairs(Humanoid:GetPlayingAnimationTracks()) do
        local animNum = tostring(track.Animation and track.Animation.AnimationId):match("%d+")
        if table.find(isPunch and punchAnimIds or blockAnimIds, animNum) then
            pcall(function() track:Stop() end)
        end
    end

    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://" .. animId

    local success, track = pcall(function()
        return Humanoid:LoadAnimation(anim)
    end)

    if success and track then
        print("✅ Playing custom " .. (isPunch and "punch" or "block") .. " animation:", animId)
        track:Play()

        -- record last-play time (keeps original behavior)
        if isPunch then
            lastPunchTime = now
        else
            lastBlockTime = now
        end

        -- stop the custom track automatically after X seconds
        local duration = isPunch and 2.7 or 2.0
        -- use task.delay so we don't block; use pcall to avoid runtime errors
        task.delay(duration, function()
            pcall(function()
                if track and track.IsPlaying then
                    track:Stop()
                end
            end)
        end)
    else
        warn("❌ Failed to load or play custom animation: " .. tostring(animId))
    end
end
-- Push *into* the killer (drops in for doLegitBlockTP_withVelocity)



-- Fling coroutine
coroutine.wrap(function()
    local hrp, c, vel, movel = nil, nil, nil, 0.1
    while true do
        RunService.Heartbeat:Wait()
        if hiddenfling then
            while hiddenfling and not (c and c.Parent and hrp and hrp.Parent) do
                RunService.Heartbeat:Wait()
                c = lp.Character
                hrp = c and c:FindFirstChild("HumanoidRootPart")
            end
            if hiddenfling then
                vel = hrp.Velocity
                hrp.Velocity = vel * flingPower + Vector3.new(0, flingPower, 0)
                RunService.RenderStepped:Wait()
                hrp.Velocity = vel
                RunService.Stepped:Wait()
                hrp.Velocity = vel + Vector3.new(0, movel, 0)
                movel = movel * -1
            end
        end
    end
end)()

local function sendChatMessage(text)
    if not text or text:match("^%s*$") then return end
    local TextChatService = game:GetService("TextChatService")
    local channel = TextChatService.TextChannels.RBXGeneral

    channel:SendAsync(text)
end

-- ===== Robust Sound Auto Block (replace your current Sound Auto Block) =====
local soundHooks = {}     -- [Sound] = {playedConn, propConn, destroyConn}
local soundBlockedUntil = {} -- [Sound] = timestamp when we can block again (throttle)

local function getNearestKillerRoot(maxDist)
    local killersFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
    if not killersFolder then return nil end

    local myRoot = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end

    local closest, closestDist = nil, maxDist or math.huge
    for _, killer in ipairs(killersFolder:GetChildren()) do
        local hrp = killer:FindFirstChild("HumanoidRootPart")
        if hrp then
            local dist = (hrp.Position - myRoot.Position).Magnitude
            if dist < closestDist then
                closest, closestDist = hrp, dist
            end
        end
    end
    return closest
end

-- place once in outer scope if this runs in a hot loop
local string_match = string.match
local tostring_local = tostring

local function extractNumericSoundId(sound)
    if not sound then return nil end

    local sid = sound.SoundId
    if not sid then return nil end
    sid = (type(sid) == "string") and sid or tostring_local(sid)

    -- Prefer explicit "rbxassetid://" pattern (most common), then generic "://digits", then plain digits
    local num =
        string_match(sid, "rbxassetid://(%d+)") or
        string_match(sid, "://(%d+)") or
        string_match(sid, "^(%d+)$")

    if num and #num > 0 then
        return num
    end

    -- Fallbacks (kept for completeness)
    local hash = string_match(sid, "[&%?]hash=([^&]+)")
    if hash then
        return "&hash=" .. hash
    end

    local path = string_match(sid, "rbxasset://sounds/.+")
    if path then
        return path
    end

    return nil
end

-- cache KillersFolder outside the function when possible:
local KF = KillersFolder

local function getSoundWorldPosition(sound)
    if not sound then return nil end

    local parent = sound.Parent
    if parent then
        if parent:IsA("BasePart") then
            return parent.Position, parent
        end

        if parent:IsA("Attachment") then
            local gp = parent.Parent
            if gp and gp:IsA("BasePart") then
                return gp.Position, gp
            end
        end
    end

    -- Only perform deep descendant search if the sound is inside KillersFolder
    if KF and sound:IsDescendantOf(KF) then
        -- search descendants of the nearest meaningful root (prefer parent if present)
        local root = parent or sound
        local found = root:FindFirstChildWhichIsA("BasePart", true)
        if found then
            return found.Position, found
        end
    end

    return nil, nil
end

local function getCharacterFromDescendant(inst)
    if not inst then return nil end
    local model = inst:FindFirstAncestorOfClass("Model")
    if model and model:FindFirstChildOfClass("Humanoid") then
        return model
    end
    return nil
end

local function isPointInsidePart(part, point)
    if not (part and point) then return false end
    -- convert world point to part-local coordinates and test against half-extents
    local rel = part.CFrame:PointToObjectSpace(point)
    local half = part.Size * 0.5
    return math.abs(rel.X) <= half.X + 0.001 and
           math.abs(rel.Y) <= half.Y + 0.001 and
           math.abs(rel.Z) <= half.Z + 0.001
end

-- ===== predictive helpers (paste near top, before attemptBlockForSound) =====

-- keep killerState updated each frame (lightweight)
RunService.RenderStepped:Connect(function(dt)
    if dt <= 0 then return end
    local killersFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
    if not killersFolder then return end

    for _, killer in ipairs(killersFolder:GetChildren()) do
        if killer and killer.Parent then
            local hrp = killer:FindFirstChild("HumanoidRootPart")
            if hrp then
                local st = killerState[killer] or { prevPos = hrp.Position, prevLook = hrp.CFrame.LookVector, vel = Vector3.new(), angVel = 0 }
                -- linear velocity sample & smoothing
                local newVel = (hrp.Position - st.prevPos) / math.max(dt, 1e-6)
                st.vel = st.vel and st.vel:Lerp(newVel, SMOOTHING_LERP) or newVel

                -- angular velocity (radians/sec, signed by left/right)
                local prevLook = st.prevLook or hrp.CFrame.LookVector
                local look = hrp.CFrame.LookVector
                local dot = math.clamp(prevLook:Dot(look), -1, 1)
                local angle = math.acos(dot) -- 0..pi
                local crossY = prevLook:Cross(look).Y
                local angSign = (crossY >= 0) and 1 or -1
                local newAngVel = (angle / math.max(dt, 1e-6)) * angSign
                st.angVel = (st.angVel * (1 - SMOOTHING_LERP)) + (newAngVel * SMOOTHING_LERP)

                st.prevPos = hrp.Position
                st.prevLook = look
                killerState[killer] = st
            end
        end
    end
end)

local function fireGuiBlock()
    local blockAction = "UseActorAbility"
    local blockData = {buffer.fromstring("\"Block\"")}
    
    testRemote:FireServer(blockAction, blockData)
end

local function fireGuiPunch()
    local punchAction = "UseActorAbility"
    local punchData = {buffer.fromstring("\"Punch\"")}
    
    testRemote:FireServer(punchAction, punchData)
end

local function fireGuiCharge()
    local blockAction = "UseActorAbility"
    local blockData = {buffer.fromstring("\"Charge\"")}
    
    testRemote:FireServer(blockAction, blockData)
end

local function fireGuiClone()
    local blockAction = "UseActorAbility"
    local blockData = {buffer.fromstring("\"Clone\"")}

    testRemote:FireServer(blockAction, blockData)
end

local chargeAimActive = false
local chargeAimThread = nil

local function stopChargeAim()
    chargeAimActive = false
    -- thread will exit when it notices the flag; we don't force-kill it
end

-- Start aiming at nearest killer until the charge animation stops (or fallback timeout)
-- fallbackSec is optional (seconds) to stop attempting if no animation is detected.
local function startChargeAimUntilChargeEnds(fallbackSec)
    -- ensure only one thread at a time
    stopChargeAim()
    chargeAimActive = true

    chargeAimThread = task.spawn(function()
        local startWatch = tick()
        local fallback = tonumber(fallbackSec) or 1.2

        -- try to get humanoid/root/animator
        local function getCharObjects()
            local char = lp.Character
            if not char then return nil, nil, nil end
            local hum = char:FindFirstChildOfClass("Humanoid")
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local animator = char:FindFirstChildOfClass("Animator")
            return hum, hrp, animator
        end

        local humanoid, myRoot, animator = getCharObjects()
        if humanoid then
            pcall(function() humanoid.AutoRotate = false end)
        end

        local seenChargeAnim = false
        local watchStart = tick()

        while chargeAimActive do
            -- refresh references each loop in case character reloaded
            humanoid, myRoot, animator = getCharObjects()
            if not myRoot then break end

            -- find nearest killer model and its hrp
            local killerModel = getNearestKillerModel()
            local targetHRP = (killerModel and killerModel:FindFirstChild("HumanoidRootPart")) or nil

            if targetHRP then
                -- predictionValue exists in your script (used by aimPunch). use it for nicer aiming.
                local pred = (type(predictionValue) == "number") and predictionValue or 0
                local predictedPos = targetHRP.Position + (targetHRP.CFrame.LookVector * pred)

                -- set lookAt while keeping our position
                pcall(function()
                    myRoot.CFrame = CFrame.lookAt(myRoot.Position, predictedPos)
                end)
            end

            -- check if charge animation is playing (if we can access animator)
            local stillPlaying = false
            if animator then
                local ok, tracks = pcall(function() return animator:GetPlayingAnimationTracks() end)
                if ok and tracks then
                    for _, track in ipairs(tracks) do
                        local animId = nil
                        pcall(function() animId = tostring(track.Animation and track.Animation.AnimationId or ""):match("%d+") end)
                        if animId and table.find(chargeAnimIds, animId) then
                            stillPlaying = true
                            seenChargeAnim = true
                            break
                        end
                    end
                end
            end

            -- stop conditions:
            -- 1) we saw a charge anim and now it's gone -> stop
            if seenChargeAnim and not stillPlaying then
                break
            end

            -- 2) we never saw a charge anim and we've exceeded fallback -> stop
            if not seenChargeAnim and (tick() - watchStart) > fallback then
                break
            end

            task.wait()
        end

        -- restore AutoRotate
        if humanoid then
            pcall(function() humanoid.AutoRotate = true end)
        end

        chargeAimActive = false
    end)
end

-- modify hookSound: store extracted id once

-- optimized attemptBlockForSound (accepts optional precomputed id)
-- Replace your existing attemptBlockForSound with this improved version
-- TUNABLES (put near top of file so you can tweak for high ping)
local AUDIO_PREDICT_DT = 0.08        -- seconds to predict forward (increase for high ping)
local AUDIO_LOCAL_COOLDOWN = 0.35    -- local throttle between blocks (seconds)
local AUDIO_SOUND_THROTTLE = 1.0     -- how long to throttle the same sound (seconds)

-- helper: fast squared distance (no sqrt)
local function distSq(a, b)
    local dx = a.X - b.X
    local dy = a.Y - b.Y
    local dz = a.Z - b.Z
    return dx*dx + dy*dy + dz*dz
end

local _getSoundWorldPosition = getSoundWorldPosition

-- shared heavy work helper (local to file/scope)
local function _attemptForSound(sound, idParam, mode)
    -- quick guards (keep same order)
    if not autoBlockAudioOn then return end
    if not sound or not sound:IsA("Sound") then return end
    if not sound.IsPlaying then return end

    -- hot locals
    local now = tick()
    local hooks = soundHooks
    local hook = hooks and hooks[sound]

    -- id resolution (prefer cached)
    local id = idParam or (hook and hook.id) or extractNumericSoundId(sound)
    if not id or not autoBlockTriggerSounds[id] then return end

    -- per-sound throttle
    if soundBlockedUntil[sound] and now < soundBlockedUntil[sound] then return end

    -- global local cooldown
    if now - lastLocalBlockTime < AUDIO_LOCAL_COOLDOWN then return end

    -- ensure UI refs depending on mode (preserve original checks)
    if mode == "Block" or mode == "Charge" then
        if not cachedBlockBtn or not cachedCooldown or not cachedCharges then
            refreshUIRefs()
        end
    elseif mode == "Clone" then
        if not cachedCloneBtn then
            refreshUIRefs()
        end
    end

    -- local player root
    local lpLocal = _LP or Players.LocalPlayer
    local myChar = lpLocal and lpLocal.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end

    -- cached hook mapping (may be nil)
    local char = hook and hook.char
    local hrp = hook and hook.hrp

    if not hrp then
        -- expensive path: only when cache missing
        local soundPos, soundPart = getSoundWorldPosition(sound)
        if not soundPart then return end
        char = getCharacterFromDescendant(soundPart)
        hrp = char and char:FindFirstChild("HumanoidRootPart")
        -- cache mapping for next time
        if hook then
            hook.char = char
            hook.hrp = hrp
        else
            soundHooks[sound] = { id = id, char = char, hrp = hrp }
            hook = soundHooks[sound]
        end
    end

    if not hrp then return end

    -- predicted position using velocity (unrolled for speed)
    local v = hrp.Velocity or Vector3.new()
    local predictedX = hrp.Position.X + v.X * AUDIO_PREDICT_DT
    local predictedY = hrp.Position.Y + v.Y * AUDIO_PREDICT_DT
    local predictedZ = hrp.Position.Z + v.Z * AUDIO_PREDICT_DT

    local dx = predictedX - myRoot.Position.X
    local dy = predictedY - myRoot.Position.Y
    local dz = predictedZ - myRoot.Position.Z
    local distSqPred = dx*dx + dy*dy + dz*dz

    -- detection range check (preserve grace fallback logic)
    if detectionRangeSq and distSqPred > detectionRangeSq then
        local dx2 = hrp.Position.X - myRoot.Position.X
        local dy2 = hrp.Position.Y - myRoot.Position.Y
        local dz2 = hrp.Position.Z - myRoot.Position.Z
        local distSqNow = dx2*dx2 + dy2*dy2 + dz2*dz2
        local grace = (detectionRange + 3) * (detectionRange + 3)
        if distSqNow > grace then
            return
        end
    end

    -- verify sound world position (kept as in original)
    local soundPos, soundPart = _getSoundWorldPosition(sound)
    if not soundPart then return end

    -- climb to Model & validate humanoid
    local model = soundPart and soundPart:FindFirstAncestorOfClass("Model") or nil
    if not model then return end

    local humanoid = model:FindFirstChildWhichIsA("Humanoid")
    if not humanoid then return end

    local plr = Players:GetPlayerFromCharacter(model)
    if not plr or plr == lp then return end

    -- facing check (cached _isFacing)
    if facingCheckEnabled and not _isFacing(myRoot, hrp) then
        return
    end

    task.wait(blockdelay)

    -- mode-specific extra checks & actions (preserve prints and exact calls)
    if mode == "Block" then
        if cachedCooldown and cachedCooldown.Text == "" then
            print("yay")
        else
            return
        end
        fireGuiBlock()
        if doubleblocktech == true then
            fireGuiPunch()
        end
    elseif mode == "Charge" then
        if cachedChargeBtn and cachedChargeBtn:FindFirstChild("CooldownTime") and cachedChargeBtn.CooldownTime.Text == "" then
            print("yay")
        else
            return
        end
        fireGuiCharge()
        startChargeAimUntilChargeEnds(0.4)
    elseif mode == "Clone" then
        if cachedCloneBtn and cachedCloneBtn:FindFirstChild("CooldownTime") and cachedCloneBtn.CooldownTime.Text == "" then
            print("yay")
        else
            return
        end
        fireGuiClone()
        startChargeAimUntilChargeEnds(0.4)
    end

    -- optimistic local timestamp & throttle this sound (identical)
    lastLocalBlockTime = now
    soundBlockedUntil[sound] = now + AUDIO_SOUND_THROTTLE
end

-- public wrappers to preserve original names/behavior
local function attemptBlockForSound(sound, idParam)
    return _attemptForSound(sound, idParam, "Block")
end

local function attemptChargeForSound(sound, idParam)
    return _attemptForSound(sound, idParam, "Charge")
end

local function attemptCloneForSound(sound, idParam)
    return _attemptForSound(sound, idParam, "Clone")
end

-- Improved hookSound: cache id and keep placeholder for hrp/char (so attemptBlock hot-path reads cached data)

local function attemptBDParts(sound)
    if not autoBlockAudioOn then return end
    if not sound or not sound:IsA("Sound") then return end
    if not sound.IsPlaying then return end

    local id = extractNumericSoundId(sound)
    if not id or not autoBlockTriggerSounds[id] then return end

    local t = tick()
    if soundBlockedUntil[sound] and t < soundBlockedUntil[sound] then return end

    local lp = Players.LocalPlayer
    local myChar = lp and lp.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end

    local soundPos, soundPart = getSoundWorldPosition(sound)
    if not soundPos or not soundPart then return end

    local char = getCharacterFromDescendant(soundPart)
    local plr = char and Players:GetPlayerFromCharacter(char)
    if not plr or plr == lp then return end

    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local Debris = game:GetService("Debris")

    if antiFlickOn then
        local basePartSize = Vector3.new(5.5, 7.5, 8.5)  -- original / default size
        local partSize = basePartSize * (blockPartsSizeMultiplier or 1)
        local count = math.max(1, antiFlickParts or 4)
        local base  = antiFlickBaseOffset or 2.5
        local step  = antiFlickOffsetStep or 0.2
        local lifeTime = 0.2

        task.spawn(function()
            local blocked = false
            task.wait(antiFlickDelay or 0)
            for i = 1, count do
                if not hrp or not myRoot then break end

                local dist = base + (i - 1) * step

                local st = killerState[char] or { vel = hrp.Velocity or Vector3.new(), angVel = 0 }
                local vel = st.vel or hrp.Velocity or Vector3.new()

                local forwardSpeed = vel:Dot(hrp.CFrame.LookVector)
                local lateralSpeed = vel:Dot(hrp.CFrame.RightVector)

                -- separate multipliers
                local pStrength = (type(predictionStrength) == "number" and predictionStrength) or 1
                local pTurn = (type(predictionTurnStrength) == "number" and predictionTurnStrength) or 1

                -- raw predicted displacements
                local forwardPredictRaw = forwardSpeed * PRED_SECONDS_FORWARD * pStrength
                local lateralPredictRaw = lateralSpeed * PRED_SECONDS_LATERAL * pStrength
                local turnLateralRaw    = st.angVel * ANG_TURN_MULTIPLIER * pTurn

                -- clamps (scaled separately)
                local forwardClamp = PRED_MAX_FORWARD * pStrength
                local lateralClamp = PRED_MAX_LATERAL * pStrength
                local turnClamp    = PRED_MAX_LATERAL * pTurn

                local forwardPredict = math.clamp(forwardPredictRaw, -forwardClamp, forwardClamp)
                local lateralPredict = math.clamp(lateralPredictRaw, -lateralClamp, lateralClamp)
                local turnLateral = math.clamp(turnLateralRaw, -turnClamp, turnClamp)

                local forwardDist = dist + forwardPredict

                local spawnPos = hrp.Position
                                + hrp.CFrame.LookVector * forwardDist
                                + hrp.CFrame.RightVector * (lateralPredict + turnLateral)

                local part = Instance.new("Part")
                part.Name = "AntiFlickZone"
                part.Size = partSize
                part.Transparency = 0.45
                part.Anchored = true
                part.CanCollide = false
                part.CFrame = CFrame.new(spawnPos, hrp.Position)
                part.BrickColor = BrickColor.new("Bright blue")
                part.Parent = workspace

                Debris:AddItem(part, lifeTime)

                if isPointInsidePart(part, myRoot.Position) then
                    blocked = true
                else
                    local touching = {}
                    pcall(function() touching = myRoot:GetTouchingParts() end)
                    for _, p in ipairs(touching) do
                        if p == part then
                            blocked = true
                            break
                        end
                    end
                end

                if blocked then
                    if not (facingCheckEnabled and not isFacing(myRoot, hrp)) then
                        if autoblocktype == "Block" then
                            fireGuiBlock()
                        elseif autoblocktype == "Charge" then
                            fireGuiCharge()
                        elseif autoblocktype == "7n7 Clone" then
                            fireGuiClone()
                        end
                        soundBlockedUntil[sound] = t + 1.2
                    end
                    break
                end

                if stagger and stagger > 0 then
                    task.wait(stagger)
                else
                    task.wait(0)
                end
            end
        end)
        return
    end
end

local function hookSound(sound)
    if not sound or not sound:IsA("Sound") then return end
    if soundHooks[sound] then return end

    local preId = extractNumericSoundId(sound)

    -- create entry with id; hrp/char may be nil initially and will be cached later
    soundHooks[sound] = { id = preId, hrp = nil, char = nil }

    -- helper: centralize the logic so behaviour remains identical but without duplication
    local function handleAttempt(snd, id)
        if not autoBlockAudioOn then return end

        if not antiFlickOn then
            local at = autoblocktype
            if at == "Block" then
                attemptBlockForSound(snd, id)
            elseif at == "Charge" then
                attemptChargeForSound(snd, id)
            elseif at == "7n7 Clone" then
                attemptCloneForSound(snd, id)
            end
        else
            attemptBDParts(snd, id)
        end
    end

    -- connections
    local playedConn = sound.Played:Connect(function()
        handleAttempt(sound, preId)
    end)

    local propConn = sound:GetPropertyChangedSignal("IsPlaying"):Connect(function()
        if sound.IsPlaying then
            handleAttempt(sound, preId)
        end
    end)

    local destroyConn
    destroyConn = sound.Destroying:Connect(function()
        if playedConn and playedConn.Connected then playedConn:Disconnect() end
        if propConn and propConn.Connected then propConn:Disconnect() end
        if destroyConn and destroyConn.Connected then destroyConn:Disconnect() end
        soundHooks[sound] = nil
        soundBlockedUntil[sound] = nil
    end)

    -- store connections & metadata in hook table for later cleanup if you want (optional)
    soundHooks[sound].playedConn = playedConn
    soundHooks[sound].propConn = propConn
    soundHooks[sound].destroyConn = destroyConn

    -- If currently playing, handle immediately (cheap)
    if sound.IsPlaying then
        handleAttempt(sound, preId)
    end
end

-- Hook existing Sounds across the game (covers workspace, SoundService, Lighting, etc.)
for _, desc in ipairs(KillersFolder:GetDescendants()) do
    if desc:IsA("Sound") then
        hookSound(desc)
    end
end

-- Hook any future Sounds
KillersFolder.DescendantAdded:Connect(function(desc)
    if desc:IsA("Sound") then
        hookSound(desc)
    end
end)

-- Utility to safely get a killer HRP
local function getKillerHRP(killerModel)
    if not killerModel then return nil end
    if killerModel:FindFirstChild("HumanoidRootPart") then
        return killerModel:FindFirstChild("HumanoidRootPart")
    end
    if killerModel.PrimaryPart then
        return killerModel.PrimaryPart
    end
    -- try finding any basepart descendant
    return killerModel:FindFirstChildWhichIsA("BasePart", true)
end

local function beginDragIntoKiller(killerModel)
    -- Basic guards
    if _hitboxDraggingDebounce then return end
    if not killerModel or not killerModel.Parent then return end
    local char = lp and lp.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not humanoid then return end

    local targetHRP = getKillerHRP(killerModel)
    if not targetHRP then
        warn("beginDragIntoKiller: killer has no HRP/PrimaryPart")
        return
    end

    _hitboxDraggingDebounce = true

    -- save old locomotion state so we can restore it
    local oldWalk = humanoid.WalkSpeed
    local oldJump = humanoid.JumpPower
    local oldPlatformStand = humanoid.PlatformStand

    -- block normal movement by zeroing walk/jump (works for mobile joystick too)
    humanoid.WalkSpeed = 0
    humanoid.JumpPower = 0
    humanoid.PlatformStand = false  -- keep physics normal so BodyVelocity works

    -- create BodyVelocity to push the HRP toward the killer smoothly
    local bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(1e5, 0, 1e5)     -- allow horizontal movement, keep y free
    bv.Velocity = Vector3.new(0,0,0)
    bv.Parent = hrp

    -- optional: lightly damp vertical to avoid sudden pops (leave Y alone to respect gravity)
    local conn
    conn = RunService.Heartbeat:Connect(function(dt)
        if not _hitboxDraggingDebounce then
            conn:Disconnect()
            if bv and bv.Parent then pcall(function() bv:Destroy() end) end
            humanoid.WalkSpeed = oldWalk
            humanoid.JumpPower = oldJump
            humanoid.PlatformStand = oldPlatformStand
            return
        end

        -- abort if character/killer removed
        if not (char and char.Parent) or not (killerModel and killerModel.Parent) then
            _hitboxDraggingDebounce = false
            return
        end

        -- refresh target HRP (killer may respawn)
        targetHRP = getKillerHRP(killerModel)
        if not targetHRP then
            _hitboxDraggingDebounce = false
            return
        end

        -- compute desired horizontal velocity toward the target
        local toTarget = (targetHRP.Position - hrp.Position)
        local dist = toTarget.Magnitude
        -- desired speed: based on distance but clamped so it feels natural
        
        local horiz = Vector3.new(toTarget.X, 0, toTarget.Z)
        if horiz.Magnitude > 0.01 then
            local dir = horiz.Unit
            bv.Velocity = Vector3.new(dir.X * Dspeed, bv.Velocity.Y, dir.Z * Dspeed)
        else
            bv.Velocity = Vector3.new(0, bv.Velocity.Y, 0)
        end

        -- stop condition: when very close to killer (adjust threshold as needed)
        local stopDist = 2.0
        if dist <= stopDist then
            _hitboxDraggingDebounce = false
            -- cleanup will happen in next loop tick
        end
    end)

    -- final cleanup safety (timeout)
    task.delay(0.4, function()
        if _hitboxDraggingDebounce then
            _hitboxDraggingDebounce = false
        end
    end)
end

-- Example call:
-- beginDragIntoKiller(someKillerModel)

-- Watch for local block animations starting and trigger drag
RunService.RenderStepped:Connect(function()
    if not hitboxDraggingTech then return end
    if not cachedAnimator then refreshAnimator() end
    local animator = cachedAnimator
    if not animator then return end

    for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
        local ok, animId = pcall(function()
            local a = track.Animation
            return a and tostring(a.AnimationId):match("%d+")
        end)
        if ok and animId and table.find(blockAnimIds, animId) then
            -- only trigger once when it starts (timepos ~ 0)
            local timePos = 0
            pcall(function() timePos = track.TimePosition or 0 end)
            if timePos <= 0.12 then
                local nearest = getNearestKillerModel()
                if nearest then
                    -- spawn so we don't block the RenderStepped loop
                    task.wait(Ddelay)
                    task.spawn(function() beginDragIntoKiller(nearest) end)
                    startChargeAimUntilChargeEnds(0.4)
                end
            end
        end
    end
end)

-- If Better Detection (antiFlickOn) is enabled, watch for blue AntiFlickZone parts near the player
-- and trigger dragging when they appear in range.
task.spawn(function()
    if not cachedBlockBtn or not cachedCooldown or not cachedCharges then
        refreshUIRefs()
    end

    if cachedBlockBtn and cachedBlockBtn:FindFirstChild("CooldownTime") and cachedBlockBtn.CooldownTime.Text == "" then
        print("yay")
    else
        return
    end

    while true do
        RunService.Heartbeat:Wait()
        if not (hitboxDraggingTech and antiFlickOn) then
            task.wait(0.15)
            continue
        end

        local char = lp.Character
        local myRoot = char and char:FindFirstChild("HumanoidRootPart")
        if not myRoot then task.wait(0.15) continue end

        -- look for parts named "AntiFlickZone" inside radius (fast and simple)
        local found = nil
        for _, part in ipairs(workspace:GetDescendants()) do
            if not part:IsA("BasePart") then continue end
            if part.Name ~= "AntiFlickZone" then continue end
            if (part.Position - myRoot.Position).Magnitude <= HITBOX_DETECT_RADIUS then
                found = part
                break
            end
        end        
        if found and not _hitboxDraggingDebounce then
            local nearest = getNearestKillerModel()
            if nearest then
                task.wait(Ddelay)
                task.spawn(function() beginDragIntoKiller(nearest) end)
                startChargeAimUntilChargeEnds(0.4)
            end
        end
        task.wait(0.12) -- throttle checks
    end
end)

-- double-punch tech detection
-- Replacement double-punch detection (safer + debounced)
local _REFRESH_UI_IF_NIL = true
local TRACK_DEBOUNCE = 0.45   -- seconds to avoid retriggering same track
local START_WINDOW = 0     -- consider a track "starting" if TimePosition <= START_WINDOW

local trackLastTriggered = setmetatable({}, { __mode = "k" }) -- weak keys (AnimationTrack -> last tick)


-- Play a custom charge animation and stop it when LP touches a non-player part or after 4s
local function playCustomChargeWithAutoStop(animId)
    if not lp or not lp.Character then return end
    local char = lp.Character
    local hum = char:FindFirstChildOfClass("Humanoid")
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hum or not hrp then return end

    -- get or create Animator
    local animator = hum:FindFirstChildOfClass("Animator") or Instance.new("Animator", hum)

    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://" .. tostring(animId)

    local ok, track = pcall(function() return animator:LoadAnimation(anim) end)
    if not ok or not track then
        warn("Failed to load charge animation:", animId)
        return
    end

    track:Play()

    local stopped = false
    local touchConn
    local timeoutConn

    -- stop function (safe, idempotent)
    local function stopTrack()
        if stopped then return end
        stopped = true
        pcall(function() track:Stop() end)
        if touchConn and touchConn.Connected then pcall(function() touchConn:Disconnect() end) end
        if timeoutConn and timeoutConn.Connected then pcall(function() timeoutConn:Disconnect() end) end
    end

    -- stop when HRP touches a part that's not part of our character
    touchConn = hrp.Touched:Connect(function(part)
        if stopped then return end
        if not part then return end
        if part:IsDescendantOf(char) then return end -- ignore touching own character parts
        -- optional: ignore other players' characters if you want; here we treat anything not part of our char as "wall"
        stopTrack()
    end)

    -- timeout after 4 seconds (hard stop)
    timeoutConn = nil
    task.spawn(function()
        local start = tick()
        while not stopped and (tick() - start) < 4 do
            task.wait(0.05)
        end
        if not stopped then
            stopTrack()
        end
    end)

    -- try to clean up if the track stops normally (AnimationTrack may have Stopped event)
    pcall(function()
        if track.Stopped then
            track.Stopped:Connect(stopTrack)
        end
    end)
end

local lastReplaceTime = {
    block = 0,
    punch = 0,
    charge = 0,
}

task.spawn(function()
    while true do
        RunService.Heartbeat:Wait()

        local char = lp.Character
        if not char then continue end

        local humanoid = char:FindFirstChildOfClass("Humanoid")
        local animator = humanoid and humanoid:FindFirstChildOfClass("Animator")
        if not animator then continue end

        for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
            local animId = tostring(track.Animation.AnimationId):match("%d+")

            -- Block animation replacement
            if customBlockEnabled and customBlockAnimId ~= "" and table.find(blockAnimIds, animId) then
                if animId == tostring(customBlockAnimId) then
                    continue -- already custom anim
                end
            
                if tick() - lastReplaceTime.block >= 3 then
                    lastReplaceTime.block = tick()
                    track:Stop()

                    local newAnim = Instance.new("Animation")
                    newAnim.AnimationId = "rbxassetid://" .. customBlockAnimId
                    local newTrack = animator:LoadAnimation(newAnim)
                    newTrack:Play()

                    -- auto-stop after 2.7 seconds (safe)
                    task.delay(customblockdelay, function()
                        pcall(function()
                            if newTrack and newTrack.IsPlaying then
                                newTrack:Stop()
                            end
                        end)
                    end)

                    break
                end
            end

            -- Punch animation replacement
            if customPunchEnabled and customPunchAnimId ~= "" and table.find(punchAnimIds, animId) then
                if animId == tostring(customPunchAnimId) then
                    continue -- already custom anim
                end
            
                if tick() - lastReplaceTime.punch >= 3 then
                    lastReplaceTime.punch = tick()
                    track:Stop()
  
                    -- with this patch:
                    local newAnim = Instance.new("Animation")
                    newAnim.AnimationId = "rbxassetid://" .. customPunchAnimId
                    local newTrack = animator:LoadAnimation(newAnim)
                    newTrack:Play()

                    -- auto-stop after 2.7 seconds (safe)
                    task.delay(custompunchdelay, function()
                        pcall(function()
                            if newTrack and newTrack.IsPlaying then
                                newTrack:Stop()
                            end
                        end)
                    end)

                    break
                end
            end

            -- Charge animation replacement
            if customChargeEnabled and customChargeAnimId ~= "" and table.find(chargeAnimIds, animId) then
                if animId == tostring(customChargeAnimId) then
                    continue -- already custom anim
                end

                if tick() - lastReplaceTime.charge >= 3 then
                    lastReplaceTime.charge = tick()
                    track:Stop()

                    local newAnim = Instance.new("Animation")
                    newAnim.AnimationId = "rbxassetid://" .. customChargeAnimId
                    -- Instead of directly playing the custom track, use the helper so it auto-stops on touch or after 4s
                    playCustomChargeWithAutoStop(customChargeAnimId)
                    break
                end
            end
        end
    end
end)

-- Auto block + punch detection loop
RunService.RenderStepped:Connect(function()
    local gui = PlayerGui:FindFirstChild("MainUI")
    local punchBtn = gui and gui:FindFirstChild("AbilityContainer") and gui.AbilityContainer:FindFirstChild("Punch")
    local charges = punchBtn and punchBtn:FindFirstChild("Charges")
    local blockBtn = gui and gui:FindFirstChild("AbilityContainer") and gui.AbilityContainer:FindFirstChild("Block")
    local cooldown = blockBtn and blockBtn:FindFirstChild("CooldownTime")

    local myChar = lp.Character
    if not myChar then return end
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    Humanoid = myChar:FindFirstChildOfClass("Humanoid")
        -- Auto Block: Trigger block if a valid animation is played by a killer
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= lp and plr.Character then
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            local hum = plr.Character:FindFirstChildOfClass("Humanoid")
            local animTracks = hum and hum:FindFirstChildOfClass("Animator") and hum:FindFirstChildOfClass("Animator"):GetPlayingAnimationTracks()

            if hrp and myRoot and (hrp.Position - myRoot.Position).Magnitude <= detectionRange then
                for _, track in ipairs(animTracks or {}) do
                    local id = tostring(track.Animation.AnimationId):match("%d+")
                    if table.find(autoBlockTriggerAnims, id) then
                        if autoBlockOn and (hrp.Position - myRoot.Position).Magnitude <= detectionRange then
                            if isFacing(myRoot, hrp) then
                                if cooldown and cooldown.Text == "" then
                                    fireGuiBlock()
                                end
                                if doubleblocktech == true and charges and charges.Text == "1" then
                                    fireGuiPunch()
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    -- Detect if player is playing a block animation, and blockTP is enabled

    -- Predictive Auto Block: Check killer range and time
    if predictiveBlockOn and tick() > predictiveCooldown then
        local killersFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
        local myChar = lp.Character
        local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
        local myHum = myChar and myChar:FindFirstChild("Humanoid")

        if killersFolder and myHRP and myHum then
            local killerInRange = false

            for _, killer in ipairs(killersFolder:GetChildren()) do
                local hrp = killer:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local dist = (myHRP.Position - hrp.Position).Magnitude
                    if dist <= detectionRange then
                        killerInRange = true
                        break
                    end
                end
            end

            -- Handle killer entering range
            if killerInRange then
                if not killerInRangeSince then
                    killerInRangeSince = tick()  -- Start the timer when the killer enters the range
                elseif tick() - killerInRangeSince >= edgeKillerDelay then
                    -- Block if the killer has stayed in range long enough
                    fireRemoteBlock()
                    predictiveCooldown = tick() + 2  -- Set cooldown to avoid blocking too quickly again
                    killerInRangeSince = nil  -- Reset the timer
                end
            else
                killerInRangeSince = nil  -- Reset timer if the killer leaves range
            end
        end
    end


    local myChar = lp.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    -- Auto Punch
    if autoPunchOn then
        if charges and charges.Text == "1" then
            
            for _, name in ipairs(killerNames) do
                local killer = workspace:FindFirstChild("Players")
                    and workspace.Players:FindFirstChild("Killers")
                    and workspace.Players.Killers:FindFirstChild(name)
                if killer and killer:FindFirstChild("HumanoidRootPart") then
                    local root = killer.HumanoidRootPart
                    if root and myRoot and (root.Position - myRoot.Position).Magnitude <= 10 then

                        -- Trigger punch GUI button
                        fireGuiPunch()

                        -- Fling Punch: Constant TP 2 studs in front of killer for 1 second
                        if flingPunchOn then
                            hiddenfling = true
                            local targetHRP = root
                            task.spawn(function()
                                local start = tick()
                                while tick() - start < 1 do
                                    if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") and targetHRP and targetHRP.Parent then
                                        local frontPos = targetHRP.Position + (targetHRP.CFrame.LookVector * 2)
                                        lp.Character.HumanoidRootPart.CFrame = CFrame.new(frontPos, targetHRP.Position)
                                    end
                                    task.wait()
                                end
                                hiddenfling = false
                            end)
                        end

                        -- Play custom punch animation if enabled
                        if customPunchEnabled and customPunchAnimId ~= "" then
                            playCustomAnim(customPunchAnimId, true)
                        end

                        break -- Only punch one killer per frame
                    end
                end
            end
        end
    end
    -- === Message-When-Punching: send once per animation start ===
    do
        local myChar = lp.Character
        local hum = myChar and myChar:FindFirstChildOfClass("Humanoid")
        local animator = cachedAnimator
        local currentPlaying = {} -- map animId -> true for tracks playing this frame
        if not animator then
            refreshAnimator()
            animator = cachedAnimator
        end
        if animator then
            local ok, tracks = pcall(function() return animator:GetPlayingAnimationTracks() end)
            if ok and tracks then
                for _, track in ipairs(tracks) do
                    local animId
                    pcall(function() animId = tostring(track.Animation and track.Animation.AnimationId or ""):match("%d+") end)
                    if animId and table.find(punchAnimIds, animId) then
                        currentPlaying[animId] = true
    
                        -- if it wasn't playing last frame, it's a newly-started punch animation
                        if not _punchPrevPlaying[animId] then
                            if messageWhenAutoPunchOn and messageWhenAutoPunch and tostring(messageWhenAutoPunch):match("%S") and (tick() - _lastPunchMessageTime) > MESSAGE_PUNCH_COOLDOWN then
                                pcall(function() sendChatMessage(messageWhenAutoPunch) end)
                                _lastPunchMessageTime = tick()
                            end
                        end
                    end
                end
            end
        end

        -- replace prev state with current state (garbage-collected)
        _punchPrevPlaying = currentPlaying
    end

    do
        local myChar = lp.Character
        local hum = myChar and myChar:FindFirstChildOfClass("Humanoid")
        local animator = cachedAnimator
        local currentPlaying = {} -- map animId -> true for tracks playing this frame
        if not animator then
            refreshAnimator()
            animator = cachedAnimator
        end
        if animator then
            local ok, tracks = pcall(function() return animator:GetPlayingAnimationTracks() end)
            if ok and tracks then
                for _, track in ipairs(tracks) do
                    local animId
                    pcall(function() animId = tostring(track.Animation and track.Animation.AnimationId or ""):match("%d+") end)
                    if animId and table.find(blockAnimIds, animId) then
                        currentPlaying[animId] = true
    
                        -- if it wasn't playing last frame, it's a newly-started punch animation
                        if not _blockPrevPlaying[animId] then
                            if messageWhenAutoBlockOn and messageWhenAutoBlock and tostring(messageWhenAutoBlock):match("%S") and (tick() - _lastBlockMessageTime) > MESSAGE_BLOCK_COOLDOWN then
                                pcall(function() sendChatMessage(messageWhenAutoBlock) end)
                                _lastBlockMessageTime = tick()
                            end
                        end
                    end
                end
            end
        end

        -- replace prev state with current state (garbage-collected)
        _blockPrevPlaying = currentPlaying
    end

    -- === end message-when-punching ===
    if aimPunch then
        if not cachedAnimator then
            refreshAnimator()
        end
        local animator = cachedAnimator
        if animator and myRoot and myChar then
            for _, name in ipairs(killerNames) do
                local killer = workspace:FindFirstChild("Players")
                    and workspace.Players:FindFirstChild("Killers")
                    and workspace.Players.Killers:FindFirstChild(name)
                if killer and killer:FindFirstChild("HumanoidRootPart") then
                    local root = killer.HumanoidRootPart

                    for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
                        -- guard: want only punch tracks (vanilla or custom)
                        local animId = tostring(track.Animation.AnimationId):match("%d+")
                        if table.find(punchAnimIds, animId) then

                            -- Avoid retriggering for the same AnimationTrack within cooldown
                            local last = lastAimTrigger[track]
                            if last and tick() - last < AIM_COOLDOWN then
                                -- already triggered recently for this track -> skip
                            else
                                -- Only trigger when the track is just starting (helps avoid mid/late triggers)
                                local timePos = 0
                                pcall(function() timePos = track.TimePosition or 0 end) -- safe read
                                if timePos <= 0.1 then
                                    -- Lock it so we don't retrigger
                                    lastAimTrigger[track] = tick()

                                    -- Disable autoroate once and aim for AIM_WINDOW seconds
                                    local humanoid = myChar:FindFirstChild("Humanoid")
                                    if humanoid then
                                        humanoid.AutoRotate = false
                                    end

                                    task.spawn(function()
                                        local start = tick()
                                        while tick() - start < AIM_WINDOW do
                                            if myRoot and root and root.Parent then
                                                local predictedPos = root.Position + (root.CFrame.LookVector * predictionValue)
                                                myRoot.CFrame = CFrame.lookAt(myRoot.Position, predictedPos)
                                            end
                                            task.wait()
                                        end
                                        -- restore
                                        if humanoid then
                                            humanoid.AutoRotate = true
                                        end

                                        -- cleanup: allow retrigger later
                                        task.delay(AIM_COOLDOWN - AIM_WINDOW, function()
                                            lastAimTrigger[track] = nil
                                        end)
                                    end)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

CombatTab:Paragraph({
    Title = "Guest1337",
    Desc = "Combat if auto block to been did beat the killer other or mine unknown.",
})

CombatTab:Slider({
    Title = "Delay Guest1337",
    Value = {Min = 0, Max = 15, Defualt = 10},
    Callback = function(red)
       delay = red
    end
})

CombatTab:Toggle({
    Title = "Auto Block",
    Desc = "auto block to guest 1337.",
    Callback = function(state)
       autoBlockOn = state
    end
})

CombatTab:Toggle({
    Title = "Auto Punch",
    Desc = "auto punch to guest 1337.",
    Callback = function(state)
       autoPunchOn = state
    end
})

CombatTab:Button({
    Title = "TP Pizza",
    Callback = function()
        if not state then
            
            for _, v in pairs(connections) do
                v:Disconnect()
            end
            table.clear(connections)
            return
        end
    
        
        local function tp(child)
            if child:IsA("BasePart") and child.Name == "Pizza" then
                local player = game.Players.LocalPlayer
                if player and player.Character then
                    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        child.CFrame = hrp.CFrame
                    end
                end
            end
        end
    end
})

CombatTab:Divider()

CombatTab:Paragraph({
    Title = "ShedletSky",
    Desc = "If you enabled or Eouipped the shedletsky.",
})

CombatTab:Slider({
    Title = "Delay Shedletsky",
    Value = {Min = 0, Max = 15, Default = 5},
    Callback = function(value)
       dfd = value
    end
})

CombatTab:Toggle({
    Title = "Auto Eat Chicken",
    Desc = "eat that shedletsky bro.",
    Callback = function(state)
       eatchicken = state
    end
})

CombatTab:Toggle({
    Title = "Auto Take Medkit to HP Health",
    Desc = "take the medkit.",
    Callback = function(state)
       medkithp = state
    end
})

CombatTab:Toggle({
    Title = "Bring teleport to escape eat Chicken",
    Desc = "eat that shedletsky nah.",
    Callback = function(state)
       eatchickenice = state
    end
})

CombatTab:Divider()

CombatTab:Paragraph({
    Title = "Chance",
    Desc = "OH NOOO I FALIED THE FLIP COIN AGAIN.",
})

CombatTab:Slider({
    Title = "Delay Chance",
    Value = {Min = 0, Max = 7, Default = 5},
    Callback = function(value)
       dfd = value
    end
})

CombatTab:Toggle({
    Title = "Auto Filp Coin",
    Desc = "please i need this, my mom is kinda the homeless.",
    Callback = function(state)
       eatchicken = state
    end
})

CombatTab:Toggle({
    Title = "Auto Medkit to Chance",
    Desc = "just released the medkit.",
    Callback = function(state)
       medkithp = state
    end
})

CombatTab:Divider()

CombatTab:Paragraph({
    Title = "Two Time",
    Desc = "for what to been two time, you mean.",
})

CombatTab:Slider({
    Title = "Delay Two Time",
    Value = {Min = 0, Max = 7, Default = 5},
    Callback = function(value)
       dfd = value
    end
})

CombatTab:Toggle({
    Title = "Auto Hide",
    Desc = "killer didn't look likes it.",
    Callback = function(state)
       eatchicken = state
    end
})

SettingsTab:Section({Title = "Settings"})

SettingsTab:Dropdown({
    Title = "Theme Select",
    Values = themes,
    Value = 1,
    Callback = function(fu)
       full = fu
    end
})

SettingsTab:Button({
    Title = "Change Theme",
    Callback = function()
    WindUI:SetTheme(full)
    end
})

SettingsTab:Button({
    Title = "Bring back Theme",
    Callback = function()
    WindUI:SetTheme("Sky")
    end
})

SettingsTab:Divider()

Window:SetBackgroundTransparency(0.5) 