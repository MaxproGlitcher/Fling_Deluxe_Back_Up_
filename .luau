local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService") 
local UserInputService = game:GetService("UserInputService") 
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local InstanceNew = Instance.new
local Wait = task.wait

local NaProtectUI = NaProtectUI or function(gui) gui.Parent = player:GetService("PlayerGui") end
local NAgui = NAgui or { draggerV2 = function(...) end }
local MouseButtonFix = MouseButtonFix or function(btn, callback) btn.MouseButton1Click:Connect(callback) end
local NAlib = NAlib or { disconnect = function(...) end, connect = function(...) end }
local Lower = Lower or string.lower
local Sub = Sub or string.sub
local Discover = Discover or function(t, v) return table.find(t, v) end
local getPlrHum = getPlrHum or function(char) return char and char:FindFirstChildOfClass("Humanoid") end
local getHead = getHead or function(char) return char and (char:FindFirstChild("Head") or char:FindFirstChild("UpperTorso")) end
local getRoot = function(char) return char and (char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")) end
local flingManager = flingManager or {}

if clickflingUI then clickflingUI:Destroy() end
NAlib.disconnect("clickfling_mouse")
walkflinging = false 
loopTargeting = false 
tumbleMode = false

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ClickFlingModernGUI"
clickflingUI = screenGui 

pcall(function()
    if gethui then
        screenGui.Parent = gethui()
    elseif syn and syn.protect_gui then
        syn.protect_gui(screenGui)
        screenGui.Parent = game:GetService("CoreGui")
    else
        screenGui.Parent = game:GetService("CoreGui")
    end
end)

if not screenGui.Parent then
    screenGui.Parent = player:WaitForChild("PlayerGui")
end

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Name = "Projet_Fling_Deluxe" .. tostring(math.random(100, 999)) 
mainFrame.Size = UDim2.new(0, 240, 0, 440)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25) 

local CloseButton = Instance.new("TextButton", mainFrame)
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 24, 0, 24)
CloseButton.Position = UDim2.new(1, -32, 0, 7)
CloseButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(180, 180, 180)
CloseButton.TextSize = 12
CloseButton.Font = Enum.Font.GothamBold
CloseButton.BorderSizePixel = 0
CloseButton.ZIndex = 10

local CloseCorner = Instance.new("UICorner", CloseButton)
CloseCorner.CornerRadius = UDim.new(0, 5)

CloseButton.MouseEnter:Connect(function()
    CloseButton.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
end)

CloseButton.MouseLeave:Connect(function()
    CloseButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    CloseButton.TextColor3 = Color3.fromRGB(180, 180, 180)
end)

CloseButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = mainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(45, 45, 45) 
UIStroke.Thickness = 1
UIStroke.Parent = mainFrame

local MainTitle = Instance.new("TextLabel", mainFrame)
MainTitle.Size = UDim2.new(1, 0, 0, 35)
MainTitle.Position = UDim2.new(0, 0, 0, 2)
MainTitle.BackgroundTransparency = 1
MainTitle.Text = "FLING DELUXE 1.5"
MainTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
MainTitle.TextSize = 12
MainTitle.Font = Enum.Font.GothamBold

local DiscordCredits = Instance.new("TextLabel", mainFrame)
DiscordCredits.Size = UDim2.new(0, 150, 0, 15)
DiscordCredits.Position = UDim2.new(1, -155, 1, -27)
DiscordCredits.BackgroundTransparency = 1
DiscordCredits.Text = "Discord : maxproglitcher"
DiscordCredits.TextColor3 = Color3.fromRGB(140, 140, 140)
DiscordCredits.TextSize = 10
DiscordCredits.Font = Enum.Font.GothamMedium
DiscordCredits.TextXAlignment = Enum.TextXAlignment.Right

local CreatorCredits = Instance.new("TextLabel", mainFrame)
CreatorCredits.Size = UDim2.new(0, 150, 0, 15)
CreatorCredits.Position = UDim2.new(1, -155, 1, -15)
CreatorCredits.BackgroundTransparency = 1
CreatorCredits.Text = "by MaxproGlitcher"
CreatorCredits.TextColor3 = Color3.fromRGB(140, 140, 140)
CreatorCredits.TextSize = 10
CreatorCredits.Font = Enum.Font.GothamBold
CreatorCredits.TextXAlignment = Enum.TextXAlignment.Right

