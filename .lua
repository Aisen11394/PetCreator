local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 500)
frame.Position = UDim2.new(0.5, -150, 0.5, -250)
frame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local closeButton = Instance.new("TextButton")
closeButton.Text = "X"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextSize = 18
closeButton.Parent = frame

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

local title = Instance.new("TextLabel")
title.Text = "Pet Editor"
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 10)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 24
title.BackgroundTransparency = 1
title.Parent = frame

local function createInputField(parent, labelText, positionY)
    local label = Instance.new("TextLabel")
    label.Text = labelText
    label.Position = UDim2.new(0, 10, 0, positionY)
    label.Size = UDim2.new(0, 100, 0, 20)
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Parent = parent

    local textBox = Instance.new("TextBox")
    textBox.Position = UDim2.new(0, 120, 0, positionY)
    textBox.Size = UDim2.new(0, 160, 0, 20)
    textBox.BackgroundColor3 = Color3.new(1, 1, 1)
    textBox.TextColor3 = Color3.new(0, 0, 0)
    textBox.Parent = parent

    return textBox
end

local levelInput = createInputField(frame, "Level", 30)
local experienceInput = createInputField(frame, "Experience", 60)
local nameInput = createInputField(frame, "Name", 90)

local function createToggleButton(parent, labelText, positionY)
    local label = Instance.new("TextLabel")
    label.Text = labelText
    label.Position = UDim2.new(0, 10, 0, positionY)
    label.Size = UDim2.new(0, 100, 0, 20)
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Parent = parent

    local toggleButton = Instance.new("TextButton")
    toggleButton.Position = UDim2.new(0, 120, 0, positionY)
    toggleButton.Size = UDim2.new(0, 50, 0, 20)
    toggleButton.BackgroundColor3 = Color3.new(1, 0, 0)
    toggleButton.Text = "Off"
    toggleButton.TextColor3 = Color3.new(1, 1, 1)
    toggleButton.Font = Enum.Font.SourceSans
    toggleButton.TextSize = 14
    toggleButton.AutoButtonColor = false
    toggleButton.Parent = parent

    local isToggled = false

    toggleButton.MouseButton1Click:Connect(function()
        isToggled = not isToggled
        if isToggled then
            toggleButton.BackgroundColor3 = Color3.new(0, 1, 0)
            toggleButton.Text = "On"
        else
            toggleButton.BackgroundColor3 = Color3.new(1, 0, 0)
            toggleButton.Text = "Off"
        end
    end)

    return toggleButton, function() return isToggled end
end

local bigToggle, getBigState = createToggleButton(frame, "Big", 120)
local goldenToggle, getGoldenState = createToggleButton(frame, "Golden", 150)
local hugeToggle, getHugeState = createToggleButton(frame, "Huge", 180)

local modelScroll = Instance.new("ScrollingFrame")
modelScroll.Size = UDim2.new(0, 120, 0, 150)
modelScroll.Position = UDim2.new(0, 10, 0, 210)
modelScroll.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
modelScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
modelScroll.Parent = frame

local modelList = {
    "Animatronic_Bear", "Banana_Man", "Batguy", "Bear", "Blue_Glow_Spirit", "Coconut_Warrior", "Corrupted_Spider", "Crab_Man", "Crimson_Dragon", "Cyber_Diver", "Cyborg_Bunny", "Cyborg_Deer", "Dark_Cyborg", "Dark_King", "Dark_Lion", "Dark_Wizard", "Death_Pool", "Diver", "Dog", "Earth_Beast", "Earth_Mage", "Emerald_Night_Raider", "Evil_Robot", "Fire_Night_Raider", "Fire_Wizard", "Fish_Man", "Ghost_Glow_Spirit", "Ghost_Raider", "Goka", "Gold_King", "Golden_Warrior", "Green_CyberBOT", "Hell_Hound", "Homesander", "Ice_Beast", "Ice_Bird", "Ice_Deer", "Ice_Night_Raider", "Ice_Queen", "Ice_Wizard", "Ichistop", "Jewel_Warrior", "KSY", "King_CyberBOT", "Lava_Bear", "Lava_Deer", "Lava_Monster", "Logan_Raul", "Luffi", "Mouse", "Mutant_Beast", "Mutant_Dog", "Mutant_Lizard", "Narotu", "Neon_Raider", "Neon_Volcano_Beast", "Nuclear_Monster", "OMG", "Octoguy", "Owl_Warrior", "Pink_CyberBOT", "Pink_Soldier", "Poison_Bunny", "Poison_Deer", "Poison_Lion", "Poison_Pig", "Polar_Bear", "Princess", "Pro_Future_Warrior", "Purple_Future_Warrior", "Purple_Volcano_Beast", "Queen", "Red_Future_Warrior", "Red_Glow_Spirit", "Rock_Expert", "Sand_Dragon", "Sand_Man", "Shark_Man", "Sir_Beast", "Skeleton_General", "Snow_Bird", "Snow_Deer", "Soldier", "SpiderWeb_Man", "Tactical_Soldier", "The_CamMan", "Volcano_Beast"
}

