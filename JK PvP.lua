-- JK PVP Script - UI Estilo Moderno
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ProximityPromptService = game:GetService("ProximityPromptService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- Configuración
local config = {
    speedEnabled = false,
    speedValue = 50,
    jumpEnabled = false,
    jumpValue = 100,
    autoGrabEnabled = false,
    autoHitEnabled = false,
    antiBotEnabled = false,
    antiBotDistance = 30,
    antiBotRecoveryTime = 2,
    
    originalSpeed = 16,
    originalJump = 50,
}

local connections = {}
local lastPosition = nil

-- Crear ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "JK_PVP_GUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Frame Principal
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 600, 0, 450)
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -225)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
mainFrame.BorderSizePixel = 3
mainFrame.BorderColor3 = Color3.fromRGB(200, 180, 0)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 15)
mainCorner.Parent = mainFrame

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 60)
header.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
header.BorderSizePixel = 0
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 15)
headerCorner.Parent = header

local headerBottom = Instance.new("Frame")
headerBottom.Size = UDim2.new(1, 0, 0, 15)
headerBottom.Position = UDim2.new(0, 0, 1, -15)
headerBottom.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
headerBottom.BorderSizePixel = 0
headerBottom.Parent = header

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(0, 200, 1, 0)
title.Position = UDim2.new(0, 20, 0, 0)
title.BackgroundTransparency = 1
title.Text = "ZL PvP"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 28
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

-- Discord Label
local discord = Instance.new("TextLabel")
discord.Size = UDim2.new(0, 200, 1, 0)
discord.Position = UDim2.new(1, -220, 0, 0)
discord.BackgroundTransparency = 1
discord.Text = "Discord"
discord.TextColor3 = Color3.fromRGB(200, 200, 200)
discord.TextSize = 24
discord.Font = Enum.Font.GothamBold
discord.TextXAlignment = Enum.TextXAlignment.Right
discord.Parent = header

-- Botón Cerrar
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 45, 0, 45)
closeBtn.Position = UDim2.new(1, -55, 0, 7.5)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 24
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 10)
closeCorner.Parent = closeBtn

-- Contenedor Principal
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, 0, 1, -60)
contentFrame.Position = UDim2.new(0, 0, 0, 60)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- Panel Izquierdo (Tabs)
local leftPanel = Instance.new("Frame")
leftPanel.Size = UDim2.new(0, 160, 1, 0)
leftPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
leftPanel.BorderSizePixel = 0
leftPanel.Parent = contentFrame

-- Panel Derecho (Opciones)
local rightPanel = Instance.new("ScrollingFrame")
rightPanel.Size = UDim2.new(1, -160, 1, -20)
rightPanel.Position = UDim2.new(0, 160, 0, 10)
rightPanel.BackgroundTransparency = 1
rightPanel.BorderSizePixel = 0
rightPanel.ScrollBarThickness = 6
rightPanel.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 110)
rightPanel.Parent = contentFrame

-- Tabs
local tabButtons = {}