local dragging, dragInput, dragStart, startPos
local function updateDrag(input)
    local delta = input.Position - dragStart
    local pos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    TweenService:Create(mainFrame, TweenInfo.new(0.15), {Position = pos}):Play()
end

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)

mainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then updateDrag(input) end
end)

local scrollFrame = Instance.new("ScrollingFrame", mainFrame)
scrollFrame.Size = UDim2.new(1, -16, 1, -85) 
scrollFrame.Position = UDim2.new(0, 8, 0, 40)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ClipsDescendants = true
scrollFrame.ScrollBarThickness = 4
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y 

local layout = Instance.new("UIListLayout", scrollFrame)
layout.FillDirection = Enum.FillDirection.Vertical
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 8)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local uiPadding = Instance.new("UIPadding", scrollFrame)
uiPadding.PaddingTop = UDim.new(0, 2)
uiPadding.PaddingBottom = UDim.new(0, 10)

local LeftModuleFrame = Instance.new("Frame", scrollFrame)
LeftModuleFrame.Size = UDim2.new(1, -4, 0, 110) 
LeftModuleFrame.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
Instance.new("UICorner", LeftModuleFrame).CornerRadius = UDim.new(0, 6)

local LeftTitle = InstanceNew("TextLabel", LeftModuleFrame)
LeftTitle.Size = UDim2.new(1, 0, 0, 25)
LeftTitle.BackgroundTransparency = 1
LeftTitle.Text = "CLICK FLING TYPE"
LeftTitle.TextColor3 = Color3.fromRGB(255, 255, 255) 
LeftTitle.TextSize = 10
LeftTitle.Font = Enum.Font.GothamBold

local toggleButtonInstant = InstanceNew("TextButton", LeftModuleFrame)
toggleButtonInstant.Size = UDim2.new(0, 180, 0, 26) 
toggleButtonInstant.Position = UDim2.new(0.5, -90, 0, 32)
toggleButtonInstant.Text = "Instant Click Fling: ON"
toggleButtonInstant.TextSize = 11
toggleButtonInstant.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButtonInstant.Font = Enum.Font.GothamMedium
toggleButtonInstant.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
Instance.new("UICorner", toggleButtonInstant).CornerRadius = UDim.new(0, 4)

local toggleButtonTween = InstanceNew("TextButton", LeftModuleFrame)
toggleButtonTween.Size = UDim2.new(0, 180, 0, 26) 
toggleButtonTween.Position = UDim2.new(0.5, -90, 0, 68)
toggleButtonTween.Text = "Tween Click Fling: OFF"
toggleButtonTween.TextSize = 11
toggleButtonTween.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButtonTween.Font = Enum.Font.GothamMedium
toggleButtonTween.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Instance.new("UICorner", toggleButtonTween).CornerRadius = UDim.new(0, 4)

local RightModuleFrame = Instance.new("Frame", scrollFrame)
RightModuleFrame.Size = UDim2.new(1, -4, 0, 80) 
RightModuleFrame.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
Instance.new("UICorner", RightModuleFrame).CornerRadius = UDim.new(0, 6)

local RightTitle = InstanceNew("TextLabel", RightModuleFrame)
RightTitle.Size = UDim2.new(1, 0, 0, 25)
RightTitle.BackgroundTransparency = 1
RightTitle.Text = "WALK FLING"
RightTitle.TextColor3 = Color3.fromRGB(255, 255, 255) 
RightTitle.TextSize = 10
RightTitle.Font = Enum.Font.GothamBold

local toggleButtonRight = InstanceNew("TextButton", RightModuleFrame)
toggleButtonRight.Size = UDim2.new(0, 180, 0, 28) 
toggleButtonRight.Position = UDim2.new(0.5, -90, 0, 38)
toggleButtonRight.Text = "Status: OFF"
toggleButtonRight.TextSize = 11
toggleButtonRight.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButtonRight.Font = Enum.Font.GothamMedium
toggleButtonRight.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Instance.new("UICorner", toggleButtonRight).CornerRadius = UDim.new(0, 4)

