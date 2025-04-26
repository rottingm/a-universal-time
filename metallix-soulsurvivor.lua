-- Services
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")

-- Map your keys to the combos
local keyMap = {
    [Enum.KeyCode.E] = {Enum.KeyCode.Six},
    [Enum.KeyCode.R] = {Enum.KeyCode.Three},
    [Enum.KeyCode.T] = {Enum.KeyCode.Seven},
    [Enum.KeyCode.Y] = {Enum.KeyCode.Two},
    [Enum.KeyCode.G] = {Enum.KeyCode.Three},
    [Enum.KeyCode.H] = {Enum.KeyCode.Four},
    [Enum.KeyCode.V] = {Enum.KeyCode.Five},
    [Enum.KeyCode.B] = {Enum.KeyCode.Zero},
    [Enum.KeyCode.P] = {Enum.KeyCode.One, Enum.KeyCode.Four}, -- special case: 1 and 4
    [Enum.KeyCode.X] = {Enum.KeyCode.One},
}

-- Helper to press and optionally hold
local function pressKey(keyCode, holdTime)
    VirtualInputManager:SendKeyEvent(true, keyCode, false, game)
    if holdTime then
        task.wait(holdTime)
    end
    VirtualInputManager:SendKeyEvent(false, keyCode, false, game)
end

-- Main input listener
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    local numberKeys = keyMap[input.KeyCode]
    if numberKeys then
        -- Hold N
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.N, false, game)

        -- Press the mapped number key(s)
        for _, keyCode in ipairs(numberKeys) do
            pressKey(keyCode, 1) -- Hold each key for 1 second
        end

        -- Release N
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.N, false, game)
    end
end)
