local QBCore = exports['qb-core']:GetCoreObject()
local ProgType = Config.CoreSettings.Progress.Type
local NotifyType = Config.CoreSettings.Notify.Type
local InvType = Config.CoreSettings.Inventory.Type
local debug = Config.CoreSettings.Debugging.Enabled
local EffectsEnabled = Config.CoreSettings.Effects.Enabled
local EffectsTimer = Config.CoreSettings.Effects.Timer
local busy = false
local alcoholCount = 0

--notification function
local function SendNotify(msg,type,time,title)
    if NotifyType == nil then print("Lusty94_Consumables: NotifyType Not Set in Config.CoreSettings.Notify.Type!") return end
    if not title then title = "Consumables" end
    if not time then time = 5000 end
    if not type then type = 'success' end
    if not msg then print("Notification Sent With No Message.") return end
    if NotifyType == 'qb' then
        QBCore.Functions.Notify(msg,type,time)
    elseif NotifyType == 'okok' then
        exports['okokNotify']:Alert(title, msg, time, type, true)
    elseif NotifyType == 'mythic' then
        exports['mythic_notify']:DoHudText(type, msg)
    elseif NotifyType == 'boii' then
        exports['boii_ui']:notify(title, msg, type, time)
    elseif NotifyType == 'ox' then
        lib.notify({ title = title, description = msg, type = type, duration = time})
    elseif NotifyType == 'custom' then
        --insert your own notify functions here
    end
end

--drink alcohol effect
function alcoholEffect()
    local playerPed = PlayerPedId()
    if alcoholCount >= 10 and alcoholCount <= 19 then -- tipsy
        Wait(1000)
        SetTimecycleModifier('spectator5')
        Wait(1000)
        SetPedMotionBlur(playerPed, true)
        Wait(1000)
        SetPedMovementClipset(playerPed, 'MOVE_M@DRUNK@SLIGHTLYDRUNK', true)
        SetPedIsDrunk(playerPed, true)
        if IsPedRunning(playerPed) then
            SetPedToRagdoll(playerPed, 2000, 6000, 3, 0, 0, 0)
        end
        Wait(EffectsTimer)
        ClearTimecycleModifier()
        ResetScenarioTypesEnabled()
        ResetPedMovementClipset(playerPed, 0)
        SetPedIsDrunk(playerPed, false)
        SetPedMotionBlur(playerPed, false)
    elseif alcoholCount >= 20 then -- pissed
        Wait(1000)
        SetTimecycleModifier('spectator5')
        Wait(1000)
        SetPedMotionBlur(playerPed, true)           
        Wait(1000)
        ShakeGameplayCam('LARGE_EXPLOSION_SHAKE', 1.00)
        Wait(1000)
        ShakeGameplayCam('DRUNK_SHAKE', 1.10)
        Wait(1000)
        if IsPedRunning(playerPed) then
            SetPedToRagdoll(playerPed, 2000, 6000, 3, 0, 0, 0)
        end
        SetFlash(0, 0, 500, 7000, 500)
        ShakeGameplayCam('LARGE_EXPLOSION_SHAKE', 1.00)
        Wait(1000)      
        SetFlash(0, 0, 500, 7000, 500)
        ShakeGameplayCam('LARGE_EXPLOSION_SHAKE', 1.00)
        Wait(1000)      
        SetFlash(0, 0, 500, 7000, 500)
        ShakeGameplayCam('LARGE_EXPLOSION_SHAKE', 1.00)
        Wait(1000)      
        SetFlash(0, 0, 500, 7000, 500)
        ShakeGameplayCam('LARGE_EXPLOSION_SHAKE', 1.00)
        Wait(1000)      
        SetFlash(0, 0, 500, 7000, 500)
        ShakeGameplayCam('LARGE_EXPLOSION_SHAKE', 1.00)
        Wait(1000)
        ShakeGameplayCam('DRUNK_SHAKE', 1.10)
        Wait(EffectsTimer)
        ClearTimecycleModifier()
        ResetScenarioTypesEnabled()
        StopGameplayCamShaking(playerPed, true)
        SetPedIsDrunk(playerPed, false)
        SetPedMotionBlur(playerPed, false)
        ClearPedTasks(playerPed)
    end