local TargetModuleFrame = Instance.new("Frame", scrollFrame)
TargetModuleFrame.Size = UDim2.new(1, -4, 0, 110) 
TargetModuleFrame.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
Instance.new("UICorner", TargetModuleFrame).CornerRadius = UDim.new(0, 6)

local TargetTitle = InstanceNew("TextLabel", TargetModuleFrame)
TargetTitle.Size = UDim2.new(1, 0, 0, 25)
TargetTitle.BackgroundTransparency = 1
TargetTitle.Text = "LOOP TARGET FLING"
TargetTitle.TextColor3 = Color3.fromRGB(255, 255, 255) 
TargetTitle.TextSize = 10
TargetTitle.Font = Enum.Font.GothamBold

local targetTextBox = Instance.new("TextBox", TargetModuleFrame)
targetTextBox.Size = UDim2.new(0, 180, 0, 26)
targetTextBox.Position = UDim2.new(0.5, -90, 0, 32)
targetTextBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
targetTextBox.Text = ""
targetTextBox.PlaceholderText = "Target Username..."
targetTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
targetTextBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
targetTextBox.TextSize = 11
targetTextBox.Font = Enum.Font.GothamMedium
targetTextBox.ClearTextOnFocus = false
Instance.new("UICorner", targetTextBox).CornerRadius = UDim.new(0, 4)
local textBoxStroke = Instance.new("UIStroke", targetTextBox)
textBoxStroke.Color = Color3.fromRGB(50, 50, 50)
textBoxStroke.Thickness = 1

local toggleButtonLoop = InstanceNew("TextButton", TargetModuleFrame)
toggleButtonLoop.Size = UDim2.new(0, 180, 0, 28) 
toggleButtonLoop.Position = UDim2.new(0.5, -90, 0, 68)
toggleButtonLoop.Text = "Loop Target: OFF"
toggleButtonLoop.TextSize = 11
toggleButtonLoop.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButtonLoop.Font = Enum.Font.GothamMedium
toggleButtonLoop.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Instance.new("UICorner", toggleButtonLoop).CornerRadius = UDim.new(0, 4)


local searchScroll = Instance.new("ScrollingFrame", screenGui)
searchScroll.Size = UDim2.new(0, 180, 0, 120)
searchScroll.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
searchScroll.BorderSizePixel = 0
searchScroll.Visible = false
searchScroll.ZIndex = 10
searchScroll.ScrollBarThickness = 3
searchScroll.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
searchScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
searchScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
Instance.new("UICorner", searchScroll).CornerRadius = UDim.new(0, 4)
local searchStroke = Instance.new("UIStroke", searchScroll)
searchStroke.Color = Color3.fromRGB(50, 50, 50)
searchStroke.Thickness = 1

local searchLayout = Instance.new("UIListLayout", searchScroll)
searchLayout.SortOrder = Enum.SortOrder.LayoutOrder

local function updateSearchPosition()
    searchScroll.Position = UDim2.new(0, targetTextBox.AbsolutePosition.X, 0, targetTextBox.AbsolutePosition.Y + targetTextBox.AbsoluteSize.Y + 4)
end

targetTextBox:GetPropertyChangedSignal("AbsolutePosition"):Connect(updateSearchPosition)

local function updateSearchList()
    for _, item in ipairs(searchScroll:GetChildren()) do
        if item:IsA("TextButton") then item:Destroy() end
    end
    
    local text = targetTextBox.Text:lower()
    local matches = {}
    
    table.insert(matches, "None")
    
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player then
            if text == "" or p.Name:lower():find(text) or p.DisplayName:lower():find(text) then
                table.insert(matches, p.Name)
            end
        end
    end
    
    for i, name in ipairs(matches) do
        local btn = Instance.new("TextButton", searchScroll)
        btn.Size = UDim2.new(1, 0, 0, 24)
        btn.BackgroundTransparency = 1
        btn.Text = "  " .. name
        btn.TextColor3 = name == "None" and Color3.fromRGB(180, 70, 70) or Color3.fromRGB(220, 220, 220)
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.TextSize = 11
        btn.Font = Enum.Font.GothamMedium
        btn.ZIndex = 11
        
        btn.MouseEnter:Connect(function()
            btn.BackgroundTransparency = 0.9
            btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        end)
        btn.MouseLeave:Connect(function()
            btn.BackgroundTransparency = 1
        end)
        
        btn.MouseButton1Click:Connect(function()
            if name == "None" then
                targetTextBox.Text = ""
                if loopTargeting then
                    loopTargeting = false
                    toggleButtonLoop.Text = "Loop Target: OFF"
                    toggleButtonLoop.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                end
            else
                targetTextBox.Text = name
            end
            searchScroll.Visible = false
        end)
    end
