--[[ 
    CRIXI STRONGEST BATTLEGROUNDS - ENCRYPTED VERSION
    PROTECTED BY CRIXI SECURITY
]]

local _0x1 = "\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\34\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\70\111\111\116\97\103\101\115\117\115\47\87\105\110\100\85\73\47\109\97\105\110\47\100\105\115\116\47\109\97\105\110\46\104\116\109\108\34\41\41\40\41"
local _0x2 = loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\70\111\111\116\97\103\101\115\117\115\47\87\105\110\100\85\73\47\109\97\105\110\47\100\105\115\116\47\109\97\105\110\46\108\117\97"))()

local _P = game:GetService("\80\108\97\121\101\114\115")
local _R = game:GetService("\82\117\110\83\101\114\118\105\99\101")
local _V = game:GetService("\86\105\114\116\117\97\108\73\110\112\117\116\77\97\110\97\103\101\114")
local _L = _P.LocalPlayer
local _AF = false
local _AS = false
local _AK = false
local _T = nil

-- Encrypted Header Data
local _TITLE = "\67\82\73\88\73\32\83\84\82\79\78\71\69\83\84\66\65\84\84\76\69\83\71\82\79\85\78\68"
local _AUTH = "\90\97\101"

local Window = _0x2:CreateWindow({
    Title = _TITLE,
    Author = _AUTH,
    Folder = "tsb_v10_potato",
    Icon = "shaved-head",
    Theme = "Dark",
    Size = UDim2.fromOffset(600, 480),
    ToggleKey = Enum.KeyCode.J, 
})

local Tab1 = Window:Tab({ Title = "Combat & Troll", Icon = "swords" })

Tab1:Toggle({
    Title = "Auto Farm KILL",
    Value = false,
    Callback = function(v) _AF = v if not v then _T = nil end end,
})

Tab1:Toggle({
    Title = "AUTO SKILL",
    Value = false,
    Callback = function(v) _AS = v end,
})

Tab1:Toggle({
    Title = "Anti-Knockback",
    Value = false,
    Callback = function(v) _AK = v end,
})

-- Đoạn Logic chính đã được làm gọn để khó soi
_R.Heartbeat:Connect(function()
    if _AK and _L.Character and _L.Character:FindFirstChild("HumanoidRootPart") then
        _L.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
    end
    if _AF and _L.Character and _L.Character:FindFirstChild("HumanoidRootPart") then
        if not _T or not _T.Parent or _T.Character.Humanoid.Health <= 0 then
            local c, d = nil, math.huge
            for _, v in pairs(_P:GetPlayers()) do
                if v ~= _L and v.Character and v.Character.Humanoid.Health > 0 then
                    local dist = (_L.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude
                    if dist < d then c, d = v, dist end
                end
            end
            _T = c
        end
        if _T and _T.Character:FindFirstChild("Head") then
            _L.Character.HumanoidRootPart.CFrame = CFrame.new(_T.Character.Head.Position + Vector3.new(0, 6, 0)) * CFrame.Angles(0, math.rad(tick()*500%360), 0) * CFrame.new(0, 0, 1.2) * CFrame.Angles(math.rad(-90), 0, 0)
        end
    end
end)

-- Nhắc nhở bản quyền ẩn
print(_TITLE .. " by " .. _AUTH .. " Loaded!")
_0x2:Notify({Title = _TITLE, Content = "Successfully encrypted and loaded."})
