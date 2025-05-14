local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")

if getgenv().DScriptLoad then
    StarterGui:SetCore("SendNotification", {  
        Title = "Erroɾ";
        Text = "Already loaded";
        Duration = 10; 
        Icon = "rbxassetid://99911273351388";
    })
    return
end

getgenv().DScriptLoad = true

local thumbsUpImage = "rbxassetid://97609256286565"
local thumbsDownImage = "rbxassetid://99911273351388"

local function sendNotification(title, text, duration, image)
    StarterGui:SetCore("SendNotification", {  
        Title = title;
        Text = text;
        Duration = duration; 
        Icon = image;
    })
end

local placeIds = {
    [6839171747] = "You are in a Doors match!",
    [10549820578] = "You are in a Super Hard Mode Doors match!",
    [6516141723] = "You are in the Doors lobby!",
    [12308344607] = "You are in the Doors Voice Chat lobby!"
}

local soundIdMaps = {
    [6839171747] = {
        ["rbxassetid://11447013731"] = {id = "rbxassetid://5188314808", volume = 1.0},
        ["rbxassetid://7758469482"] = {id = "rbxassetid://5037969255", volume = 1.2},
        ["rbxassetid://8007673711"] = {id = "rbxassetid://9114149321", volume = 0.8},
        ["rbxassetid://16604121645"] = {id = "rbxassetid://5037969255", volume = 1.1},
        ["rbxassetid://10470707502"] = {id = "rbxassetid://12159119088", volume = 0.9},
        ["rbxassetid://6973423505"] = {id = "rbxassetid://6973423694", volume = 1.5},
        ["rbxassetid://9113549320"] = {id = "rbxassetid://8248258948", volume = 1.0},
        ["rbxassetid://10460221938"] = {id = "rbxassetid://10907273416", volume = 0.7},
        ["rbxassetid://10472770795"] = {id = "rbxassetid://11638638410", volume = 1.4},
        ["rbxassetid://10470715177"] = {id = "rbxassetid://5246103002", volume = 1.3},
        ["rbxassetid://17717855685"] = {id = "rbxassetid://103523196237716", volume = 1.0},
        ["rbxassetid://103523196237716"] = {id = "rbxassetid://5188314808", volume = 1.0}
    },
    [10549820578] = {
        ["rbxassetid://8007673711"] = {id = "rbxassetid://9114149321", volume = 0.8},
        ["rbxassetid://16604121645"] = {id = "rbxassetid://5037969255", volume = 1.1},
        ["rbxassetid://11447013731"] = {id = "rbxassetid://5188314808", volume = 1.0},
        ["rbxassetid://7758469482"] = {id = "rbxassetid://5037969255", volume = 1.2},
        ["rbxassetid://6973423505"] = {id = "rbxassetid://6973423694", volume = 1.5},
        ["rbxassetid://10460221938"] = {id = "rbxassetid://10907273416", volume = 0.7},
        ["rbxassetid://10470707502"] = {id = "rbxassetid://12159119088", volume = 0.9},
        ["rbxassetid://10470715177"] = {id = "rbxassetid://5246103002", volume = 1.3},
        ["rbxassetid://17717855685"] = {id = "rbxassetid://103523196237716", volume = 1.0},
        ["rbxassetid://103523196237716"] = {id = "rbxassetid://5188314808", volume = 1.0}
    },
    [6516141723] = {
        ["rbxassetid://7767565697"] = {id = "rbxassetid://11638638410", volume = 1.0}
    },
    [12308344607] = {
        ["rbxassetid://7767565697"] = {id = "rbxassetid://11638638410", volume = 1.0}
    }
}

local placeId = game.PlaceId
local placeMessage = placeIds[placeId]
local soundIdMap = soundIdMaps[placeId]

if placeMessage then
    sendNotification("Place Check", placeMessage, 10, thumbsUpImage)

    if soundIdMap then
        local processedSounds = {}

        local function modifySound(sound)
            if not sound:IsA("Sound") then return end
            local replacement = soundIdMap[sound.SoundId]
            if replacement and not processedSounds[sound] then
                sound.SoundId = replacement.id
                sound.Volume = replacement.volume
                processedSounds[sound] = true
            end
        end

        -- First pass: existing sounds
        for _, obj in ipairs(workspace:GetDescendants()) do
            modifySound(obj)
        end

        -- Forever hook: new sounds
        workspace.DescendantAdded:Connect(modifySound)
    end
end
