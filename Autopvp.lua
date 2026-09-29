-- ==============================================================================
-- TÍNH NĂNG: BACKSTAB & TỰ ĐỘNG ĐÁNH
-- ==============================================================================
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local isAttackEnabled = false
local targetPlayer = nil
local excludedPlayers = {}

local function findNearestArmedPlayer()
    local nearest, shortest = nil, math.huge
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and not excludedPlayers[plr] and plr.Character then
            local hum = plr.Character:FindFirstChild("Humanoid")
            local root = plr.Character:FindFirstChild("HumanoidRootPart")
            if hum and hum.Health > 0 and root then
                local hasTool = false
                for _, c in pairs(plr.Character:GetChildren()) do if c:IsA("Tool") then hasTool = true; break end end
                if hasTool then
                    local myChar = player.Character
                    if myChar and myChar:FindFirstChild("HumanoidRootPart") then
                        local dist = (myChar.HumanoidRootPart.Position - root.Position).Magnitude
                        if dist < shortest then shortest = dist; nearest = plr end
                    end
                end
            end
        end
    end
    return nearest
end

local function performAttack()
    local char = player.Character
    if not char then return end
    for _, tool in pairs(char:GetChildren()) do
        if tool:IsA("Tool") then
            tool:Activate()
            for _, r in pairs(tool:GetDescendants()) do if r:IsA("RemoteEvent") then r:FireServer() end end
        end
    end
end