local function createTab(name, yPos)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(1, -10, 0, 50)
    tabBtn.Position = UDim2.new(0, 5, 0, yPos)
    tabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    tabBtn.Text = name
    tabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    tabBtn.TextSize = 16
    tabBtn.Font = Enum.Font.Gotham
    tabBtn.Parent = leftPanel
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 8)
    tabCorner.Parent = tabBtn
    
    tabButtons[name] = tabBtn
    
    tabBtn.MouseButton1Click:Connect(function()
        for _, btn in pairs(tabButtons) do
            btn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
            btn.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
        
        tabBtn.BackgroundColor3 = Color3.fromRGB(200, 180, 0)
        tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    
    return tabBtn
end

-- Crear tabs
local combatTab = createTab("Combat", 10)
combatTab.BackgroundColor3 = Color3.fromRGB(200, 180, 0)
combatTab.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Función para crear opción con toggle y settings
local function createOption(name, yPos, hasSettings, callback)
    local optionFrame = Instance.new("Frame")
    optionFrame.Size = UDim2.new(1, -20, 0, 60)
    optionFrame.Position = UDim2.new(0, 10, 0, yPos)
    optionFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    optionFrame.BorderSizePixel = 0
    optionFrame.Parent = rightPanel
    
    local optCorner = Instance.new("UICorner")
    optCorner.CornerRadius = UDim.new(0, 10)
    optCorner.Parent = optionFrame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.5, -20, 1, 0)
    label.Position = UDim2.new(0, 20, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.TextSize = 16
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = optionFrame
    
    local settingsBtn = nil
    if hasSettings then
        settingsBtn = Instance.new("TextButton")
        settingsBtn.Size = UDim2.new(0, 40, 0, 40)
        settingsBtn.Position = UDim2.new(1, -115, 0.5, -20)
        settingsBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
        settingsBtn.Text = "⚙"
        settingsBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        settingsBtn.TextSize = 18
        settingsBtn.Font = Enum.Font.GothamBold
        settingsBtn.Parent = optionFrame
        
        local settingsCorner = Instance.new("UICorner")
        settingsCorner.CornerRadius = UDim.new(0, 10)
        settingsCorner.Parent = settingsBtn
    end
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 60, 0, 40)
    toggleBtn.Position = UDim2.new(1, -65, 0.5, -20)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
    toggleBtn.Text = ""
    toggleBtn.Parent = optionFrame
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(1, 0)
    toggleCorner.Parent = toggleBtn
    
    local toggleCircle = Instance.new("Frame")
    toggleCircle.Size = UDim2.new(0, 32, 0, 32)
    toggleCircle.Position = UDim2.new(0, 4, 0.5, -16)
    toggleCircle.BackgroundColor3 = Color3.fromRGB(100, 100, 110)
    toggleCircle.BorderSizePixel = 0
    toggleCircle.Parent = toggleBtn
    
    local circleCorner = Instance.new("UICorner")
    circleCorner.CornerRadius = UDim.new(1, 0)
    circleCorner.Parent = toggleCircle
    
    local isOn = false
    
    toggleBtn.MouseButton1Click:Connect(function()
        isOn = not isOn
        
        if isOn then
            TweenService:Create(toggleCircle, TweenInfo.new(0.2), {
                Position = UDim2.new(1, -36, 0.5, -16),
                BackgroundColor3 = Color3.fromRGB(100, 200, 100)
            }):Play()
            TweenService:Create(toggleBtn, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(50, 150, 50)
            }):Play()
        else
            TweenService:Create(toggleCircle, TweenInfo.new(0.2), {
                Position = UDim2.new(0, 4, 0.5, -16),
                BackgroundColor3 = Color3.fromRGB(100, 100, 110)
            }):Play()
            TweenService:Create(toggleBtn, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(60, 60, 65)
            }):Play()
        end
        
        if callback then callback(isOn) end
    end)
    
    return optionFrame, toggleBtn, settingsBtn
end

-- Función para crear settings popup
local function createSettingsPopup(title, options)
    local popup = Instance.new("Frame")
    popup.Size = UDim2.new(0, 350, 0, 250)
    popup.Position = UDim2.new(0.5, -175, 0.5, -125)
    popup.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    popup.BorderSizePixel = 2
    popup.BorderColor3 = Color3.fromRGB(200, 180, 0)
    popup.Visible = false
    popup.ZIndex = 10
    popup.Parent = screenGui
    
    local popupCorner = Instance.new("UICorner")
    popupCorner.CornerRadius = UDim.new(0, 12)
    popupCorner.Parent = popup
    
    local popupTitle = Instance.new("TextLabel")
    popupTitle.Size = UDim2.new(1, -60, 0, 40)
    popupTitle.Position = UDim2.new(0, 15, 0, 10)
    popupTitle.BackgroundTransparency = 1
    popupTitle.Text = title
    popupTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    popupTitle.TextSize = 20
    popupTitle.Font = Enum.Font.GothamBold
    popupTitle.TextXAlignment = Enum.TextXAlignment.Left
    popupTitle.Parent = popup
    
    local closePopup = Instance.new("TextButton")
    closePopup.Size = UDim2.new(0, 35, 0, 35)
    closePopup.Position = UDim2.new(1, -45, 0, 10)
    closePopup.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    closePopup.Text = "✕"
    closePopup.TextColor3 = Color3.fromRGB(255, 255, 255)
    closePopup.TextSize = 18
    closePopup.Font = Enum.Font.GothamBold
    closePopup.Parent = popup
    
    local closePopupCorner = Instance.new("UICorner")
    closePopupCorner.CornerRadius = UDim.new(0, 8)
    closePopupCorner.Parent = closePopup
    
    closePopup.MouseButton1Click:Connect(function()
        popup.Visible = false
    end)
    
    return popup
end

