--[[By MaxproGlitcher Discord:maxproglitcher

-- This is the real Back Up One from Fling_Deluxe

-- Site Web official: https://github.com/MaxproGlitcher/Fling_Deluxe_Back_Up_

-- Fling_Deluxe is original Script software created and developed by MaxproGlitcher.

-- Copying, modifying, redistributing, reselling, republishing, or any other use of all or part of this project without prior written  

-- permission is strictly prohibited.

-- This software is protected by applicable copyright laws. Any unauthorized use may result in the removal of the affected content as  

-- well as appropriate legal action.

-- Fling_Deluxe® – Developed by MaxproGlitcher.

-- © 2026 MaxproGlitcher. All rights reserved.

-- Official version Back Up only.

--------------------------------------------------------------------------------------------------------------------
   _____                                       ________.__  .__  __         .__                  
  /     \ _____  ___  ________________  ____  /  _____/|  | |__|/  |_  ____ |  |__   ___________ 
 /  \ /  \\__  \ \  \/  /\____ \_  __ \/  _ \/   \  ___|  | |  \   __\/ ___\|  |  \_/ __ \_  __ \
/    Y    \/ __ \_>    < |  |_> >  | \(  <_> )    \_\  \  |_|  ||  | \  \___|   Y  \  ___/|  | \/
\____|__  (____  /__/\_ \|   __/|__|   \____/ \______  /____/__||__|  \___  >___|  /\___  >__|   
        \/     \/      \/|__|                        \/                   \/     \/     \/    
  

--------------------------------------------------------------------------------------------------------------------

    _________                   ____       __              
   / ____/ (_)___  ____ _      / __ \___  / /_  ___  _____ 
  / /_  / / / __ \/ __ `/_____/ / / / _ \/ / / / / |/_/ _ \
 / __/ / / / / / / /_/ /_____/ /_/ /  __/ / /_/ />  </  __/
/_/   /_/_/_/ /_/\__, /     /_____/\___/_/\__,_/_/|_|\___/ 
                /____/    
--------------------------------------------------------------------------------------------------------------------
]]

if not game:IsLoaded() then
	game.Loaded:Wait()
end


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
mainFrame.Size = UDim2.new(0, 350, 0, 470)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20) 
mainFrame.BorderSizePixel = 0

local mainCorner = Instance.new("UICorner", mainFrame)
mainCorner.CornerRadius = UDim.new(0, 10)

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(50, 50, 50) 
UIStroke.Thickness = 1
UIStroke.Parent = mainFrame

local CloseButton = Instance.new("TextButton", mainFrame)
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 28, 0, 28)
CloseButton.Position = UDim2.new(1, -34, 0, 8)
CloseButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(180, 180, 180)
CloseButton.TextSize = 12
CloseButton.Font = Enum.Font.GothamBold
CloseButton.BorderSizePixel = 0
CloseButton.ZIndex = 10

local closeCorner = Instance.new("UICorner", CloseButton)
closeCorner.CornerRadius = UDim.new(0, 6)

CloseButton.MouseEnter:Connect(function()
    pcall(function()
        CloseButton.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
        CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
end)

CloseButton.MouseLeave:Connect(function()
    pcall(function()
        CloseButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        CloseButton.TextColor3 = Color3.fromRGB(180, 180, 180)
    end)
end)

CloseButton.MouseButton1Click:Connect(function()
    pcall(function()
        if screenGui and screenGui.Parent then
            screenGui:Destroy()
        end
    end)
end)

local MainTitle = Instance.new("TextLabel", mainFrame)
MainTitle.Size = UDim2.new(1, -50, 0, 35)
MainTitle.Position = UDim2.new(0, 12, 0, 4)
MainTitle.BackgroundTransparency = 1
MainTitle.Text = "FLING DELUXE 2.1"
MainTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
MainTitle.TextSize = 13
MainTitle.Font = Enum.Font.GothamBold
MainTitle.TextXAlignment = Enum.TextXAlignment.Left

local DiscordCredits = Instance.new("TextLabel", mainFrame)
DiscordCredits.Size = UDim2.new(0, 200, 0, 15)
DiscordCredits.Position = UDim2.new(1, -210, 1, -27)
DiscordCredits.BackgroundTransparency = 1
DiscordCredits.Text = "Discord : maxproglitcher"
DiscordCredits.TextColor3 = Color3.fromRGB(140, 140, 140)
DiscordCredits.TextSize = 10
DiscordCredits.Font = Enum.Font.GothamMedium
DiscordCredits.TextXAlignment = Enum.TextXAlignment.Right

local CreatorCredits = Instance.new("TextLabel", mainFrame)
CreatorCredits.Size = UDim2.new(0, 200, 0, 15)
CreatorCredits.Position = UDim2.new(1, -210, 1, -15)
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
scrollFrame.Position = UDim2.new(0, 8, 0, 42)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ClipsDescendants = true
scrollFrame.ScrollBarThickness = 4
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y

local layout = Instance.new("UIListLayout", scrollFrame)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 10)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

scrollFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseWheel or input.UserInputType == Enum.UserInputType.Touch then
        isScrolling = true
        mainFrame.Active = false
    end
end)

scrollFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseWheel or input.UserInputType == Enum.UserInputType.Touch then
        task.delay(0.1, function()
            isScrolling = false
            mainFrame.Active = true
        end)
    end
end)

local function addCorner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 6)
    c.Parent = parent
    return c
end


local LeftModuleFrame = Instance.new("Frame", scrollFrame)
LeftModuleFrame.Size = UDim2.new(1, -4, 0, 110) 
LeftModuleFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
LeftModuleFrame.BorderSizePixel = 0
addCorner(LeftModuleFrame, 8)

local LeftTitle = InstanceNew("TextLabel", LeftModuleFrame)
LeftTitle.Size = UDim2.new(1, -20, 0, 25)
LeftTitle.Position = UDim2.new(0, 10, 0, 2)
LeftTitle.BackgroundTransparency = 1
LeftTitle.Text = "CLICK FLING MODES & POWER"
LeftTitle.TextColor3 = Color3.fromRGB(255, 255, 255) 
LeftTitle.TextSize = 11
LeftTitle.Font = Enum.Font.GothamBold
LeftTitle.TextXAlignment = Enum.TextXAlignment.Left


local toggleButtonInstant = InstanceNew("TextButton", LeftModuleFrame)
toggleButtonInstant.Size = UDim2.new(1, -90, 0, 28) 
toggleButtonInstant.Position = UDim2.new(0, 10, 0, 30)
toggleButtonInstant.Text = "Instant Click Fling: ON"
toggleButtonInstant.TextSize = 10
toggleButtonInstant.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButtonInstant.Font = Enum.Font.GothamMedium
toggleButtonInstant.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
toggleButtonInstant.BorderSizePixel = 0
addCorner(toggleButtonInstant, 6)

local instantValueBox = Instance.new("TextBox", LeftModuleFrame)
instantValueBox.Size = UDim2.new(0, 65, 0, 28)
instantValueBox.Position = UDim2.new(1, -75, 0, 30)
instantValueBox.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
instantValueBox.Text = "90000000"
instantValueBox.PlaceholderText = "Force"
instantValueBox.TextColor3 = Color3.fromRGB(255, 255, 255)
instantValueBox.TextSize = 10
instantValueBox.Font = Enum.Font.GothamMedium
instantValueBox.BorderSizePixel = 0
addCorner(instantValueBox, 6)


local toggleButtonTween = InstanceNew("TextButton", LeftModuleFrame)
toggleButtonTween.Size = UDim2.new(1, -90, 0, 28) 
toggleButtonTween.Position = UDim2.new(0, 10, 0, 66)
toggleButtonTween.Text = "Tween Click Fling: OFF"
toggleButtonTween.TextSize = 10
toggleButtonTween.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButtonTween.Font = Enum.Font.GothamMedium
toggleButtonTween.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleButtonTween.BorderSizePixel = 0
addCorner(toggleButtonTween, 6)

local tweenValueBox = Instance.new("TextBox", LeftModuleFrame)
tweenValueBox.Size = UDim2.new(0, 65, 0, 28)
tweenValueBox.Position = UDim2.new(1, -75, 0, 66)
tweenValueBox.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
tweenValueBox.Text = "90000000"
tweenValueBox.PlaceholderText = "Force"
tweenValueBox.TextColor3 = Color3.fromRGB(255, 255, 255)
tweenValueBox.TextSize = 10
tweenValueBox.Font = Enum.Font.GothamMedium
tweenValueBox.BorderSizePixel = 0
addCorner(tweenValueBox, 6)


local RightModuleFrame = Instance.new("Frame", scrollFrame)
RightModuleFrame.Size = UDim2.new(1, -4, 0, 75) 
RightModuleFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
RightModuleFrame.BorderSizePixel = 0
addCorner(RightModuleFrame, 8)

local RightTitle = InstanceNew("TextLabel", RightModuleFrame)
RightTitle.Size = UDim2.new(1, -20, 0, 25)
RightTitle.Position = UDim2.new(0, 10, 0, 2)
RightTitle.BackgroundTransparency = 1
RightTitle.Text = "WALK FLING POWER"
RightTitle.TextColor3 = Color3.fromRGB(255, 255, 255) 
RightTitle.TextSize = 11
RightTitle.Font = Enum.Font.GothamBold
RightTitle.TextXAlignment = Enum.TextXAlignment.Left

local toggleButtonRight = InstanceNew("TextButton", RightModuleFrame)
toggleButtonRight.Size = UDim2.new(1, -90, 0, 28) 
toggleButtonRight.Position = UDim2.new(0, 10, 0, 32)
toggleButtonRight.Text = "Walk Fling: OFF"
toggleButtonRight.TextSize = 10
toggleButtonRight.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButtonRight.Font = Enum.Font.GothamMedium
toggleButtonRight.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleButtonRight.BorderSizePixel = 0
addCorner(toggleButtonRight, 6)

local walkValueBox = Instance.new("TextBox", RightModuleFrame)
walkValueBox.Size = UDim2.new(0, 65, 0, 28)
walkValueBox.Position = UDim2.new(1, -75, 0, 32)
walkValueBox.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
walkValueBox.Text = "90000000"
walkValueBox.PlaceholderText = "Mult"
walkValueBox.TextColor3 = Color3.fromRGB(255, 255, 255)
walkValueBox.TextSize = 10
walkValueBox.Font = Enum.Font.GothamMedium
walkValueBox.BorderSizePixel = 0
addCorner(walkValueBox, 6)


local TargetModuleFrame = Instance.new("Frame", scrollFrame)
TargetModuleFrame.Size = UDim2.new(1, -4, 0, 145) 
TargetModuleFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
TargetModuleFrame.BorderSizePixel = 0
addCorner(TargetModuleFrame, 8)

local TargetTitle = InstanceNew("TextLabel", TargetModuleFrame)
TargetTitle.Size = UDim2.new(1, -20, 0, 25)
TargetTitle.Position = UDim2.new(0, 10, 0, 2)
TargetTitle.BackgroundTransparency = 1
TargetTitle.Text = "LOOP TARGET FLING"
TargetTitle.TextColor3 = Color3.fromRGB(255, 255, 255) 
TargetTitle.TextSize = 11
TargetTitle.Font = Enum.Font.GothamBold
TargetTitle.TextXAlignment = Enum.TextXAlignment.Left

local targetTextBox = Instance.new("TextBox", TargetModuleFrame)
targetTextBox.Size = UDim2.new(1, -20, 0, 28)
targetTextBox.Position = UDim2.new(0, 10, 0, 30)
targetTextBox.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
targetTextBox.Text = ""
targetTextBox.PlaceholderText = "Target Username..."
targetTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
targetTextBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
targetTextBox.TextSize = 10
targetTextBox.Font = Enum.Font.GothamMedium
targetTextBox.ClearTextOnFocus = false
targetTextBox.BorderSizePixel = 0
addCorner(targetTextBox, 6)

local toggleButtonLoop = InstanceNew("TextButton", TargetModuleFrame)
toggleButtonLoop.Size = UDim2.new(1, -90, 0, 28) 
toggleButtonLoop.Position = UDim2.new(0, 10, 0, 66)
toggleButtonLoop.Text = "Loop Target: OFF"
toggleButtonLoop.TextSize = 10
toggleButtonLoop.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButtonLoop.Font = Enum.Font.GothamMedium
toggleButtonLoop.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleButtonLoop.BorderSizePixel = 0
addCorner(toggleButtonLoop, 6)

local loopValueBox = Instance.new("TextBox", TargetModuleFrame)
loopValueBox.Size = UDim2.new(0, 65, 0, 28)
loopValueBox.Position = UDim2.new(1, -75, 0, 66)
loopValueBox.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
loopValueBox.Text = "90000000"
loopValueBox.PlaceholderText = "Force"
loopValueBox.TextColor3 = Color3.fromRGB(255, 255, 255)
loopValueBox.TextSize = 10
loopValueBox.Font = Enum.Font.GothamMedium
loopValueBox.BorderSizePixel = 0
addCorner(loopValueBox, 6)

local toggleButtonLoopAll = InstanceNew("TextButton", TargetModuleFrame)
toggleButtonLoopAll.Size = UDim2.new(1, -90, 0, 28) 
toggleButtonLoopAll.Position = UDim2.new(0, 10, 0, 102)
toggleButtonLoopAll.Text = "Loop Target All: OFF"
toggleButtonLoopAll.TextSize = 10
toggleButtonLoopAll.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButtonLoopAll.Font = Enum.Font.GothamMedium
toggleButtonLoopAll.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleButtonLoopAll.BorderSizePixel = 0
addCorner(toggleButtonLoopAll, 6)

local loopAllValueBox = Instance.new("TextBox", TargetModuleFrame)
loopAllValueBox.Size = UDim2.new(0, 65, 0, 28)
loopAllValueBox.Position = UDim2.new(1, -75, 0, 102)
loopAllValueBox.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
loopAllValueBox.Text = "90000000"
loopAllValueBox.PlaceholderText = "Force"
loopAllValueBox.TextColor3 = Color3.fromRGB(255, 255, 255)
loopAllValueBox.TextSize = 10
loopAllValueBox.Font = Enum.Font.GothamMedium
loopAllValueBox.BorderSizePixel = 0
addCorner(loopAllValueBox, 6)


local searchScroll = Instance.new("ScrollingFrame", screenGui)
searchScroll.Size = UDim2.new(0, 310, 0, 120)
searchScroll.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
searchScroll.BorderSizePixel = 0
searchScroll.Visible = false
searchScroll.ZIndex = 10
searchScroll.ScrollBarThickness = 3
searchScroll.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
searchScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
searchScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
addCorner(searchScroll, 6)

local success, errorMessage = pcall(function()
    local searchLayout = Instance.new("UIListLayout", searchScroll)
    searchLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local function updateSearchPosition()
        pcall(function()
            searchScroll.Position = UDim2.new(0, targetTextBox.AbsolutePosition.X, 0, targetTextBox.AbsolutePosition.Y + targetTextBox.AbsoluteSize.Y + 4)
        end)
    end

    targetTextBox:GetPropertyChangedSignal("AbsolutePosition"):Connect(updateSearchPosition)

    local function updateSearchList()
        pcall(function()
            for _, item in ipairs(searchScroll:GetChildren()) do
                if item:IsA("TextButton") then 
                    pcall(function() item:Destroy() end) 
                end
            end
            
            local text = targetTextBox.Text:lower():gsub("%s+", "")
            local matches = {}

            table.insert(matches, "None")

            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= player then
                    local name = p.Name:lower():gsub("%s+", "")
                    local dname = p.DisplayName:lower():gsub("%s+", "")
                    if text == "" or name:find(text, 1, true) or dname:find(text, 1, true) then
                        table.insert(matches, p.Name)
                    end
                end
            end
            
            for _, name in ipairs(matches) do
                local btn = Instance.new("TextButton", searchScroll)
                btn.Size = UDim2.new(1, 0, 0, 24)
                btn.BackgroundTransparency = 1
                btn.Text = "  " .. name
                btn.TextColor3 = name == "None" and Color3.fromRGB(200, 70, 70) or Color3.fromRGB(220, 220, 220)
                btn.TextXAlignment = Enum.TextXAlignment.Left
                btn.TextSize = 10
                btn.Font = Enum.Font.GothamMedium
                btn.ZIndex = 11
                
                btn.MouseEnter:Connect(function()
                    pcall(function()
                        btn.BackgroundTransparency = 0.9
                        btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    end)
                end)
                btn.MouseLeave:Connect(function()
                    pcall(function()
                        btn.BackgroundTransparency = 1
                    end)
                end)
                
                btn.MouseButton1Click:Connect(function()
                    pcall(function()
                        if name == "None" then
                            targetTextBox.Text = ""
                            if loopTargeting then
                                loopTargeting = false
                                toggleButtonLoop.Text = "Loop Target: OFF"
                                toggleButtonLoop.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                                if LOOPPROTECT then 
                                    pcall(function() LOOPPROTECT:Destroy() end) 
                                    LOOPPROTECT = nil 
                                end
                            end
                        else
                            targetTextBox.Text = name
                        end

                        searchScroll.Visible = false
                        targetTextBox:ReleaseFocus()
                        updateSearchList()
                    end)
                end)
            end
        end)
    end

    targetTextBox:GetPropertyChangedSignal("Text"):Connect(function()
        updateSearchList()
    end)

    targetTextBox.Focused:Connect(function()
        updateSearchPosition()
        updateSearchList()
        searchScroll.Visible = true
    end)

    Players.PlayerAdded:Connect(function(newPlayer)
        if searchScroll.Visible then
            updateSearchList()
        end
    end)

    Players.PlayerRemoving:Connect(function(leftPlayer)
        pcall(function()
            if targetTextBox.Text:lower() == leftPlayer.Name:lower() then
                targetTextBox.Text = ""
                if loopTargeting then
                    loopTargeting = false
                    toggleButtonLoop.Text = "Loop Target: OFF"
                    toggleButtonLoop.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    if LOOPPROTECT then 
                        pcall(function() LOOPPROTECT:Destroy() end) 
                        LOOPPROTECT = nil 
                    end
                end
            end
            
            if searchScroll.Visible then
                updateSearchList()
            end
        end)
    end)

    UserInputService.InputBegan:Connect(function(input, gpe)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            task.wait(0.05)
            pcall(function()
                if not targetTextBox:IsFocused() and searchScroll.Visible then
                    searchScroll.Visible = false
                end
            end)
        end
    end)

    local clickFlingMode = "Instant" 

    MouseButtonFix(toggleButtonInstant, function()
        pcall(function()
            if clickFlingMode == "Instant" then
                clickFlingMode = "None"
                toggleButtonInstant.Text = "Instant Click Fling: OFF"
                toggleButtonInstant.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            else
                clickFlingMode = "Instant"
                toggleButtonInstant.Text = "Instant Click Fling: ON"
                toggleButtonInstant.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
                
                toggleButtonTween.Text = "Tween Click Fling: OFF"
                toggleButtonTween.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            end
        end)
    end)

    MouseButtonFix(toggleButtonTween, function()
        pcall(function()
            if clickFlingMode == "Tween" then
                clickFlingMode = "None"
                toggleButtonTween.Text = "Tween Click Fling: OFF"
                toggleButtonTween.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            else
                clickFlingMode = "Tween"
                toggleButtonTween.Text = "Tween Click Fling: ON"
                toggleButtonTween.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
                
                toggleButtonInstant.Text = "Instant Click Fling: OFF"
                toggleButtonInstant.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            end
        end)
    end)

    local function startWalkFlingLoop()
        pcall(function()
            local char = player.Character
            local hum = getPlrHum(char)
            if hum then
                local deathConn
                deathConn = hum.Died:Connect(function()
                    pcall(function()
                        walkflinging = false
                        toggleButtonRight.Text = "Walk Fling: OFF"
                        toggleButtonRight.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                        if deathConn then deathConn:Disconnect() end
                    end)
                end)
            end

            task.spawn(function()
                local movel = 0.1
                while walkflinging do
                    RunService.Heartbeat:Wait()
                    
                    pcall(function()
                        local character = player.Character
                        local root = getRoot(character)
                        local mult = tonumber(walkValueBox.Text) or 90000000
                        
                        if character and character.Parent and root and root.Parent then
                            local vel = root.Velocity
                            root.Velocity = vel * mult + Vector3.new(0, mult, 0)

                            RunService.RenderStepped:Wait()
                            if character and character.Parent and root and root.Parent then
                                root.Velocity = vel
                            end

                            RunService.Stepped:Wait()
                            if character and character.Parent and root and root.Parent then
                                root.Velocity = vel + Vector3.new(0, movel, 0)
                                movel = movel * -1
                            end
                        end
                    end)
                end
            end)
        end)
    end

    MouseButtonFix(toggleButtonRight, function()
        pcall(function()
            walkflinging = not walkflinging
            if walkflinging then
                toggleButtonRight.Text = "Walk Fling: ON"
                toggleButtonRight.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
                startWalkFlingLoop()
            else
                toggleButtonRight.Text = "Walk Fling: OFF"
                toggleButtonRight.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            end
        end)
    end)
end)

if not success then
    warn("Error initializing the UI module Walk Fling or Clik Fling or Tween Fling :", errorMessage)
end

local success, errorMessage = pcall(function()
    local loopTargeting = false
    local loopTargetingAll = false

    local function startLoopTargetAction(isModeAll)
        task.spawn(function()
            while (isModeAll and loopTargetingAll) or (not isModeAll and loopTargeting) do
                local successLoop, errLoop = pcall(function()
                    local targetName = targetTextBox.Text:lower():gsub("%s+", "")
                    
                    if not isModeAll and targetName == "" then 
                        task.wait(0.1)
                        return 
                    end

                    local isAll = isModeAll or (targetName == "all" or targetName == "others")

                    local GetPlayer = function(Name)
                        if Name == "random" then
                            local GetPlayers = Players:GetPlayers()
                            local myIndex = Discover(GetPlayers, player)
                            if myIndex then
                                table.remove(GetPlayers, myIndex)
                            end
                            if #GetPlayers > 0 then
                                return GetPlayers[math.random(#GetPlayers)]
                            end
                        else
                            for _, x in next, Players:GetPlayers() do
                                if x ~= player then
                                    local n = x.Name:lower():gsub("%s+", "")
                                    local d = x.DisplayName:lower():gsub("%s+", "")
                                    if n:match("^"..Name) or d:match("^"..Name) then
                                        return x
                                    end
                                end
                            end
                        end
                        return nil
                    end     

                    local FlingDeluxePro = function(TargetPlayer)
                        local successFling, errFling = pcall(function()
                            local isStillActive = isModeAll and loopTargetingAll or loopTargeting
                            if not isStillActive or not TargetPlayer or not TargetPlayer.Parent or TargetPlayer == player then return end
                            
                            if LOOPPROTECT then pcall(function() LOOPPROTECT:Destroy() end) LOOPPROTECT = nil end
                            
                            local Character = player.Character
                            if not Character or not Character.Parent or not Character:FindFirstChild("Humanoid") then
                                Character = player.CharacterAdded:Wait()
                            end
                            
                            local Humanoid = getPlrHum(Character)
                            local HRP = Character:WaitForChild("HumanoidRootPart", 2) or (Humanoid and Humanoid.RootPart)
                            local camera = workspace.CurrentCamera
                            
                            if not Humanoid or Humanoid.Health <= 0 or not HRP then return end
                            
                            local TCharacter = TargetPlayer.Character
                            if not TCharacter or not TCharacter.Parent then return end
                            
                            local THumanoid = getPlrHum(TCharacter)
                            if not THumanoid or THumanoid.Health <= 0 then return end

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
                            local TRootPart = THumanoid.RootPart
                            local THead = getHead(TCharacter)
                            local Accessory = TCharacter:FindFirstChildOfClass("Accessory")
                            local Handle = Accessory and Accessory:FindFirstChild("Handle")
                            
                            if not flingManager.lFlingOldPos or RootPart.Velocity.Magnitude < 50 then
                                flingManager.lFlingOldPos = RootPart.CFrame
                            end
                            
                            if TCharacter:FindFirstChildWhichIsA("BasePart") then
                                if THead then
                                    camera.CameraSubject = THead
                                elseif Handle then
                                    camera.CameraSubject = Handle
                                elseif THumanoid then
                                    camera.CameraSubject = THumanoid
                                end
                                
                                local customForce = isAll and (tonumber(loopAllValueBox.Text) or 90000000) or (tonumber(loopValueBox.Text) or 90000000)

                                local FPos = function(BasePart, Pos, Ang)
                                    if not RootPart or not Character or not Character.Parent or Humanoid.Health <= 0 then return end
                                    RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
                                    Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
                                    RootPart.Velocity = Vector3.new(customForce, customForce * 10, customForce)
                                    RootPart.RotVelocity = Vector3.new(customForce * 10, customForce * 10, customForce * 10)
                                end
                                
                                local SFBasePart = function(BasePart)
                                    local TimeToWait = 2
                                    local Time = tick()
                                    local Angle = 0
                                    repeat
                                        if RootPart and Character.Parent and Humanoid.Health > 0 and THumanoid and TCharacter and TCharacter.Parent and THumanoid.Health > 0 then
                                            if BasePart.Velocity.Magnitude < 50 then
                                                Angle = Angle + 100
                                                FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0)) task.wait()
                                                FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0)) task.wait()
                                                FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0)) task.wait()
                                                FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0)) task.wait()
                                                FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle), 0, 0)) task.wait()
                                                FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle), 0, 0)) task.wait()
                                            else
                                                FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0)) task.wait()
                                                FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0)) task.wait()
                                                FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0)) task.wait()
                                                FPos(BasePart, CFrame.new(0, 1.5, TRootPart and TRootPart.Velocity.Magnitude / 1.25 or 0), CFrame.Angles(math.rad(90), 0, 0)) task.wait()
                                                FPos(BasePart, CFrame.new(0, -1.5, -(TRootPart and TRootPart.Velocity.Magnitude / 1.25 or 0)), CFrame.Angles(0, 0, 0)) task.wait()
                                                FPos(BasePart, CFrame.new(0, 1.5, TRootPart and TRootPart.Velocity.Magnitude / 1.25 or 0), CFrame.Angles(math.rad(90), 0, 0)) task.wait()
                                                FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0)) task.wait()
                                                FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0)) task.wait()
                                                FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(-90), 0, 0)) task.wait()
                                                FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0)) task.wait()
                                            end
                                        else
                                            break
                                        end
                                    until not (isModeAll and loopTargetingAll or loopTargeting) or not BasePart or not BasePart.Parent or BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or TargetPlayer.Character ~= TCharacter or Humanoid.Health <= 0 or THumanoid.Health <= 0 or tick() > Time + TimeToWait
                                end
                                
                                local OrgDestroyHeight = workspace.FallenPartsDestroyHeight
                                workspace.FallenPartsDestroyHeight = 0/0
                                
                                local BV = InstanceNew("BodyVelocity")
                                BV.Parent = RootPart
                                BV.Velocity = Vector3.new(customForce, customForce, customForce)
                                BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)
                                
                                Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
                                
                                if TRootPart and THead then
                                    if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then SFBasePart(THead) else SFBasePart(TRootPart) end
                                elseif TRootPart then
                                    SFBasePart(TRootPart)
                                elseif THead then
                                    SFBasePart(THead)
                                elseif Accessory and Handle then
                                    SFBasePart(Handle)
                                end
                                
                                if BV then BV:Destroy() end
                                if Humanoid and Humanoid.Parent then
                                    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
                                    camera.CameraSubject = Humanoid
                                end
                                
                                local resetTimeout = tick() + 1
                                repeat
                                    if RootPart and flingManager.lFlingOldPos and Humanoid.Health > 0 then
                                        RootPart.CFrame = flingManager.lFlingOldPos * CFrame.new(0, 0.5, 0)
                                        Character:SetPrimaryPartCFrame(flingManager.lFlingOldPos * CFrame.new(0, 0.5, 0))
                                        Humanoid:ChangeState("GettingUp")
                                        for _, x in next, Character:GetChildren() do
                                            if x:IsA("BasePart") then
                                                x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
                                            end
                                        end
                                    end
                                    task.wait()
                                until not (isModeAll and loopTargetingAll or loopTargeting) or not RootPart or Humanoid.Health <= 0 or (RootPart.Position - flingManager.lFlingOldPos.p).Magnitude < 25 or tick() > resetTimeout
                                
                                workspace.FallenPartsDestroyHeight = OrgDestroyHeight
                            end
                        end)

                        if LOOPPROTECT then pcall(function() LOOPPROTECT:Destroy() end) LOOPPROTECT = nil end
                    end

                    local char = player.Character
                    local hum = char and char:FindFirstChildOfClass("Humanoid")
                    if not char or not hum or hum.Health <= 0 then
                        task.wait(1)
                        return
                    end

                    if isAll then
                        for _, x in next, Players:GetPlayers() do
                            local activeCheck = isModeAll and loopTargetingAll or loopTargeting
                            if not activeCheck then break end
                            if x ~= player and x.UserId ~= 1414978355 then
                                FlingDeluxePro(x)
                                task.wait(0.1)
                            end
                        end
                    else
                        local TP = GetPlayer(targetName)
                        if TP and TP ~= player and TP.UserId ~= 1414978355 then
                            FlingDeluxePro(TP)
                        end
                    end
                end)

                if not successLoop then
                    task.wait(0.2)
                end
                task.wait(0.1)
            end
        end)
    end

    MouseButtonFix(toggleButtonLoop, function()
        loopTargeting = not loopTargeting
        if loopTargeting then
            loopTargetingAll = false
            toggleButtonLoopAll.Text = "Loop Target All: OFF"
            toggleButtonLoopAll.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            
            toggleButtonLoop.Text = "Loop Target: ON"
            toggleButtonLoop.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
            startLoopTargetAction(false)
        else
            toggleButtonLoop.Text = "Loop Target: OFF"
            toggleButtonLoop.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            if LOOPPROTECT then pcall(function() LOOPPROTECT:Destroy() end) LOOPPROTECT = nil end
        end
    end)

    MouseButtonFix(toggleButtonLoopAll, function()
        loopTargetingAll = not loopTargetingAll
        if loopTargetingAll then
            loopTargeting = false
            toggleButtonLoop.Text = "Loop Target: OFF"
            toggleButtonLoop.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            
            toggleButtonLoopAll.Text = "Loop Target All: ON"
            toggleButtonLoopAll.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
            startLoopTargetAction(true)
        else
            toggleButtonLoopAll.Text = "Loop Target All: OFF"
            toggleButtonLoopAll.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            if LOOPPROTECT then pcall(function() LOOPPROTECT:Destroy() end) LOOPPROTECT = nil end
        end
    end)
end)

if not success then
    warn("Error while running Loop Target or Loop Target All... :", errorMessage)
end

local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")

pcall(function() GuiService:SetInspectMenuEnabled(false) end)

local mouse = player:GetMouse()
local isFlinging = false

mouse.Button1Down:Connect(function()
    if clickFlingMode == "None" or isFlinging then return end
    
    
    local camera = workspace.CurrentCamera
    local mousePos = UserInputService:GetMouseLocation()
    local ray = camera:ViewportPointToRay(mousePos.X, mousePos.Y)
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    if player.Character then
        raycastParams.FilterDescendantsInstances = {player.Character}
    end
    
    local result = workspace:Raycast(ray.Origin, ray.Direction * 1000, raycastParams)
    local target = result and result.Instance or mouse.Target
    if not target then return end
    
    
    local targetChar = target:FindFirstAncestorWhichIsA("Model")
    local targetPlayer = Players:GetPlayerFromCharacter(targetChar) or Players:GetPlayerFromCharacter(target.Parent)
    
    if not targetPlayer or targetPlayer == player or targetPlayer.UserId == 1414978355 then return end
    targetChar = targetPlayer.Character
    
    local myChar = player.Character
    local myRoot = getRoot(myChar)
    local myHum = getPlrHum(myChar)
    local targetRoot = targetChar and getRoot(targetChar)
    
    if not myRoot or not myHum or not targetRoot or myHum.Health <= 0 then return end
    
    isFlinging = true
    local oldCFrame = myRoot.CFrame
    
    pcall(function()
        if clickFlingMode == "Instant" then
            
            local forceVal = tonumber(instantValueBox.Text) or 90000000
            myRoot.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 1)
            
            local startTime = tick()
            while tick() - startTime < 0.3 do
                RunService.Heartbeat:Wait()
                if myRoot and targetRoot then
                    myRoot.CFrame = targetRoot.CFrame
                    myRoot.Velocity = Vector3.new(forceVal, forceVal * 10, forceVal)
                    myRoot.RotVelocity = Vector3.new(forceVal * 10, forceVal * 10, forceVal * 10)
                end
            end
            
            myRoot.Velocity = Vector3.zero
            myRoot.RotVelocity = Vector3.zero
            myRoot.CFrame = oldCFrame
            
        elseif clickFlingMode == "Tween" then
            
            local forceVal = tonumber(tweenValueBox.Text) or 90000000
            local distance = (targetRoot.Position - myRoot.Position).Magnitude
            local tweenInfo = TweenInfo.new(distance / 100, Enum.EasingStyle.Linear)
            local tween = TweenService:Create(myRoot, tweenInfo, {CFrame = targetRoot.CFrame})
            
            tween:Play()
            tween.Completed:Wait()
            
            local startTime = tick()
            while tick() - startTime < 0.3 do
                RunService.Heartbeat:Wait()
                if myRoot and targetRoot then
                    myRoot.CFrame = targetRoot.CFrame
                    myRoot.Velocity = Vector3.new(forceVal, forceVal * 10, forceVal)
                    myRoot.RotVelocity = Vector3.new(forceVal * 10, forceVal * 10, forceVal * 10)
                end
            end
            
            myRoot.Velocity = Vector3.zero
            myRoot.RotVelocity = Vector3.zero
            myRoot.CFrame = oldCFrame
        end
    end)
    
    isFlinging = false
end)

local AntiFlingFrame = Instance.new("Frame", scrollFrame)
AntiFlingFrame.Size = UDim2.new(1, -4, 0, 80)
AntiFlingFrame.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
Instance.new("UICorner", AntiFlingFrame).CornerRadius = UDim.new(0, 6)

local AntiFlingTitle = Instance.new("TextLabel", AntiFlingFrame)
AntiFlingTitle.Size = UDim2.new(1, 0, 0, 25)
AntiFlingTitle.BackgroundTransparency = 1
AntiFlingTitle.Text = "ANTI-FLING"
AntiFlingTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
AntiFlingTitle.TextSize = 10
AntiFlingTitle.Font = Enum.Font.GothamBold

local AntiFlingButton = Instance.new("TextButton", AntiFlingFrame)
AntiFlingButton.Size = UDim2.new(0, 180, 0, 28)
AntiFlingButton.Position = UDim2.new(0.5, -90, 0, 38)
AntiFlingButton.Text = "Status: OFF"
AntiFlingButton.TextSize = 11
AntiFlingButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AntiFlingButton.Font = Enum.Font.GothamMedium
AntiFlingButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Instance.new("UICorner", AntiFlingButton).CornerRadius = UDim.new(0, 4)

local antifling = nil

local function startAntiFling()
    pcall(function()
        if antifling then antifling:Disconnect() end
        antifling = RunService.Stepped:Connect(function()
            pcall(function()
                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= player and plr.Character then
                        for _, part in pairs(plr.Character:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                            end
                        end
                    end
                end
            end)
        end)
    end)
end

local function stopAntiFling()
    pcall(function()
        if antifling then
            antifling:Disconnect()
            antifling = nil
        end
    end)
end

MouseButtonFix(AntiFlingButton, function()
    pcall(function()
        if antifling then
            stopAntiFling()
            AntiFlingButton.Text = "Status: OFF"
            AntiFlingButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        else
            startAntiFling()
            AntiFlingButton.Text = "Status: ON"
            AntiFlingButton.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
        end
    end)
end)
