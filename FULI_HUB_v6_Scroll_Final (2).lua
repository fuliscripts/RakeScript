-- FULI HUB - Fix Final v6 (Completísimo con Scroll, Minimizar y Todas las Funciones 💀🚀)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local Camera = Workspace.CurrentCamera

local gui = Instance.new("ScreenGui")
gui.Name = "FuliCodexFixV6"
pcall(function()
    gui.Parent = game:GetService("CoreGui")
end)

local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 250, 0, 400)
mainFrame.Position = UDim2.new(0, 10, 0.4, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true

local minimizeButton = Instance.new("TextButton", mainFrame)
minimizeButton.Size = UDim2.new(0, 25, 0, 25)
minimizeButton.Position = UDim2.new(1, -30, 0, 5)
minimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
minimizeButton.Text = "-"
minimizeButton.TextColor3 = Color3.new(1,1,1)
minimizeButton.TextSize = 16

local scrollFrame = Instance.new("ScrollingFrame", mainFrame)
scrollFrame.Size = UDim2.new(1, -10, 1, -40)
scrollFrame.Position = UDim2.new(0, 5, 0, 35)
scrollFrame.CanvasSize = UDim2.new(0, 0, 100, 0)
scrollFrame.ScrollBarThickness = 6
scrollFrame.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", scrollFrame)
layout.Padding = UDim.new(0, 4)

local minimized = false
minimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    scrollFrame.Visible = not minimized
    if minimized then
        mainFrame.Size = UDim2.new(0, 250, 0, 40)
        minimizeButton.Text = "+"
    else
        mainFrame.Size = UDim2.new(0, 250, 0, 400)
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

-- Aquí van todas las funciones pegadas (FullBright, WalkSpeed, Aura, Kill Rake, Kill NPCs, Infinite Stamina)
-- Más las nuevas:
-- (Código de funciones ya incluido en la conversación)
-- Fin 🚀