-- SPEED OPTION
local speedOpt, speedToggle, speedSettings = createOption("Speed", 10, true, function(enabled)
    config.speedEnabled = enabled
    
    if enabled then
        connections.speed = RunService.Heartbeat:Connect(function()
            if humanoid then
                humanoid.WalkSpeed = config.speedValue
            end
        end)
    else
        if connections.speed then
            connections.speed:Disconnect()
        end
        if humanoid then
            humanoid.WalkSpeed = config.originalSpeed
        end
    end
end)

local speedPopup = createSettingsPopup("Speed Settings", {})
local speedSliderLabel = Instance.new("TextLabel")
speedSliderLabel.Size = UDim2.new(1, -30, 0, 25)
speedSliderLabel.Position = UDim2.new(0, 15, 0, 60)
speedSliderLabel.BackgroundTransparency = 1
speedSliderLabel.Text = "Velocidad: " .. config.speedValue
speedSliderLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
speedSliderLabel.TextSize = 16
speedSliderLabel.Font = Enum.Font.Gotham
speedSliderLabel.TextXAlignment = Enum.TextXAlignment.Left
speedSliderLabel.Parent = speedPopup

local speedSliderBg = Instance.new("Frame")
speedSliderBg.Size = UDim2.new(1, -30, 0, 10)
speedSliderBg.Position = UDim2.new(0, 15, 0, 95)
speedSliderBg.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
speedSliderBg.BorderSizePixel = 0
speedSliderBg.Parent = speedPopup

local speedSliderCorner = Instance.new("UICorner")
speedSliderCorner.CornerRadius = UDim.new(0, 5)
speedSliderCorner.Parent = speedSliderBg

local speedSlider = Instance.new("Frame")
speedSlider.Size = UDim2.new((config.speedValue - 16) / (200 - 16), 0, 1, 0)
speedSlider.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
speedSlider.BorderSizePixel = 0
speedSlider.Parent = speedSliderBg

local speedSliderCorner2 = Instance.new("UICorner")
speedSliderCorner2.CornerRadius = UDim.new(0, 5)
speedSliderCorner2.Parent = speedSlider

local speedDragging = false
speedSliderBg.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        speedDragging = true
    end
end)

speedSliderBg.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        speedDragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if speedDragging and speedPopup.Visible then
        local mousePos = UserInputService:GetMouseLocation()
        local relativePos = mousePos.X - speedSliderBg.AbsolutePosition.X
        local percentage = math.clamp(relativePos / speedSliderBg.AbsoluteSize.X, 0, 1)
        local value = math.floor(16 + (200 - 16) * percentage)
        
        config.speedValue = value
        speedSlider.Size = UDim2.new(percentage, 0, 1, 0)
        speedSliderLabel.Text = "Velocidad: " .. value
    end
end)

speedSettings.MouseButton1Click:Connect(function()
    speedPopup.Visible = not speedPopup.Visible
end)

-- JUMP OPTION
local jumpOpt, jumpToggle, jumpSettings = createOption("Jump", 80, true, function(enabled)
    config.jumpEnabled = enabled
    
    if enabled then
        connections.jump = RunService.Heartbeat:Connect(function()
            if humanoid then
                humanoid.JumpPower = config.jumpValue
            end
        end)
    else
        if connections.jump then
            connections.jump:Disconnect()
        end
        if humanoid then
            humanoid.JumpPower = config.originalJump
        end
    end
end)

local jumpPopup = createSettingsPopup("Jump Settings", {})
local jumpSliderLabel = Instance.new("TextLabel")
jumpSliderLabel.Size = UDim2.new(1, -30, 0, 25)
jumpSliderLabel.Position = UDim2.new(0, 15, 0, 60)
jumpSliderLabel.BackgroundTransparency = 1
jumpSliderLabel.Text = "Salto: " .. config.jumpValue
jumpSliderLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
jumpSliderLabel.TextSize = 16
jumpSliderLabel.Font = Enum.Font.Gotham
jumpSliderLabel.TextXAlignment = Enum.TextXAlignment.Left
jumpSliderLabel.Parent = jumpPopup

local jumpSliderBg = Instance.new("Frame")
jumpSliderBg.Size = UDim2.new(1, -30, 0, 10)
jumpSliderBg.Position = UDim2.new(0, 15, 0, 95)
jumpSliderBg.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
jumpSliderBg.BorderSizePixel = 0
jumpSliderBg.Parent = jumpPopup

local jumpSliderCorner = Instance.new("UICorner")
jumpSliderCorner.CornerRadius = UDim.new(0, 5)
jumpSliderCorner.Parent = jumpSliderBg