local selectedModel = "Crimson_Dragon"

local currentModelLabel = Instance.new("TextLabel")
currentModelLabel.Text = "Model: " .. selectedModel
currentModelLabel.Position = UDim2.new(0, 10, 0, 370)
currentModelLabel.Size = UDim2.new(0, 280, 0, 20)
currentModelLabel.TextColor3 = Color3.new(1, 1, 1)
currentModelLabel.Parent = frame

local function populateModelScroll()
    for i, modelName in ipairs(modelList) do
        local modelButton = Instance.new("TextButton")
        modelButton.Text = modelName
        modelButton.Size = UDim2.new(0, 100, 0, 20)
        modelButton.Position = UDim2.new(0, 10, 0, (i-1)*25)
        modelButton.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
        modelButton.TextColor3 = Color3.new(1, 1, 1)
        modelButton.Font = Enum.Font.SourceSans
        modelButton.TextSize = 14
        modelButton.Parent = modelScroll

        modelButton.MouseButton1Click:Connect(function()
            selectedModel = modelName
            currentModelLabel.Text = "Model: " .. selectedModel
        end)
    end
    modelScroll.CanvasSize = UDim2.new(0, 0, 0, #modelList * 25)
end

populateModelScroll()

local rarityScroll = Instance.new("ScrollingFrame")
rarityScroll.Size = UDim2.new(0, 120, 0, 150)
rarityScroll.Position = UDim2.new(0, 150, 0, 210)
rarityScroll.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
rarityScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
rarityScroll.Parent = frame

local rarityList = {"Common", "Uncommon", "Rare", "Legendary", "Epic", "Exclusive"}

local selectedRarity = "Exclusive"

local currentRarityLabel = Instance.new("TextLabel")
currentRarityLabel.Text = "Rarity: " .. selectedRarity
currentRarityLabel.Position = UDim2.new(0, 10, 0, 400)
currentRarityLabel.Size = UDim2.new(0, 280, 0, 20)
currentRarityLabel.TextColor3 = Color3.new(1, 1, 1)
currentRarityLabel.Parent = frame

local function populateRarityScroll()
    for i, rarityName in ipairs(rarityList) do
        local rarityButton = Instance.new("TextButton")
        rarityButton.Text = rarityName
        rarityButton.Size = UDim2.new(0, 100, 0, 20)
        rarityButton.Position = UDim2.new(0, 10, 0, (i-1)*25)
        rarityButton.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
        rarityButton.TextColor3 = Color3.new(1, 1, 1)
        rarityButton.Font = Enum.Font.SourceSans
        rarityButton.TextSize = 14
        rarityButton.Parent = rarityScroll

        rarityButton.MouseButton1Click:Connect(function()
            selectedRarity = rarityName
            currentRarityLabel.Text = "Rarity: " .. selectedRarity
        end)
    end
    rarityScroll.CanvasSize = UDim2.new(0, 0, 0, #rarityList * 25)
end

populateRarityScroll()

local applyButton = Instance.new("TextButton")
applyButton.Text = "Apply"
applyButton.Position = UDim2.new(0, 80, 0, 430)
applyButton.Size = UDim2.new(0, 140, 0, 30)
applyButton.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
applyButton.TextColor3 = Color3.new(1, 1, 1)
applyButton.Font = Enum.Font.SourceSans
applyButton.TextSize = 18
applyButton.Parent = frame

applyButton.MouseButton1Click:Connect(function()
    local randomUUID = tostring(math.random(100000, 999999))

    local args = {
        [1] = {
            ["UUID"] = randomUUID,
            ["Rarity"] = selectedRarity,
            ["Enchantment"] = {},
            ["Huge"] = getHugeState(),
            ["Golden"] = getGoldenState(),
            ["Name"] = nameInput.Text,
            ["Experience"] = tonumber(experienceInput.Text) or 0,
            ["Model"] = selectedModel,
            ["Locked"] = false,
            ["Level"] = tonumber(levelInput.Text) or 1,
            ["Equipped"] = false,
            ["Big"] = getBigState()
        },
        [2] = player
    }

    ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("Pets"):WaitForChild("GiveBoughtPet"):FireServer(unpack(args))
end)
