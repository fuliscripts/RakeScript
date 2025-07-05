-- FULI HUB - Fix Final v5 (StunStick y Infinite Stamina corregidos) + Scroll y Minimizar

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "FuliCodexFixV5"
pcall(function()
    gui.Parent = game:GetService("CoreGui")
end)

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
    button.Text = "⏹️ " .. name
    button.Font = Enum.Font.SourceSans
    button.TextSize = 16
    button.Parent = scrollFrame

    button.MouseButton1Click:Connect(function()
        stateRef.active = not stateRef.active
        if stateRef.active then
            button.Text = "▶️ " .. name
            onEnable()
        else
            button.Text = "⏹️ " .. name
            if onDisable then onDisable() end
        end
    end)
end

-- FullBright
local fullbright = {active = false}
addToggle("FullBright", fullbright,
    function()
        fullbright.loop = RunService.RenderStepped:Connect(function()
            Lighting.FogEnd = 1e9
            Lighting.Brightness = 3
            Lighting.ClockTime = 14
        end)
    end,
    function()
        if fullbright.loop then fullbright.loop:Disconnect() end
    end
)

-- WalkSpeed
local speed = {active = false}
addToggle("WalkSpeed", speed,
    function()
        speed.loop = RunService.RenderStepped:Connect(function()
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildWhichIsA("Humanoid")
                if hum then hum.WalkSpeed = 30 end
            end
        end)
    end,
    function()
        if speed.loop then speed.loop:Disconnect() end
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildWhichIsA("Humanoid")
            if hum then hum.WalkSpeed = 16 end
        end
    end
)

-- StunStick Aura
local aura = {active = false}
addToggle("StunStick Aura", aura,
    function()
        aura.loop = RunService.RenderStepped:Connect(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                for _, m in pairs(Workspace:GetDescendants()) do
                    if m:IsA("Model") and m.Name ~= LocalPlayer.Name and m:FindFirstChildOfClass("Humanoid") then
                        local hrp = m:FindFirstChild("HumanoidRootPart")
                        if hrp and (hrp.Position - char.HumanoidRootPart.Position).Magnitude < 10 then
                            local hum = m:FindFirstChildOfClass("Humanoid")
                            if hum and hum.Health > 0 then
                                hum:TakeDamage(395)
                            end
                        end
                    end
                end
            end
        end)
    end,
    function()
        if aura.loop then aura.loop:Disconnect() end
    end
)

-- Kill Rake
local killRake = {active = false}
addToggle("Kill Rake (loop)", killRake,
    function()
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
    end,
    function()
        if killRake.loop then killRake.loop:Disconnect() end
    end
)

-- Kill NPCs
local killNPC = {active = false}
addToggle("Kill NPCs (loop)", killNPC,
    function()
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
    end,
    function()
        if killNPC.loop then killNPC.loop:Disconnect() end
    end
)

-- Infinite Stamina Fix
local stamina = {active = false}
addToggle("Infinite Stamina", stamina,
    function()
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
    end,
    function()
        if stamina.loop then stamina.loop:Disconnect() end
    end
)