end

--consuming item and provide player buffs and screen effects
function consumeItem(itemName)
    local playerPed = PlayerPedId()
    local item = Config.Consumables[itemName]
    TriggerServerEvent('lusty94_consumables:server:UseItem', itemName)
    TriggerServerEvent('lusty94_consumables:server:UpdateNeeds', itemName)
    Wait(2000) -- wait timer just to stop the rats that try spam items or remove them from inventory before declaring busy as false and unlocking inventory again
    busy = false
    LockInventory(false)
    if item.health > 0 then
        SetEntityHealth(playerPed, GetEntityHealth(playerPed) + item.health)
        if debug then print('| Lusty94_Consumables | Increasing Health Levels Using: : ', itemName, 'Amount Increased By: ', item.stress) end
    end
    if item.armour > 0 then
        SetPedArmour(playerPed, GetPedArmour(playerPed) + item.armour)
        if debug then print('| Lusty94_Consumables | Increasing Armour Levels Using: : ', itemName, 'Amount Increased By: ', item.stress) end
    end
    if item.stress > 0 then
        TriggerServerEvent('hud:server:RelieveStress', item.stress)
        if debug then print('| Lusty94_Consumables | Reducing Stress Levels Using: : ', itemName, 'Amount Reduced By: ', item.stress) end
    end
    if item.alcohol > 0 then
        if debug then print('| Lusty94_Consumables | Alcohol Count Increased From: ', itemName, 'Amount Increased By: ', item.alcohol, 'Current Alcohol Count: ', alcoholCount) end
        alcoholCount = alcoholCount + item.alcohol
        alcoholEffect(alcoholCount)
    end
    if EffectsEnabled then
        if item.drugeffect and item.drugtype ~= nil then
            ShakeGameplayCam('LARGE_EXPLOSION_SHAKE', 1.00)
            Wait(1000)
            if item.drugtype == 'weed' then
                StartScreenEffect('DrugsMichaelAliensFight', 0, true)
            elseif item.drugtype == 'coke' then
                StartScreenEffect('DrugsTrevorClownsFight', 0, true)
                SetRunSprintMultiplierForPlayer(playerPed, 1.48)          
            elseif item.drugtype == 'crack' then
                StartScreenEffect('Rampage', 0, true)             
                SetRunSprintMultiplierForPlayer(playerPed, 1.48)
                ShakeGameplayCam('LARGE_EXPLOSION_SHAKE', 1.10)          
            elseif item.drugtype == 'meth' then
                StartScreenEffect('Dont_tazeme_bro', 0, true)       
                SetRunSprintMultiplierForPlayer(playerPed, 1.48)
                ShakeGameplayCam('LARGE_EXPLOSION_SHAKE', 1.10)          
            end
            Wait(EffectsTimer)
            if item.drugtype == 'coke' or item.drugtype == 'crack' or item.drugtype == 'meth' then
                SetRunSprintMultiplierForPlayer(playerPed, 1.0)
            end
            StopGameplayCamShaking(playerPed, true)
            StopAllScreenEffects()
        end
    end
end

