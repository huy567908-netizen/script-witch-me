local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VIM = game:GetService("VirtualInputManager")
local UIS = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = game.Workspace.CurrentCamera

-- Biến trạng thái
local AutoFarmEnabled = false
local AutoSkillEnabled = false
local AntiKnockback = false
local ESPEnabled = false
local IsSpectating = false
local WatchingPlayerName = nil
local Target = nil
local FPSDisplayEnabled = false

-- Giao diện FPS
local fpsGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
fpsGui.Name = "FPS_Display"
local fpsLabel = Instance.new("TextLabel", fpsGui)
fpsLabel.Size = UDim2.new(0, 200, 0, 30)
fpsLabel.Position = UDim2.new(0, 10, 0, 10)
fpsLabel.BackgroundTransparency = 1
fpsLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
fpsLabel.Font = Enum.Font.GothamBold
fpsLabel.TextSize = 18
fpsLabel.TextXAlignment = Enum.TextXAlignment.Left
fpsLabel.Visible = false

local Window = WindUI:CreateWindow({
    Title = "CRIXI STRONGESTBATTLESGROUND",
    Author = "Zae",
    Folder = "tsb_v10_potato",
    Icon = "shaved-head",
    Theme = "Dark",
    Size = UDim2.fromOffset(600, 480),
    ToggleKey = Enum.KeyCode.J, 
})

-- ================= TAB 1: COMBAT & TROLL =================
local CombatTab = Window:Tab({ Title = "Combat & Troll", Icon = "swords" })

CombatTab:Toggle({
    Title = "Auto Farm KILL",
    Value = false,
    Callback = function(state) 
        AutoFarmEnabled = state 
        if not state then Target = nil end 
    end,
})

CombatTab:Toggle({
    Title = "AUTO SKILL",
    Value = false,
    Callback = function(state) AutoSkillEnabled = state end,
})

CombatTab:Toggle({
    Title = "Anti-Knockback",
    Value = false,
    Callback = function(state) AntiKnockback = state end,
})

CombatTab:Button({
    Title = "Kích hoạt Dash No Cooldown",
    Callback = function()
        workspace:SetAttribute('EffectAffects', 1)
        workspace:SetAttribute('NoDashCooldown', 0)
        WindUI:Notify({Title = "Combat", Content = "Đã xóa hồi chiêu lướt!"})
    end,
})

-- ================= TAB 2: TELEPORT & MOVEMENT =================
local TeleTab = Window:Tab({ Title = "Teleport", Icon = "map-pin" })

TeleTab:Button({
    Title = "player up (1000m)",
    Callback = function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 1000, 0)
            WindUI:Notify({Title = "Movement", Content = "Đã bay lên 10,000m!"})
        end
    end,
})

TeleTab:Button({
    Title = "jump down",
    Callback = function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local ray = Ray.new(LocalPlayer.Character.HumanoidRootPart.Position, Vector3.new(0, -20000, 0))
            local part, pos = workspace:FindPartOnRay(ray, LocalPlayer.Character)
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
            WindUI:Notify({Title = "Movement", Content = "Đã hạ cánh an toàn!"})
        end
    end,
})

TeleTab:Button({
    Title = "Teleport Tool (Zae)",
    Callback = function()
        local mouse = LocalPlayer:GetMouse()
        local tool = Instance.new("Tool")
        tool.Name = "ZAE TELEPORT"
        tool.RequiresHandle = false
        tool.Parent = LocalPlayer.Backpack

        tool.Activated:Connect(function()
            local pos = mouse.Hit.p
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
            end
        end)
        WindUI:Notify({Title = "Inventory", Content = "Đã nhận Click TP(zae) hoạt động!"})
    end,
})

-- ================= TAB 3: POTATO MODE (ORIGINAL GRAPHIC) =================
local PotatoTab = Window:Tab({ Title = "Potato Mode", Icon = "trash" })
PotatoTab:Button({
    Title = "SUPPER POTATO GRAPHICS",
    Callback = function()
        local potatoGray = Color3.fromRGB(150, 150, 150)
        local lighting = game:GetService("Lighting")
        lighting:ClearAllChildren()
        lighting.FogEnd = 9e9
        lighting.GlobalShadows = false
        lighting.Ambient = potatoGray
        lighting.OutdoorAmbient = potatoGray
        
        local function makePotato(v)
            if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") or v:IsA("Explosion") or v:IsA("Fire") or v:IsA("Smoke") then
                v:Destroy()
            elseif v.Name == "Leaf" or v.Name == "Grass" or v:IsA("Clouds") then
                v:Destroy()
            elseif v:IsA("BasePart") or v:IsA("MeshPart") then
                v.Material = Enum.Material.SmoothPlastic
                v.Color = potatoGray
                v.CastShadow = false
                if v:IsA("MeshPart") then v.TextureID = "" end
            elseif v:IsA("Shirt") or v:IsA("Pants") or v:IsA("Accessory") or v:IsA("ShirtGraphic") then
                v:Destroy()
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v:Destroy()
            end
        end

        for _, v in pairs(game.Workspace:GetDescendants()) do makePotato(v) end
        game.Workspace.DescendantAdded:Connect(makePotato)
        settings().Rendering.QualityLevel = 1
        WindUI:Notify({Title = "Potato Mode", Content = "Đồ họa cực lỏ gốc đã kích hoạt!"})
    end,
})

-- ================= CORE LOGIC =================

-- 1. FPS & ESP Loop
RunService.RenderStepped:Connect(function(deltaTime)
    if FPSDisplayEnabled then
        fpsLabel.Text = "FPS : [" .. math.floor(1 / deltaTime) .. "]"
    end
end)

-- 2. Auto Farm - Ghim chặt & 360 Spin
local currentSpin = 0
RunService.Heartbeat:Connect(function()
    if AntiKnockback and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
    end

    if AutoFarmEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        if not Target or not Target.Parent or not Target.Character or not Target.Character:FindFirstChild("Humanoid") or Target.Character.Humanoid.Health <= 0 then
            local closest, dist = nil, math.huge
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid.Health > 0 then
                    local d = (LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude
                    if d < dist then closest, dist = v, d end
                end
            end
            Target = closest
        end

        if Target and Target.Character:FindFirstChild("Head") then
            currentSpin = (currentSpin + 100) % 36000 -- Tốc độ quay 360 liên tục
            local headPos = Target.Character.Head.Position
            -- Spin 360 quanh trục Y, cách đầu địch 6m, mặt úp xuống (-90 độ)
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(headPos + Vector3.new(0, 6, 0)) 
                * CFrame.Angles(0, math.rad(currentSpin), 0) 
                * CFrame.new(0, 0, 1.2)
                * CFrame.Angles(math.rad(-90), 0, 0) 
        end
    end
end)

-- 3. Ultra Skill Spam 0.01s
task.spawn(function()
    local keys = {Enum.KeyCode.One, Enum.KeyCode.Two, Enum.KeyCode.Three, Enum.KeyCode.Four, Enum.KeyCode.G}
    while true do
        if AutoSkillEnabled and Target then
            for _, k in pairs(keys) do
                VIM:SendKeyEvent(true, k, false, game)
                task.wait(0.01)
                VIM:SendKeyEvent(false, k, false, game)
            end
            VIM:SendMouseButtonEvent(0, 0, 0, true, game, 1)
            task.wait(0.01)
            VIM:SendMouseButtonEvent(0, 0, 0, false, game, 1)
        end
        task.wait(0.01)
    end
end)

WindUI:Notify({Title = "CRIXI STRONGESTBATTLESGROUND", Content = "Use the (J) key to toggle the menu on and off."})
