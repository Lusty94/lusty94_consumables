-- Server-side consumables script
local QBCore = exports['qb-core']:GetCoreObject()
local InvType = Config.CoreSettings.Inventory.Type
local NotifyType = Config.CoreSettings.Notify.Type
local debug = Config.CoreSettings.Debugging.Enabled

--notification function
local function SendNotify(src, msg, type, time, title)
    if NotifyType == nil then print("Lusty94_Consumables: NotifyType Not Set in Config.CoreSettings.Notify.Type!") return end
    if not title then title = "Consumables" end
    if not time then time = 5000 end
    if not type then type = 'success' end
    if not msg then print("Notification Sent With No Message") return end
    if NotifyType == 'qb' then
        TriggerClientEvent('QBCore:Notify', src, msg, type, time)
    elseif NotifyType == 'okok' then
        TriggerClientEvent('okokNotify:Alert', src, title, msg, time, type, Config.CoreSettings.Notify.Sound)
    elseif NotifyType == 'mythic' then
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = type, text = msg, style = { ['background-color'] = '#00FF00', ['color'] = '#FFFFFF' } })
    elseif NotifyType == 'boii'  then
        TriggerClientEvent('boii_ui:notify', src, title, msg, type, time)
    elseif NotifyType == 'ox' then 
        TriggerClientEvent('ox_lib:notify', src, ({ title = title, description = msg, length = time, type = type, style = 'default'}))
    elseif NotifyType == 'custom' then
        --insert your own notify functions here
    end
end

--remove items
local function removeItem(src, item, amount)
    if InvType == 'qb' then
        if exports['qb-inventory']:RemoveItem(src, item, amount, false, false, false) then
            TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'remove', amount)
        end
    elseif InvType == 'ox' then
        exports.ox_inventory:RemoveItem(src, item, amount)
    elseif InvType == 'custom' then
        --insert your own inventory methods for item removal here following the templates used
    end
end


--useable items
for itemName, _ in pairs(Config.Consumables) do
    QBCore.Functions.CreateUseableItem(itemName, function(source, item)
        if debug then print('| Lusty94_Consumables | Server ID: ', source, 'is using: ', itemName) end
        TriggerClientEvent('lusty94_consumables:client:UseItem', source, item.name)
    end)
end


--callback for items and required items
QBCore.Functions.CreateCallback('lusty94_consumables:server:hasItem', function(source, cb, itemName)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = Config.Consumables[itemName]
    if item then
        if item.requireditem then
            local requiredItem = Player.Functions.GetItemByName(item.requireditem)  
            if debug then print('| Lusty94_Consumables | Useable item: ', itemName, '  has a requiredItem paramater: ', item.requireditem) end          
            if requiredItem then
                cb(true)
            else
                SendNotify(src, 'You need a ' .. item.requireditem .. ' to use this!', 'error', 5000)
                if debug then print('| Lusty94_Consumables | Missing requiredItem: ', item.requireditem) end          
                cb(false)
            end
        else
            cb(true)
        end
    else
        cb(false)
        if debug then print('| Lusty94_Consumables | Failed item callback: Missing items') end          
    end
end)

--use item
RegisterNetEvent('lusty94_consumables:server:UseItem', function(itemName)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        removeItem(src, itemName, 1)
        if debug then print('| Lusty94_Consumables | Item Removed: ', itemName) end
    end
end)

--update metadata
RegisterNetEvent('lusty94_consumables:server:UpdateNeeds', function(itemName)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = Config.Consumables[itemName]
    if not item then return end
    if not Player then return end    

    local currentHunger = Player.PlayerData.metadata["hunger"]
    local currentThirst = Player.PlayerData.metadata["thirst"]    
    local newHunger = currentHunger
    local newThirst = currentThirst

    if debug then print('| Lusty94_Consumables | Current Hunger: ', currentHunger) end
    if debug then print('| Lusty94_Consumables | Current Thirst: ', currentThirst) end
    if debug then print('| Lusty94_Consumables | Item Replenishment Type: ', item.replenish) end

    if item.replenish == 'hunger' then
        newHunger = math.min(currentHunger + item.amount, 100)
        if debug then print('| Lusty94_Consumables | New Hunger: ', newHunger) end
    elseif item.replenish == 'thirst' then
        newThirst = math.min(currentThirst + item.amount, 100)
        if debug then print('| Lusty94_Consumables | New Thirst: ', newThirst) end
    end

    if debug then print('| Lusty94_Consumables | Item Replenishment Type: ', item.replenish, ' Has been updated, New Thirst MetaData Values Are: ', newThirst) end
    if debug then print('| Lusty94_Consumables | Item Replenishment Type: ', item.replenish, ' Has been updated, New Hunger MetaData Values Are: ', newHunger) end

    Player.Functions.SetMetaData("hunger", newHunger)
    Player.Functions.SetMetaData("thirst", newThirst)

    if debug then print('| Lusty94_Consumables | MetaData Has Been Updated') end

    TriggerClientEvent('hud:client:UpdateNeeds', src, newHunger, newThirst)
end)



AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then return end
    if debug then
        print('| Lusty94_Consumables | Inventory Type: ', InvType)
        print('| Lusty94_Consumables | Notify Type: ', NotifyType)
        print('| Lusty94_Consumables | Debugging Prints Enabled: ', debug)
        print('| Lusty94_Consumables | Progress Type: ', Config.CoreSettings.Progress.Type)
        print('| Lusty94_Consumables | Visual Effects Enabled: ', Config.CoreSettings.Effects.Enabled)
        print('| Lusty94_Consumables | Visual Effects Timer Length: ', Config.CoreSettings.Effects.Timer / 1000, ' Seconds')
    end
end)


--------------< VERSION CHECK >-------------

local function CheckVersion()
    PerformHttpRequest('https://raw.githubusercontent.com/Lusty94/UpdatedVersions/main/Consumables/version.txt', function(err, newestVersion, headers)
        local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version')
        if not newestVersion then
            print('^1[Lusty94_Consumables]^7: Unable to fetch the latest version.')
            return
        end
        newestVersion = newestVersion:gsub('%s+', '')
        currentVersion = currentVersion and currentVersion:gsub('%s+', '') or "Unknown"
        if newestVersion == currentVersion then
            print(string.format('^2[Lusty94_Consumables]^7: ^6You are running the latest version.^7 (^2v%s^7)', currentVersion))
        else
            print(string.format('^2[Lusty94_Consumables]^7: ^3Your version: ^1v%s^7 | ^2Latest version: ^2v%s^7\n^1Please update to the latest version | Changelogs can be found in the support discord.^7', currentVersion, newestVersion))
        end
    end)
end

CheckVersion()