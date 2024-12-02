local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

if RunService:IsStudio() then
    while true do end
    game:Shutdown()
end

local player = Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local DragBar = Instance.new("Frame")
local PressButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local Sound = Instance.new("Sound")
local Highlight = Instance.new("Highlight")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.5, -75, 0.5, -50)
Frame.Size = UDim2.new(0, 150, 0, 150)

DragBar.Parent = Frame
DragBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
DragBar.Size = UDim2.new(1, 0, 0, 30)

UICorner.CornerRadius = UDim.new(0.1, 0)
UICorner.Parent = Frame

PressButton.Parent = Frame
PressButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
PressButton.Size = UDim2.new(0, 100, 0, 50)
PressButton.Position = UDim2.new(0.5, -50, 0.5, -45)
PressButton.Text = "Hit"
PressButton.Font = Enum.Font.SourceSans
PressButton.TextScaled = true
PressButton.TextColor3 = Color3.fromRGB(0, 0, 0)

local UIS = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

DragBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

DragBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

local hook
hook = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    if method == "FireServer" then
        local args = {...}
        if tostring(self) == "WalkSpeedChanged" or tostring(self) == "Ban" or tostring(self) == "GRAB" or tostring(self) == "AdminGUI" then
            return
        end
    end
    return hook(self, ...)
end)

local ac = game.StarterPlayer.StarterPlayerScripts.ClientAnticheat:FindFirstChild("AntiMobileExploits")
if ac then
    ac:Destroy()
end

game.StarterGui:SetCore("SendNotification", {
    Title = "Protection",
    Text = "Loaded Anti-Cheat bypasser for protection",
    Duration = 10,
})

local function reapplyEffects(character)
    local humanoid = character:WaitForChild("Humanoid")

    local idleAnim = Instance.new("Animation")
    idleAnim.AnimationId = "rbxassetid://16163355836"

    local walkAnim = Instance.new("Animation")
    walkAnim.AnimationId = "rbxassetid://16163350920"

    local buttonAnim = Instance.new("Animation")
    buttonAnim.AnimationId = "rbxassetid://17670135152"

    local idleTrack = humanoid:LoadAnimation(idleAnim)
    local walkTrack = humanoid:LoadAnimation(walkAnim)
    local buttonTrack = humanoid:LoadAnimation(buttonAnim)

    idleTrack:Play()

    local highlight = Instance.new("Highlight")
    highlight.Parent = character
    highlight.FillColor = Color3.fromRGB(0, 0, 0)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.Enabled = true

    local function addAccessory()
        local accessory = Instance.new("Accessory")
        local handle = Instance.new("Part")
        handle.Name = "Handle"
        handle.Size = Vector3.new(1, 1, 1)
        handle.Material = Enum.Material.SmoothPlastic
        handle.Color = Color3.new(1, 1, 1)
        handle.Anchored = false
        handle.CanCollide = false
        handle.Parent = accessory
        accessory.Parent = character

        local decal = Instance.new("Decal")
        decal.Texture = "rbxassetid://12783374258"
        decal.Parent = handle
    end

    local function applyGlitchEffect()
        local glitchDecal = Instance.new("Decal")
        glitchDecal.Texture = "rbxassetid://3876444567"
        glitchDecal.Parent = character.Head
        glitchDecal.Face = Enum.NormalId.Front
        glitchDecal.Transparency = 0.5
    end

    local function applyPurpleGlitchEffect()
        local purpleGlitchDecal = Instance.new("Decal")
        purpleGlitchDecal.Texture = "rbxassetid://3876444567"
        purpleGlitchDecal.Parent = character.Head
        purpleGlitchDecal.Face = Enum.NormalId.Front
        purpleGlitchDecal.Transparency = 0.5
    end

    addAccessory()
    applyGlitchEffect()
    applyPurpleGlitchEffect()
end

player.CharacterAdded:Connect(function(character)
    reapplyEffects(character)
end)

PressButton.MouseButton1Click:Connect(function()
    for _, player in pairs(game.Players:GetPlayers()) do
        local args = {
            [1] = player,
            [2] = true
        }
        local boxingEvent = game.ReplicatedStorage:WaitForChild("Events"):WaitForChild("Boxing")
        boxingEvent:FireServer(unpack(args))
    end
end)

Sound.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
Sound.SoundId = "rbxassetid://9133844756"
Sound.Looped = true
Sound:Play()

fireclickdetector(game.Workspace.Lobby.GloveStands.Boxer.ClickDetector)
wait(2)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-18.0076027, -5.17285204, 33.9847603, 0.505942583, -5.25545936e-08, -0.862567186, -5.27617594e-08, 1, -9.1875755e-08, 0.862567186, 9.19944227e-08, 0.505942583)
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50
part = Instance.new("Part")
    part.Name = "AntiVoid"
    part.Size = Vector3.new(1000, 0, 1000)
    part.Transparency = 0.5
    part.CanCollide = true
    part.Anchored = true
    part.Position = Vector3.new(0, -9, 0)
    part.Parent = game.Workspace
