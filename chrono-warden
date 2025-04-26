// some shitty chrono warden keybind to chat thing. idk why i made this LOEL!



--// Services
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local TextChatService = game:GetService("TextChatService")

--// Variables
local player = Players.LocalPlayer
local holdThreshold = 0.4 -- hold time to trigger "hold" message
local pressedTimes = {}

--// Key Message Mapping
local keyMessages = {
    [Enum.KeyCode.E] = {quick = "world devastation."},
    [Enum.KeyCode.R] = {quick = "ruin.", hold = "perish."},
    [Enum.KeyCode.T] = {quick = "its over."},
    [Enum.KeyCode.Y] = {quick = "Fracture.", hold = "move away."},
    [Enum.KeyCode.G] = {quick = "simon says stop", hold = "black hole."},
    [Enum.KeyCode.H] = {quick = "THE WORLD! GRIND TO A HALT!"},
    [Enum.KeyCode.Z] = {quick = "placeholder"},
    [Enum.KeyCode.V] = {quick = "placeholder"},
    [Enum.KeyCode.B] = {quick = "placeholder"},
}

--// Helper to Send Chat Messages - Multiple methods for compatibility
local function sendChatMessage(message)
    -- Method 1: Legacy chat system
    local chatEvent = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
    if chatEvent and chatEvent:FindFirstChild("SayMessageRequest") then
        chatEvent.SayMessageRequest:FireServer(message, "All")
        print("Attempted to send via Legacy Chat: " .. message)
        return
    end
    
    -- Method 2: TextChatService (newer chat system)
    if TextChatService and TextChatService:FindFirstChild("TextChannels") and 
       TextChatService.TextChannels:FindFirstChild("RBXGeneral") then
        TextChatService.TextChannels.RBXGeneral:SendAsync(message)
        print("Attempted to send via TextChatService: " .. message)
        return
    end
    
    -- Method 3: Using StarterGui Chat API
    local success, error = pcall(function()
        StarterGui:SetCore("ChatMakeSystemMessage", {
            Text = player.Name .. ": " .. message,
            Color = Color3.fromRGB(255, 255, 255)
        })
    end)
    
    if success then
        print("Displayed system message: " .. message)
    else
        -- Method 4: Last resort - direct chat command
        if player and player.Character then
            game:GetService("Chat"):Chat(player.Character, message, Enum.ChatColor.White)
            print("Attempted to use Chat service: " .. message)
        else
            warn("Failed to send chat message: " .. message)
        end
    end
end

-- Debug function to check chat systems
local function debugChatSystems()
    print("=== CHAT SYSTEMS DEBUG ===")
    
    -- Check Legacy Chat
    if ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") then
        if ReplicatedStorage.DefaultChatSystemChatEvents:FindFirstChild("SayMessageRequest") then
            print("✓ Legacy chat system found")
        else
            print("✗ Legacy chat system incomplete (SayMessageRequest missing)")
        end
    else
        print("✗ Legacy chat system not found")
    end
    
    -- Check TextChatService
    if TextChatService and TextChatService:FindFirstChild("TextChannels") then
        print("✓ TextChatService available")
    else
        print("✗ TextChatService not properly configured")
    end
    
    -- Check if player exists
    if player then
        print("✓ LocalPlayer found: " .. player.Name)
    else
        print("✗ LocalPlayer not found")
    end
    
    print("========================")
end

-- Run debug on script start
wait(2) -- Wait for systems to initialize
debugChatSystems()
sendChatMessage("snort") -- Test message

--// Detect when key is pressed
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end -- Don't process if UI has focus
    
    local msgData = keyMessages[input.KeyCode]
    if msgData then
        print("Key pressed: " .. tostring(input.KeyCode))
        pressedTimes[input.KeyCode] = tick()
    end
end)

--// Detect when key is released
UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if gameProcessed then return end -- Don't process if UI has focus
    
    local msgData = keyMessages[input.KeyCode]
    if msgData and pressedTimes[input.KeyCode] then
        local heldTime = tick() - pressedTimes[input.KeyCode]
        local message
        
        if heldTime >= holdThreshold and msgData.hold then
            message = msgData.hold
        else
            message = msgData.quick
        end
        
        print("Sending message: " .. message)
        sendChatMessage(message)
        pressedTimes[input.KeyCode] = nil
    end
end)

-- Notify that script is running
print("Chat hotkey script is running")