local jumpSlider = Instance.new("Frame")
jumpSlider.Size = UDim2.new((config.jumpValue - 50) / (250 - 50), 0, 1, 0)
jumpSlider.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
jumpSlider.BorderSizePixel = 0
jumpSlider.Parent = jumpSliderBg

local jumpSliderCorner2 = Instance.new("UICorner")
jumpSliderCorner2.CornerRadius = UDim.new(0, 5)
jumpSliderCorner2.Parent = jumpSlider

local jumpDragging = false
jumpSliderBg.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        jumpDragging = true
    end
end)

jumpSliderBg.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        jumpDragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if jumpDragging and jumpPopup.Visible then
        local mousePos = UserInputService:GetMouseLocation()
        local relativePos = mousePos.X - jumpSliderBg.AbsolutePosition.X
        local percentage = math.clamp(relativePos / jumpSliderBg.AbsoluteSize.X, 0, 1)
        local value = math.floor(50 + (250 - 50) * percentage)
        
        config.jumpValue = value
        jumpSlider.Size = UDim2.new(percentage, 0, 1, 0)
        jumpSliderLabel.Text = "Salto: " .. value
    end
end)

jumpSettings.MouseButton1Click:Connect(function()
    jumpPopup.Visible = not jumpPopup.Visible
end)

-- AUTO-GRAB OPTION
local autoGrabOpt, autoGrabToggle = createOption("Auto-Grab", 150, false, function(enabled)
    config.autoGrabEnabled = enabled
    
    if enabled then
        connections.autograb = RunService.Heartbeat:Connect(function()
            if rootPart then
                for _, prompt in pairs(workspace:GetDescendants()) do
                    if prompt:IsA("ProximityPrompt") and prompt.Enabled then
                        local distance = (rootPart.Position - prompt.Parent.Position).Magnitude
                        if distance <= prompt.MaxActivationDistance then
                            fireproximityprompt(prompt)
                        end
                    end
                end
            end
        end)
    else
        if connections.autograb then
            connections.autograb:Disconnect()
        end
    end
end)

-- AUTO-HIT OPTION
local autoHitOpt, autoHitToggle = createOption("Auto-Hit (x4 speed)", 220, false, function(enabled)
    config.autoHitEnabled = enabled
    
    if enabled then
        connections.autohit = RunService.Heartbeat:Connect(function()
            mouse1click()
            task.wait(0.0625) -- x4 más rápido
        end)
    else
        if connections.autohit then
            connections.autohit:Disconnect()
        end
    end
end)

-- ANTI-BOT OPTION
local antiBotOpt, antiBotToggle, antiBotSettings = createOption("Anti-Bot", 290, true, function(enabled)
    config.antiBotEnabled = enabled
    
    if enabled then
        lastPosition = rootPart.Position
        
        connections.antibot = RunService.Heartbeat:Connect(function()
            if rootPart then
                local distance = (rootPart.Position - lastPosition).Magnitude
                
                if distance > config.antiBotDistance then
                    rootPart.CFrame = CFrame.new(lastPosition)
                    rootPart.Velocity = Vector3.new(0, 0, 0)
                end
                
                if humanoid:GetState() == Enum.HumanoidStateType.Ragdoll then
                    task.wait(config.antiBotRecoveryTime)
                    if humanoid then
                        humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                    end
                end
                
                lastPosition = rootPart.Position
            end
        end)
    else
        if connections.antibot then
            connections.antibot:Disconnect()
        end
    end
end)

local antiBotPopup = createSettingsPopup("Anti-Bot Settings", {})

local distanceLabel = Instance.new("TextLabel")
distanceLabel.Size = UDim2.new(1, -30, 0, 25)
distanceLabel.Position = UDim2.new(0, 15, 0, 60)
distanceLabel.BackgroundTransparency = 1
distanceLabel.Text = "Distancia máxima: " .. config.antiBotDistance .. " studs"
distanceLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
distanceLabel.TextSize = 16
distanceLabel.Font = Enum.Font.Gotham
distanceLabel.TextXAlignment = Enum.TextXAlignment.Left
distanceLabel.Parent = antiBotPopup

local distSliderBg = Instance.new("Frame")
distSliderBg.Size = UDim2.new(1, -30, 0, 10)
distSliderBg.Position = UDim2.new(0, 15, 0, 95)
distSliderBg.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
distSliderBg.BorderSizePixel = 0
distSliderBg.Parent = antiBotPopup

