local RSGCore = exports['rsg-core']:GetCoreObject()
local currentlyPlaying = {}

RegisterNetEvent('rs_phonograph:server:playMusic')
AddEventHandler('rs_phonograph:server:playMusic', function(uniqueId, coords, url, volume, loop)
    if currentlyPlaying[uniqueId] then
        currentlyPlaying[uniqueId] = nil
        TriggerClientEvent('rs_phonograph:client:stopMusic', -1, uniqueId)
    end

    currentlyPlaying[uniqueId] = {
        url = url,
        volume = volume,
        coords = coords,
        loop = loop or false,
        startTime = os.time()
    }

    TriggerClientEvent('rs_phonograph:client:playMusic', -1, uniqueId, coords, url, volume, loop or false, 0)
end)

RegisterNetEvent('rs_phonograph:server:resetLoop')
AddEventHandler('rs_phonograph:server:resetLoop', function(uniqueId)
    if currentlyPlaying[uniqueId] then
        currentlyPlaying[uniqueId].startTime = os.time()
    end
end)

RegisterNetEvent('rs_phonograph:server:stopMusic')
AddEventHandler('rs_phonograph:server:stopMusic', function(uniqueId)
    currentlyPlaying[uniqueId] = nil
    TriggerClientEvent('rs_phonograph:client:stopMusic', -1, uniqueId)
end)

RegisterNetEvent('rs_phonograph:server:setVolume')
AddEventHandler('rs_phonograph:server:setVolume', function(uniqueId, newVolume)
    TriggerClientEvent('rs_phonograph:client:setVolume', -1, uniqueId, newVolume)
end)

RegisterNetEvent('rs_phonograph:server:soundEnded')
AddEventHandler('rs_phonograph:server:soundEnded', function(uniqueId)
    currentlyPlaying[uniqueId] = nil
end)

RegisterNetEvent('rs_phonograph:server:toggleLoop')
AddEventHandler('rs_phonograph:server:toggleLoop', function(uniqueId, state)
    local src = source
    if currentlyPlaying[uniqueId] then
        currentlyPlaying[uniqueId].loop = state
        currentlyPlaying[uniqueId].startTime = os.time()
    end
    TriggerClientEvent('rs_phonograph:client:toggleLoop', -1, uniqueId, state)
    TriggerClientEvent('rs_phonograph:client:notifyLoop', src, state)
end)

RegisterNetEvent('rs_phonograph:server:syncMusic')
AddEventHandler('rs_phonograph:server:syncMusic', function()
    local src = source
    for uniqueId, data in pairs(currentlyPlaying) do
        local elapsed = os.time() - data.startTime
        if elapsed < 0 then elapsed = 0 end
        TriggerClientEvent('rs_phonograph:client:playMusic', src, uniqueId, data.coords, data.url, data.volume, data.loop, elapsed)
    end
end)

local loadedPhonographs = {}

AddEventHandler('onResourceStart', function(resource)
    if GetCurrentResourceName() ~= resource then return end

    exports.oxmysql:execute('SELECT * FROM phonographs', {}, function(results)
        if results then
            loadedPhonographs = {}
            for _, row in pairs(results) do
                local phonographData = {
                    id = row.id,
                    x = row.x,
                    y = row.y,
                    z = row.z,
                    rotation = { x = row.rot_x, y = row.rot_y, z = row.rot_z }
                }
                table.insert(loadedPhonographs, phonographData)
            end
        end
    end)
end)

RegisterNetEvent('rs_phonograph:server:requestPhonographs')
AddEventHandler('rs_phonograph:server:requestPhonographs', function()
    local src = source
    TriggerClientEvent('rs_phonograph:client:receivePhonographs', src, loadedPhonographs)
end)

RegisterNetEvent('rs_phonograph:server:saveOwner', function(coords, rotation)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end

    local citizenid = Player.PlayerData.citizenid
    local rotX, rotY, rotZ = rotation.x, rotation.y, rotation.z

    local query = [[
        INSERT INTO phonographs (owner_citizenid, x, y, z, rot_x, rot_y, rot_z)
        VALUES (@citizenid, @x, @y, @z, @rot_x, @rot_y, @rot_z)
    ]]

    local params = {
        ['@citizenid'] = citizenid,
        ['@x']        = coords.x,
        ['@y']        = coords.y,
        ['@z']        = coords.z,
        ['@rot_x']    = rotX,
        ['@rot_y']    = rotY,
        ['@rot_z']    = rotZ,
    }

    exports.oxmysql:execute(query, params, function(result)
        if result and result.insertId then
            local phonographData = {
                id       = result.insertId,
                x        = coords.x,
                y        = coords.y,
                z        = coords.z,
                rotation = { x = rotX, y = rotY, z = rotZ }
            }

            table.insert(loadedPhonographs, phonographData)
            TriggerClientEvent('rs_phonograph:client:spawnPhonograph', -1, phonographData)
        end
    end)
end)

RegisterNetEvent('rs_phonograph:server:pickUpByOwner', function(uniqueId)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end

    local citizenid = Player.PlayerData.citizenid
    local playerPed = GetPlayerPed(src)
    local playerCoords = GetEntityCoords(playerPed)

    exports.oxmysql:execute(
        'SELECT * FROM phonographs WHERE id = ? AND owner_citizenid = ?',
        { uniqueId, citizenid },
        function(results)
            if results and #results > 0 then
                local row = results[1]
                local phonoCoords = vector3(row.x, row.y, row.z)
                local distance = #(playerCoords - phonoCoords)

                if distance <= 2.5 then
                    TriggerClientEvent('rs_phonograph:client:removePhonograph', -1, uniqueId)
                    TriggerEvent('rs_phonograph:server:stopMusic', uniqueId)

                    for i, phonograph in ipairs(loadedPhonographs) do
                        if phonograph.id == uniqueId then
                            table.remove(loadedPhonographs, i)
                            break
                        end
                    end

                    exports.oxmysql:execute(
                        'DELETE FROM phonographs WHERE id = ?',
                        { uniqueId },
                        function(result)
                            local affected = result and (result.affectedRows or result.affected_rows or result.changes)
                            if affected and affected > 0 then
                                Player.Functions.AddItem(Config.PhonoItems, 1)
                                TriggerClientEvent('rs_phonograph:ShowAdvancedLeftNotification', src,
                                    Config.Notify.Picked, "generic_textures", "tick", "COLOR_GREEN", 4000)
                            end
                        end
                    )
                else
                    TriggerClientEvent('rs_phonograph:ShowAdvancedLeftNotification', src,
                        Config.Notify.TooFar, "menu_textures", "cross", "COLOR_RED", 3000)
                end
            else
                TriggerClientEvent('rs_phonograph:ShowAdvancedLeftNotification', src,
                    Config.Notify.Dont, "menu_textures", "cross", "COLOR_RED", 3000)
            end
        end
    )
end)

RSGCore.Functions.CreateUseableItem(Config.PhonoItems, function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end

    local citizenid = Player.PlayerData.citizenid

    exports.oxmysql:execute(
        'SELECT id FROM phonographs WHERE owner_citizenid = ?',
        { citizenid },
        function(result)
            if result and #result > 0 then
                TriggerClientEvent('rs_phonograph:ShowAdvancedLeftNotification', src,
                    Config.Notify.Already, "menu_textures", "cross", "COLOR_RED", 3000)
            else
                TriggerClientEvent("rs_phonograph:client:placePropPhonograph", src)
            end
        end
    )
end)

RegisterNetEvent("rs_phonograph:givePhonograph", function()
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end

    Player.Functions.RemoveItem(Config.PhonoItems, 1)
end)
