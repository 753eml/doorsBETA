local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

if getgenv().doorsscriptloaded then
    local thumbsDownImage = "rbxassetid://99911273351388"
    game:GetService("StarterGui"):SetCore("SendNotification", {  
        Title = "Erroɾ";
        Text = "Doors script already loaded!";
        Duration = 10; 
        Icon = thumbsDownImage;
    })
    return
end

local placeIds = {
    [6839171747] = "You are in a Doors match!",
    [10549820578] = "You are in a Super Hard Mode Doors match!",
    [6516141723] = "You are in the Doors lobby!",
    [12308344607] = "You are in the Doors Voice Chat lobby!"
}

local thumbsUpImage = "rbxassetid://97609256286565"
local thumbsDownImage = "rbxassetid://99911273351388"

local function sendNotification(title, text, duration, image)
    game:GetService("StarterGui"):SetCore("SendNotification", {  
        Title = title;
        Text = text;
        Duration = duration; 
        Icon = image;
    })
end

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

if placeIds[game.PlaceId] then
    sendNotification("Place Check", placeIds[game.PlaceId], 10, thumbsUpImage)
    local soundIdMap = soundIdMaps[game.PlaceId]
    if soundIdMap then
        local function modifySound(sound)
            local soundInfo = soundIdMap[sound.SoundId]
            if soundInfo then
                sound.SoundId = soundInfo.id
                sound.Volume = soundInfo.volume
            end
        end

        -- Modify sounds in a single pass
        for _, sound in ipairs(workspace:GetDescendants()) do
            if sound:IsA("Sound") then
                modifySound(sound)
            end
        end

        -- Hook into new sounds being added, but do it more efficiently
        local connection = workspace.DescendantAdded:Connect(function(descendant)
            if descendant:IsA("Sound") then
                modifySound(descendant)
            end
        end)

        -- Disconnect after some time to reduce overhead
        task.delay(10, function()
            connection:Disconnect()
        end)
    end
end

getgenv().doorsscriptloaded = true