end

targetTextBox.Focused:Connect(function()
    updateSearchPosition()
    updateSearchList()
    searchScroll.Visible = true
end)

targetTextBox:GetPropertyChangedSignal("Text"):Connect(function()
    if targetTextBox:IsFocused() then
        updateSearchList()
    end
end)

-- TRACKER EN TEMPS RÉEL (REJOINT / QUITTE)
Players.PlayerAdded:Connect(function(newPlayer)
    if searchScroll.Visible then
        updateSearchList()
    end
end)

Players.PlayerRemoving:Connect(function(leftPlayer)
    -- Si le joueur ciblé quitte le serveur, on nettoie le TextBox et coupe le Fling
    if targetTextBox.Text:lower() == leftPlayer.Name:lower() then
        targetTextBox.Text = ""
        if loopTargeting then
            loopTargeting = false
            toggleButtonLoop.Text = "Loop Target: OFF"
            toggleButtonLoop.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            if LOOPPROTECT then LOOPPROTECT:Destroy() LOOPPROTECT = nil end
        end
    end
    
    if searchScroll.Visible then
        updateSearchList()
    end
end)

UserInputService.InputBegan:Connect(function(input, gpe)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Wait(0.05)
        if not targetTextBox:IsFocused() and searchScroll.Visible then
            searchScroll.Visible = false
        end
    end
end)

local clickFlingMode = "Instant" 

MouseButtonFix(toggleButtonInstant, function()
    if clickFlingMode == "Instant" then
        clickFlingMode = "None"
        toggleButtonInstant.Text = "Instant Click Fling: OFF"
        toggleButtonInstant.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    else
        clickFlingMode = "Instant"
        toggleButtonInstant.Text = "Instant Click Fling: ON"
        toggleButtonInstant.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
        
        toggleButtonTween.Text = "Tween Click Fling: OFF"
        toggleButtonTween.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    end
end)

MouseButtonFix(toggleButtonTween, function()
    if clickFlingMode == "Tween" then
        clickFlingMode = "None"
        toggleButtonTween.Text = "Tween Click Fling: OFF"
        toggleButtonTween.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    else
        clickFlingMode = "Tween"
        toggleButtonTween.Text = "Tween Click Fling: ON"
        toggleButtonTween.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
        
        toggleButtonInstant.Text = "Instant Click Fling: OFF"
        toggleButtonInstant.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    end
end)

local function startWalkFlingLoop()
    local char = player.Character
    local hum = getPlrHum(char)
    if hum then
        local deathConn
        deathConn = hum.Died:Connect(function()
            walkflinging = false
            toggleButtonRight.Text = "Status: OFF"
            toggleButtonRight.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            if deathConn then deathConn:Disconnect() end
        end)
    end

    task.spawn(function()
        local movel = 0.1
        while walkflinging do
            RunService.Heartbeat:Wait()
            local character = player.Character
            local root = getRoot(character)
            
            if character and character.Parent and root and root.Parent then
                local vel = root.Velocity
                root.Velocity = vel * 10000 + Vector3.new(0, 10000, 0)

                RunService.RenderStepped:Wait()
                if character and character.Parent and root and root.Parent then
                    root.Velocity = vel
                end

                RunService.Stepped:Wait()
                if character and character.Parent and root and root.Parent then
                    root.Velocity = vel + Vector3.new(0, movel, 0)
                    movel = movel * -1
                end
            else
                RunService.Heartbeat:Wait()
            end
        end
    end)
end

MouseButtonFix(toggleButtonRight, function()
    walkflinging = not walkflinging
    if walkflinging then
        toggleButtonRight.Text = "Status: ON"
        toggleButtonRight.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
        startWalkFlingLoop()
    else
        toggleButtonRight.Text = "Status: OFF"
        toggleButtonRight.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    end
end)

