
-- FULI HUB - Fix Final v5 + Nuevas Funciones (Con Escudo Permanente 🛡️)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local Camera = Workspace.CurrentCamera

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "FuliCodexFixV5"
pcall(function() gui.Parent = game:GetService("CoreGui") end)

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 250, 0, 370)
frame.Position = UDim2.new(0, 10, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local minimizeButton = Instance.new("TextButton", frame)
minimizeButton.Size = UDim2.new(0, 25, 0, 25)
minimizeButton.Position = UDim2.new(1, -30, 0, 5)
minimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
minimizeButton.Text = "-"
minimizeButton.TextColor3 = Color3.new(1,1,1)
minimizeButton.TextSize = 16

local scrollFrame = Instance.new("ScrollingFrame", frame)
scrollFrame.Size = UDim2.new(1, -10, 1, -40)
scrollFrame.Position = UDim2.new(0, 5, 0, 35)
scrollFrame.CanvasSize = UDim2.new(0, 0, 10, 0)
scrollFrame.ScrollBarThickness = 6
scrollFrame.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", scrollFrame)
layout.Padding = UDim.new(0, 4)

local minimized = false
minimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    scrollFrame.Visible = not minimized
    if minimized then
        frame.Size = UDim2.new(0, 250, 0, 40)
        minimizeButton.Text = "+"
    else
        frame.Size = UDim2.new(0, 250, 0, 370)
        minimizeButton.Text = "-"
    end
end)

local function addToggle(name, stateRef, onEnable, onDisable)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 30)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    button.TextColor3 = Color3.new(1,1,1)
    button.Text = "🟩 " .. name
    button.Font = Enum.Font.SourceSans
    button.TextSize = 16
    button.Parent = scrollFrame

    button.MouseButton1Click:Connect(function()
        stateRef.active = not stateRef.active
        if stateRef.active then
            button.Text = "✅️ " .. name
            onEnable()
        else
            button.Text = "🟩 " .. name
            if onDisable then onDisable() end
        end
    end)
end

-- FullBright
local fullbright = {active = false}
addToggle("☀️ FullBright", fullbright, function()
fullbright.loop = RunService.RenderStepped:Connect(function()
Lighting.FogEnd = 1e9
Lighting.Brightness = 3
Lighting.ClockTime = 14
end)
end, function()
if fullbright.loop then fullbright.loop:Disconnect() end
end)

-- WalkSpeed 100
local speed = {active = false}
addToggle("⚡️ WalkSpeed", speed, function()
speed.loop = RunService.RenderStepped:Connect(function()
local char = LocalPlayer.Character
if char then
local hum = char:FindFirstChildWhichIsA("Humanoid")
if hum then hum.WalkSpeed = 30 end
end
end)
end, function()
if speed.loop then speed.loop:Disconnect() end
local char = LocalPlayer.Character
if char then
local hum = char:FindFirstChildWhichIsA("Humanoid")
if hum then hum.WalkSpeed = 16 end
end
end)

-- StunStick Aura
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

local aura = {active = false}
local loop

addToggle("🦴 StunStick Aura", aura, function()
    loop = RunService.RenderStepped:Connect(function()
        local char = LocalPlayer.Character
        if not char then return end

        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        for _, model in pairs(Workspace:GetDescendants()) do
            if model:IsA("Model") and model.Name:lower():find("rake") and model:FindFirstChild("HumanoidRootPart") then
                local rakeHRP = model.HumanoidRootPart
                if (rakeHRP.Position - hrp.Position).Magnitude < 10 then
                    local hum = model:FindFirstChildOfClass("Humanoid")
                    if hum and hum.Health > 0 then
                        hum:TakeDamage(395)  -- Daño fuerte tipo StunStick
                    end
                end
            end
        end
    end)
end, function()
    if loop then loop:Disconnect() end
end)

-- Kill Rake (loop)
local killRake = {active = false}
addToggle("🔪 Kill Rake", killRake, function()
killRake.loop = RunService.RenderStepped:Connect(function()
for _, m in pairs(Workspace:GetDescendants()) do
if m:IsA("Model") and m.Name:lower():find("rake") then
local h = m:FindFirstChildOfClass("Humanoid")
if h and h.Health > 0 then
h:TakeDamage(9999)
end
end
end
end)
end, function()
if killRake.loop then killRake.loop:Disconnect() end
end)

-- Kill NPCs
local killNPC = {active = false}
addToggle("🔪 Kill NPCs (Seren)", killNPC, function()
killNPC.loop = RunService.RenderStepped:Connect(function()
for _, m in pairs(Workspace:GetDescendants()) do
if m:IsA("Model") and not Players:FindFirstChild(m.Name) then
local h = m:FindFirstChildOfClass("Humanoid")
if h and h.Health > 0 then
h:TakeDamage(9999)
end
end
end
end)
end, function()
if killNPC.loop then killNPC.loop:Disconnect() end
end)

-- Infinite Stamina
local stamina = {active = false}
addToggle("💫 Infinite Stamina", stamina, function()
stamina.loop = RunService.RenderStepped:Connect(function()
local char = LocalPlayer.Character
if char then
local stats = char:FindFirstChild("Stats") or char
for _, v in pairs(stats:GetDescendants()) do
if v:IsA("NumberValue") and v.Name:lower():find("stamina") then
v.Value = 999
end
end
end
end)
end, function()
if stamina.loop then stamina.loop:Disconnect() end
end)

-- No Fall Damage
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local noFall = {active = false}
local hooked = false
local originalTakeDamage