local distSliderCorner = Instance.new("UICorner")
distSliderCorner.CornerRadius = UDim.new(0, 5)
distSliderCorner.Parent = distSliderBg

local distSlider = Instance.new("Frame")
distSlider.Size = UDim2.new((config.antiBotDistance - 10) / (100 - 10), 0, 1, 0)
distSlider.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
distSlider.BorderSizePixel = 0
distSlider.Parent = distSliderBg

local distSliderCorner2 = Instance.new("UICorner")
distSliderCorner2.CornerRadius = UDim.new(0, 5)
distSliderCorner2.Parent = distSlider

local timeLabel = Instance.new("TextLabel")
timeLabel.Size = UDim2.new(1, -30, 0, 25)
timeLabel.Position = UDim2.new(0, 15, 0, 125)
timeLabel.BackgroundTransparency = 1
timeLabel.Text = "Tiempo en el piso: " .. config.antiBotRecoveryTime .. " segundos"
timeLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
timeLabel.TextSize = 16
timeLabel.Font = Enum.Font.Gotham
timeLabel.TextXAlignment = Enum.TextXAlignment.Left
timeLabel.Parent = antiBotPopup

local timeSliderBg = Instance.new("Frame")
timeSliderBg.Size = UDim2.new(1, -30, 0, 10)
timeSliderBg.Position = UDim2.new(0, 15, 0, 160)
timeSliderBg.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
timeSliderBg.BorderSizePixel = 0
timeSliderBg.Parent = antiBotPopup

local timeSliderCorner = Instance.new("UICorner")
timeSliderCorner.CornerRadius = UDim.new(0, 5)
timeSliderCorner.Parent = timeSliderBg

local timeSlider = Instance.new("Frame")
timeSlider.Size = UDim2.new((config.antiBotRecoveryTime - 0.5) / (10 - 0.5), 0, 1, 0)
timeSlider.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
timeSlider.BorderSizePixel = 0
timeSlider.Parent = timeSliderBg

local timeSliderCorner2 = Instance.new("UICorner")
timeSliderCorner2.CornerRadius = UDim.new(0, 5)
timeSliderCorner2.Parent = timeSlider

-- Slider de distancia (Anti-Bot)
local distDragging = false
distSliderBg.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        distDragging = true
    end
end)

distSliderBg.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        distDragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if distDragging and antiBotPopup.Visible then
        local mousePos = UserInputService:GetMouseLocation()
        local relativePos = mousePos.X - distSliderBg.AbsolutePosition.X
        local percentage = math.clamp(relativePos / distSliderBg.AbsoluteSize.X, 0, 1)
        local value = math.floor(10 + (100 - 10) * percentage)
        
        config.antiBotDistance = value
        distSlider.Size = UDim2.new(percentage, 0, 1, 0)
        distanceLabel.Text = "Distancia máxima: " .. value .. " studs"
    end
end)

-- Slider de tiempo (Anti-Bot)
local timeDragging = false
timeSliderBg.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        timeDragging = true
    end
end)

timeSliderBg.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        timeDragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if timeDragging and antiBotPopup.Visible then
        local mousePos = UserInputService:GetMouseLocation()
        local relativePos = mousePos.X - timeSliderBg.AbsolutePosition.X
        local percentage = math.clamp(relativePos / timeSliderBg.AbsoluteSize.X, 0, 1)
        local value = math.floor((0.5 + (10 - 0.5) * percentage) * 10) / 10
        
        config.antiBotRecoveryTime = value
        timeSlider.Size = UDim2.new(percentage, 0, 1, 0)
        timeLabel.Text = "Tiempo en el piso: " .. value .. " segundos"
    end
end)

antiBotSettings.MouseButton1Click:Connect(function()
    antiBotPopup.Visible = not antiBotPopup.Visible
end)

-- Actualizar CanvasSize del panel derecho
rightPanel.CanvasSize = UDim2.new(0, 0, 0, 370)

-- Botón cerrar GUI
closeBtn.MouseButton1Click:Connect(function()
    -- Desconectar todas las funciones activas
    for _, conn in pairs(connections) do
        if conn then conn:Disconnect() end
    end
    screenGui:Destroy()
end)

-- Actualizar character al respawnear
player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")
    
    config.originalSpeed = humanoid.WalkSpeed
    config.originalJump = humanoid.JumpPower
end)

-- Parent GUI
screenGui.Parent = game:GetService("CoreGui")