RegisterNetEvent('lusty94_consumables:client:UseItem', function(itemName)
    local item = Config.Consumables[itemName]    
    if not item then return end
    if busy then
        SendNotify(Config.Language.Notifications.Busy, 'error', 2500)
    else
        QBCore.Functions.TriggerCallback('lusty94_consumables:server:hasItem', function(hasItem)
            if hasItem then
                busy = true
                LockInventory(true)
                if ProgType == 'circle' then
                    if lib.progressCircle({
                        duration = item.duration,
                        label = item.label,
                        position = 'bottom',
                        canCancel = item.cancel,
                        disable = {
                            move = not item.canmove,
                            car = true,
                            combat = true,
                        },
                        anim = {
                            dict = item.dict,
                            clip = item.anim,
                            flag = item.flag,
                        },
                        prop = {
                        
                            model = item.prop,
                            bone = item.bone,
                            pos = item.pos,
                            rot = item.rot,
                            
                        },
                    }) 
                    then
                        consumeItem(itemName)
                    else
                        busy = false
                        LockInventory(false)
                        SendNotify(Config.Language.Notifications.Cancelled, 'error', 2500)
                    end
                elseif ProgType == 'bar' then
                    if lib.progressBar({
                        duration = item.duration,
                        label = item.label,
                        useWhileDead = false,
                        canCancel = item.cancel,
                        disable = {
                            move = not item.canmove,
                            car = true,
                            combat = true,
                        },
                        anim = {
                            dict = item.dict,
                            clip = item.anim,
                            flag = item.flag,
                        },
                        prop = {
                        
                            model = item.prop,
                            bone = item.bone,
                            pos = item.pos,
                            rot = item.rot,
                            
                        },
                    }) 
                    then
                        consumeItem(itemName)
                    else
                        busy = false
                        LockInventory(false)
                        SendNotify(Config.Language.Notifications.Cancelled, 'error', 2500)
                    end
                elseif ProgType == 'qb' then
                    exports['progressbar']:Progress({
                        name = "consuming",
                        duration = item.duration,
                        label = item.label,
                        useWhileDead = false,
                        canCancel = item.cancel,
                        controlDisables = {
                            disableMovement = not item.canmove,
                            disableCarMovement = false,
                            disableMouse = false,
                            disableCombat = true,
                        },
                        animation = {
                            animDict = item.dict,
                            anim = item.anim,
                            flags = item.flag,
                        },
                        prop = {
                            model = item.prop,
                            bone = item.bone,
                            coords = item.pos,
                            rotation = item.rot,
                        },
                        }, function(cancelled)
                        if not cancelled then
                            consumeItem(itemName)
                        else
                            busy = false
                            LockInventory(false)
                            SendNotify(Config.Language.Notifications.Cancelled, 'error', 2500)
                        end
                    end)
                end
            end
        end, itemName) -- Pass the itemName to the callback
    end
end)


-- function to lock inventory to prevent exploits
function LockInventory(toggle) -- big up to jim for how to do this
	if toggle then
        LocalPlayer.state:set("inv_busy", true, true) -- used by qb, ps and ox
        --this is the old method below
        --[[         
        if InvType == 'qb' then
            this is for the old method if using old qb and ox
            TriggerEvent('inventory:client:busy:status', true) TriggerEvent('canUseInventoryAndHotbar:toggle', false)
        elseif InvType == 'ox' then
            LocalPlayer.state:set("inv_busy", true, true)
        end         
        ]]
    else 
        LocalPlayer.state:set("inv_busy", false, true) -- used by qb, ps and ox
        --this is the old method below
        --[[        
        if InvType == 'qb' then
            this is for the old method if using old qb and ox
         TriggerEvent('inventory:client:busy:status', false) TriggerEvent('canUseInventoryAndHotbar:toggle', true)
        elseif InvType == 'ox' then
            LocalPlayer.state:set("inv_busy", false, true)
        end        
        ]]
    end
end



AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    ClearPedTasks(PlayerPedId())
    StopAllScreenEffects()
    if DoesEntityExist(currentProp) then DeleteEntity(currentProp) end
    busy = false
    LockInventory(false)
    print('^5--<^3!^5>-- ^7| Lusty94 |^5 ^5--<^3!^5>--^7 Consumables V1.0.1 Stopped Successfully ^5--<^3!^5>--^7')
end)