addToggle("☁️ No Fall Damage", noFall, function()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid")

    if hum and not hooked then
        originalTakeDamage = hookfunction(hum.TakeDamage, function(_, amount)
            if noFall.active then
                return -- Bloquear daño
            end
            return originalTakeDamage(_, amount)
        end)
        hooked = true
    end
end, function()
    noFall.active = false
end)

-- ESP Players + Rake + HP
local espPlayers = {active = false}
addToggle("👀 ESP Players + Rake", espPlayers, function()
    espPlayers.loop = RunService.RenderStepped:Connect(function()
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = plr.Character.HumanoidRootPart
                local hum = plr.Character:FindFirstChildOfClass("Humanoid")
                local distance = math.floor((hrp.Position - Camera.CFrame.Position).Magnitude)
                local health = hum and math.floor(hum.Health) or 0
                if not hrp:FindFirstChild("FuliESP") then
                    local bill = Instance.new("BillboardGui", hrp)
                    bill.Name = "FuliESP"
                    bill.Size = UDim2.new(0,100,0,40)
                    bill.AlwaysOnTop = true
                    local text = Instance.new("TextLabel", bill)
                    text.Size = UDim2.new(1,0,1,0)
                    text.BackgroundTransparency = 1
                    text.TextColor3 = Color3.new(1,1,1)
                    text.TextScaled = true
                    text.Text = plr.Name .. " [".. distance .."m | ".. health .." HP]"
                else
                    hrp.FuliESP.TextLabel.Text = plr.Name .. " [".. distance .."m | ".. health .." HP]"
                end
            end
        end
        for _, m in pairs(Workspace:GetDescendants()) do
            if m:IsA("Model") and m.Name:lower():find("rake") and m:FindFirstChild("HumanoidRootPart") then
                local hrp = m.HumanoidRootPart
                local hum = m:FindFirstChildOfClass("Humanoid")
                local distance = math.floor((hrp.Position - Camera.CFrame.Position).Magnitude)
                local health = hum and math.floor(hum.Health) or 0
                if not hrp:FindFirstChild("FuliESP") then
                    local bill = Instance.new("BillboardGui", hrp)
                    bill.Name = "FuliESP"
                    bill.Size = UDim2.new(0,100,0,40)
                    bill.AlwaysOnTop = true
                    local text = Instance.new("TextLabel", bill)
                    text.Size = UDim2.new(1,0,1,0)
                    text.BackgroundTransparency = 1
                    text.TextColor3 = Color3.new(1,0,0)
                    text.TextScaled = true
                    text.Text = "Rake [".. distance .."m | ".. health .." HP]"
                else
                    hrp.FuliESP.TextLabel.Text = "Rake [".. distance .."m | ".. health .." HP]"
                end
            end
        end
    end)
end, function()
    if espPlayers.loop then espPlayers.loop:Disconnect() end
end)

-- Basic Noclip
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local noclip = {active = false}
local loop

addToggle("🌀 Noclip", noclip, function()
    loop = RunService.Stepped:Connect(function()
        local char = LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end, function()
    if loop then loop:Disconnect() end
    local char = LocalPlayer.Character
    if char then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end)

-- Hide Underground
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

local hideUnderground = {active = false}
local loop

addToggle("🕳️ Hide Underground", hideUnderground, function()
    loop = RunService.RenderStepped:Connect(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            -- Baja al personaje poco a poco para esconderse
            char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame - Vector3.new(0, 1, 0)
        end
    end)
end, function()
    if loop then loop:Disconnect() end

    -- Cuando apagues, vuelve a subir al jugador para salir
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + Vector3.new(0, 50, 0)
    end
end)

-- Kill Players
local killPlayers = {active = false}
addToggle("🔪 Kill Players", killPlayers, function()
killPlayers.loop = RunService.RenderStepped:Connect(function()
for _, plr in pairs(Players:GetPlayers()) do
if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
local hum = plr.Character:FindFirstChildOfClass("Humanoid")
if hum and hum.Health > 0 then
hum:TakeDamage(9999)
end
end
end
end)
end, function()
if killPlayers.loop then killPlayers.loop:Disconnect() end
end)

-- Escudo Permanente
local permShield = {active = false}
addToggle("🌐 ForceField", permShield, function()
    permShield.loop = RunService.RenderStepped:Connect(function()
        local char = LocalPlayer.Character
        if char and not char:FindFirstChildOfClass("ForceField") then
            Instance.new("ForceField", char) -- Este es el de la burbuja real
        end
    end)
end, function()
    if permShield.loop then permShield.loop:Disconnect() end
    local char = LocalPlayer.Character
    if char then
        local ff = char:FindFirstChildOfClass("ForceField")
        if ff then ff:Destroy() end
    end
end)

-- Godmode Anti-Daño
local godMode = {active = false}
addToggle("💊 Auto Heal", godMode, function()
    godMode.loop = RunService.RenderStepped:Connect(function()
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.Health = hum.MaxHealth  -- Mantener vida siempre al máximo
                hum.PlatformStand = false   -- Evita que te tumben
            end
        end
    end)
end, function()
    if godMode.loop then godMode.loop:Disconnect() end
end)

local spy = {active = false}
local oldNamecall
local hooked = false

-- Fling All
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local fling = {active = false}
local loop

addToggle("💥 Fling All", fling, function()
    loop = RunService.Heartbeat:Connect(function()
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                -- Aplica una fuerza exagerada para lanzarlos lejos
                plr.Character.HumanoidRootPart.Velocity = Vector3.new(0, 200, 0) -- Hacia arriba
            end
        end
    end)
end, function()
    if loop then loop:Disconnect() end
end)