local function startLoopTargetAction()
    task.spawn(function()
        while loopTargeting do
            local targetName = targetTextBox.Text
            if targetName == "" then 
                Wait(0.1)
                continue 
            end

            local AllBool = false
            local GetPlayer = function(Name)
                Name = Name:lower()
                if Name == "all" or Name == "others" then
                    AllBool = true
                    return
                elseif Name == "random" then
                    local GetPlayers = Players:GetPlayers()
                    if Discover(GetPlayers, player) then table.remove(GetPlayers, Discover(GetPlayers, player)) end
                    return GetPlayers[math.random(#GetPlayers)]
                else
                    for _, x in next, Players:GetPlayers() do
                        if x ~= player then
                            if x.Name:lower():match("^"..Name) then
                                return x
                            elseif x.DisplayName:lower():match("^"..Name) then
                                return x
                            end
                        end
                    end
                end
            end

            local FlingDeluxePro = function(TargetPlayer)
                if LOOPPROTECT then LOOPPROTECT:Destroy() LOOPPROTECT = nil end
                local Character = player.Character
                local Humanoid = getPlrHum(Character)
                local HRP = Humanoid and Humanoid.RootPart
                local camera = workspace.CurrentCamera
                
                LOOPPROTECT = InstanceNew("Part")
                LOOPPROTECT.Size = Vector3.new(1, 1, 1)
                LOOPPROTECT.Transparency = 1
                LOOPPROTECT.CanCollide = false
                LOOPPROTECT.Anchored = false
                LOOPPROTECT.Parent = camera
                
                local weld = InstanceNew("WeldConstraint")
                weld.Part0 = HRP
                weld.Part1 = LOOPPROTECT
                weld.Parent = LOOPPROTECT
                
                local bodyGyro = InstanceNew("BodyGyro")
                bodyGyro.MaxTorque = Vector3.new(400000, 400000, 400000)
                bodyGyro.D = 1000
                bodyGyro.P = 2000
                bodyGyro.Parent = LOOPPROTECT
                
                local RootPart = HRP
                local TCharacter = TargetPlayer.Character
                local THumanoid, TRootPart, THead, Accessory, Handle
                
                if not TCharacter then if LOOPPROTECT then LOOPPROTECT:Destroy() LOOPPROTECT = nil end return end
                if getPlrHum(TCharacter) then THumanoid = getPlrHum(TCharacter) end
                if THumanoid and THumanoid.RootPart then TRootPart = THumanoid.RootPart end
                if getHead(TCharacter) then THead = getHead(TCharacter) end
                if TCharacter:FindFirstChildOfClass("Accessory") then Accessory = TCharacter:FindFirstChildOfClass("Accessory") end
                if Accessory and Accessory:FindFirstChild("Handle") then Handle = Accessory.Handle end
                
                if Character and Humanoid and HRP then
                    if not flingManager.lFlingOldPos or RootPart.Velocity.Magnitude < 50 then
                        flingManager.lFlingOldPos = RootPart.CFrame
                    end
                    if THumanoid and THumanoid.Sit and not AllBool then return end
                    
                    if THead then
                        workspace.CurrentCamera.CameraSubject = THead
                    elseif not THead and Handle then
                        workspace.CurrentCamera.CameraSubject = Handle
                    elseif THumanoid and TRootPart then
                        workspace.CurrentCamera.CameraSubject = THumanoid
                    end
                    
                    if not TCharacter or not TCharacter:FindFirstChildWhichIsA("BasePart") then return end
                    
                    local FPos = function(BasePart, Pos, Ang)
                        RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
                        Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
                        RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
                        RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
                    end
                    
                    local SFBasePart = function(BasePart)
                        local TimeToWait = 2
                        local Time = tick()
                        local Angle = 0
                        repeat
                            if RootPart and THumanoid and TCharacter and TCharacter.Parent then
                                if BasePart.Velocity.Magnitude < 50 then
                                    Angle = Angle + 100
                                    FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0)) Wait()
                                    FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0)) Wait()
                                    FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0)) Wait()
                                    FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0)) Wait()
                                    FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle), 0, 0)) Wait()
                                    FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle), 0, 0)) Wait()
                                else
                                    FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0)) Wait()
                                    FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0)) Wait()
                                    FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0)) Wait()
                                    FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0)) Wait()
                                    FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0)) Wait()
                                    FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0)) Wait()
                                    FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0)) Wait()
                                    FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0)) Wait()
                                    FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(-90), 0, 0)) Wait()
                                    FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0)) Wait()
                                end
                            else
                                break
                            end
                        until not BasePart or not BasePart.Parent or BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or TargetPlayer.Character ~= TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait
                        if LOOPPROTECT then LOOPPROTECT:Destroy() LOOPPROTECT = nil end
                    end
                    
                    local OrgDestroyHeight = workspace.FallenPartsDestroyHeight
                    workspace.FallenPartsDestroyHeight = 0/0
                    
                    local BV = InstanceNew("BodyVelocity")
                    BV.Parent = RootPart
                    BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
                    BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)
                    
                    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
                    
                    if TRootPart and THead then
                        if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then SFBasePart(THead) else SFBasePart(TRootPart) end
                    elseif TRootPart and not THead then
                        SFBasePart(TRootPart)
                    elseif not TRootPart and THead then
                        SFBasePart(THead)
                    elseif not TRootPart and not THead and Accessory and Handle then
                        SFBasePart(Handle)
                    end
                    
                    if BV then BV:Destroy() end
                    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
                    workspace.CurrentCamera.CameraSubject = Humanoid
                    
                    repeat
                        if RootPart and flingManager.lFlingOldPos then
                            RootPart.CFrame = flingManager.lFlingOldPos * CFrame.new(0, 0.5, 0)
                            Character:SetPrimaryPartCFrame(flingManager.lFlingOldPos * CFrame.new(0, 0.5, 0))
                            Humanoid:ChangeState("GettingUp")
                            for _, x in next, Character:GetChildren() do
                                if x:IsA("BasePart") then
                                    x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
                                end
                            end
                        end
                        Wait()
                    until not RootPart or (RootPart.Position - flingManager.lFlingOldPos.p).Magnitude < 25
                    workspace.FallenPartsDestroyHeight = OrgDestroyHeight
                    if LOOPPROTECT then LOOPPROTECT:Destroy() LOOPPROTECT = nil end
                end
            end

            if AllBool then
                for _, x in next, Players:GetPlayers() do
                    if not loopTargeting then break end
                    FlingDeluxePro(x)
                end
            else
                local TP = GetPlayer(targetName)
                if TP and TP ~= player and TP.UserId ~= 1414978355 then
                    FlingDeluxePro(TP)
                end
            end
            Wait(0.5)
        end
    end)
