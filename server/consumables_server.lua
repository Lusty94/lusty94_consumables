-- Server-side consumables script
local QBCore = exports['qb-core']:GetCoreObject()
local InvType = Config.CoreSettings.Inventory.Type
local NotifyType = Config.CoreSettings.Notify.Type
local debug = Config.CoreSettings.Debugging.Enabled

--notification function
local function SendNotify(src, msg, type, time, title)
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

for itemName, _ in pairs(Config.Consumables) do
    QBCore.Functions.CreateUseableItem(itemName, function(source, item)
        if debug then print('| Lusty94_Consumables | Server ID: ', source, 'is using: ', itemName) end
        TriggerClientEvent('lusty94_consumables:client:UseItem', source, item.name)
    end)
end

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
        if InvType == 'qb' then
            if exports['qb-inventory']:RemoveItem(src, itemName, 1, nil, nil, nil) then
                TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[itemName], "remove")
            end
            if debug then print('| Lusty94_Consumables | Item Removed: ', itemName) end
        elseif InvType == 'ox' then
            if exports.ox_inventory:RemoveItem(src, itemName, 1) then
            end
            if debug then print('| Lusty94_Consumables | Item Removed: ', itemName) end
        elseif InvType == 'custom' then
            --insert your own inventory methods for item removal here
            if debug then print('| Lusty94_Consumables | Item Removed: ', itemName) end
        end
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

    if debug then print('| Lusty94_Consumables | Item Replenishment Type: ', item.replenish, ' Has been updated, New MetaData Values Are: ', newThirst) end

    Player.Functions.SetMetaData("hunger", newHunger)
    Player.Functions.SetMetaData("thirst", newThirst)

    if debug then print('| Lusty94_Consumables | MetaData Has Been Updated') end

    TriggerClientEvent('hud:client:UpdateNeeds', src, newHunger, newThirst)
end)



AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    if debug then
        print('| Lusty94_Consumables | Inventory Type: ', InvType)
        print('| Lusty94_Consumables | Notify Type: ', NotifyType)
        print('| Lusty94_Consumables | Debugging Prints Enabled: ', debug)
        print('| Lusty94_Consumables | Progress Type: ', Config.CoreSettings.Progress.Type)
        print('| Lusty94_Consumables | Visual Effects Enabled: ', Config.CoreSettings.Effects.Enabled)
        print('| Lusty94_Consumables | Visual Effects Timer Length: ', Config.CoreSettings.Effects.Timer / 1000, ' Seconds')
    end
end)


local function CheckVersion()
	PerformHttpRequest('https://raw.githubusercontent.com/Lusty94/UpdatedVersions/main/Consumables/version.txt', function(err, newestVersion, headers)
		local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version')
		if not newestVersion then print("Currently unable to run a version check.") return end
		local advice = "^1You are currently running an outdated version^7, ^1please update^7"
		if newestVersion:gsub("%s+", "") == currentVersion:gsub("%s+", "") then advice = '^6You are running the latest version.^7'
		else print("^3Version Check^7: ^5Current^7: "..currentVersion.." ^5Latest^7: "..newestVersion.." "..advice) end
	end)
end
CheckVersion()