end

MouseButtonFix(toggleButtonLoop, function()
    loopTargeting = not loopTargeting
    if loopTargeting then
        toggleButtonLoop.Text = "Loop Target: ON"
        toggleButtonLoop.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
        startLoopTargetAction()
    else
        toggleButtonLoop.Text = "Loop Target: OFF"
        toggleButtonLoop.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        if LOOPPROTECT then LOOPPROTECT:Destroy() LOOPPROTECT = nil end
    end
end)


local Mouse = player:GetMouse()
local conn = Mouse.Button1Down:Connect(function()
    if clickFlingMode == "None" then return end
    
    local Target = Mouse.Target
    if Target and Target.Parent and Target.Parent:IsA("Model") and Players:GetPlayerFromCharacter(Target.Parent) then
        local targetUser = Players:GetPlayerFromCharacter(Target.Parent)
        if targetUser == player then return end
        
        local PlayerName = targetUser.Name
        local AllBool = false

        local GetPlayer = function(Name)
            Name = Lower(Name)
            if Name == "all" or Name == "others" then
                AllBool = true
                return
            elseif Name == "random" then
                local GetPlayers = Players:GetPlayers()
                if Discover(GetPlayers, player) then table.remove(GetPlayers, Discover(GetPlayers, player)) end
                return GetPlayers[math.random(#GetPlayers)]
            end
            for _, x in next, Players:GetPlayers() do
                if x ~= player then
                    if Sub(Lower(x.Name), 1, #Name) == Name or Sub(Lower(x.DisplayName), 1, #Name) == Name then
                        return x
                    end
                end
            end
        end

        local OrgDestroyHeight = workspace.FallenPartsDestroyHeight

        local Fling_Deluxe = function(TargetPlayer)
            local Character = player.Character
            local Humanoid = getPlrHum(Character)
            local RootPart = Humanoid and Humanoid.RootPart
            local TCharacter = TargetPlayer.Character
            local THumanoid = getPlrHum(TCharacter)
            local TRootPart = THumanoid and THumanoid.RootPart
            local THead = getHead(TCharacter)
            local Accessory = TCharacter and TCharacter:FindFirstChildOfClass("Accessory")
            local Handle = Accessory and Accessory:FindFirstChild("Handle")

            if Character and Humanoid and RootPart then
                if not flingManager.cFlingOldPos or RootPart.Velocity.Magnitude < 50 then
                    flingManager.cFlingOldPos = RootPart.CFrame
                end
                if THead then
                    workspace.CurrentCamera.CameraSubject = THead
                elseif Handle then
                    workspace.CurrentCamera.CameraSubject = Handle
                elseif THumanoid and TRootPart then
                    workspace.CurrentCamera.CameraSubject = THumanoid
                end
                
                if not TCharacter or not TCharacter:FindFirstChildWhichIsA("BasePart") then return end

                local function FPos(BasePart, Pos, Ang)
                    RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
                    Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
                    RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
                    RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
                end

                local function SFBasePart(BasePart)
                    local TimeToWait = 2
                    local Time = tick()
                    local Angle = 0
                    repeat
                        if RootPart and THumanoid and TCharacter and TCharacter.Parent then
                            if BasePart.Velocity.Magnitude < 50 then
                                Angle = Angle + 100
                                FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0)) Wait()
                                FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0)) Wait()
                                FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0)) Wait()
                                FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0)) Wait()
                                FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle), 0, 0)) Wait()
                                FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle), 0, 0)) Wait()
                            else
                                FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0)) Wait()
                                FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0)) Wait()
                                FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0)) Wait()
                                FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0)) Wait()
                                FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0)) Wait()
                                FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0)) Wait()
                                FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0)) Wait()
                                FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0)) Wait()
                                FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(-90), 0, 0)) Wait()
                                FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0)) Wait()
                            end
                        else
                            break
                        end
                    until not BasePart or not BasePart.Parent or BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or TargetPlayer.Character ~= TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait
                end

                local targetPart = TRootPart or THead or Handle
                if targetPart then
                    if clickFlingMode == "Tween" then
                        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
                        local tween = TweenService:Create(RootPart, tweenInfo, {CFrame = targetPart.CFrame * CFrame.new(0, 1.5, 0)})
                        tween:Play()
                        tween.Completed:Wait() 
                    end
                end

                workspace.FallenPartsDestroyHeight = 0 / 0
                
                local BV = InstanceNew("BodyVelocity")
                BV.Parent = RootPart
                BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
                BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)
                
                Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
                
                if TRootPart and THead then
                    if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then SFBasePart(THead) else SFBasePart(TRootPart) end
                elseif TRootPart and not THead then
                    SFBasePart(TRootPart)
                elseif not TRootPart and THead then
                    SFBasePart(THead)
                elseif not TRootPart and not THead and Accessory and Handle then
                    SFBasePart(Handle)
                end
                
                if BV then BV:Destroy() end
                Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
                workspace.CurrentCamera.CameraSubject = Humanoid
                
                repeat
                    if RootPart and flingManager.cFlingOldPos then
                        RootPart.CFrame = flingManager.cFlingOldPos * CFrame.new(0, 0.5, 0)
                        Character:SetPrimaryPartCFrame(flingManager.cFlingOldPos * CFrame.new(0, 0.5, 0))
                        Humanoid:ChangeState("GettingUp")
                        for _, x in next, Character:GetChildren() do
                            if x:IsA("BasePart") then
                                x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
                            end
                        end
                    end
                    Wait()
                until not RootPart or (RootPart.Position - flingManager.cFlingOldPos.p).Magnitude < 25
                workspace.FallenPartsDestroyHeight = OrgDestroyHeight
            end
        end

        if AllBool then
            for _, x in next, Players:GetPlayers() do
                Fling_Deluxe(x)
            end
        else
            local TP = GetPlayer(PlayerName)
            if TP and TP ~= player and TP.UserId ~= 1414978355 then
                Fling_Deluxe(TP)
            end
        end
    end
end)

