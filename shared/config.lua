Config = {}


--
--██╗░░░░░██╗░░░██╗░██████╗████████╗██╗░░░██╗░█████╗░░░██╗██╗
--██║░░░░░██║░░░██║██╔════╝╚══██╔══╝╚██╗░██╔╝██╔══██╗░██╔╝██║
--██║░░░░░██║░░░██║╚█████╗░░░░██║░░░░╚████╔╝░╚██████║██╔╝░██║
--██║░░░░░██║░░░██║░╚═══██╗░░░██║░░░░░╚██╔╝░░░╚═══██║███████║
--███████╗╚██████╔╝██████╔╝░░░██║░░░░░░██║░░░░█████╔╝╚════██║
--╚══════╝░╚═════╝░╚═════╝░░░░╚═╝░░░░░░╚═╝░░░░╚════╝░░░░░░╚═╝


--Thank you for downloading this script!

--Below you can change multiple options to suit your server needs.


Config.CoreSettings = {
    Debugging = {
        Enabled = false, -- enables debugging prints throughout the resource
    },
    Notify = {
        Type = 'qb', -- notification type, support for ox_lib notify, qb-core notify, okokNotify, mythic_notify and boii_ui notify
        --use 'ox' for ox_lib notify
        --use 'qb' for default qb-core notify
        --use 'okok' for okokNotify
        --use 'mythic' for myhthic_notify
        --use 'boii' for boii_ui notify
        --use 'custom' for your own notification methods and then edit the SendNotify function in client and server files
    },
    Inventory = { -- Inventory type, support for ox_inventory and qb-inventory
        Type = 'qb',
        --use 'ox' for ox_inventory
        --use 'qb' for qb-inventory
        --use 'custom' for your own inventory system and then edit the event: 'lusty94_consumables:server:UseItem' - you might also need to edit the callback 'lusty94_consumables:server:hasItem'
    },
    Progress = { -- progressbar type, support for ox_lib progressCircle, ox_lib progressBar and qb-progressbar
        Type = 'circle',
        --use 'circle' for progressCircle
        --use 'bar' for progressBar
        --use 'qb' for qb-progressbar
    },
    Effects = {
        Enabled = true, -- enabled visual screen effects for various items usually alcohol or drugs
        Timer = 30000, -- duration for visual effects default is 30 seconds
    },
}

--translation settings for general notifications
Config.Language = {
    Notifications = {
        Busy = 'You are already doing something!',
        Cancelled = 'Action cancelled',       
    },
}


Config.Consumables = {

    ---- <| IMPORTANT NOTES |> ----
    
    --ADD ORE REMVOVE ITEMS BELOW THAT YOU WANT TO BE CONSUMABLE

--['coffee'] = string value - item name - this must be in your items.lua
--replenish = string value - the type of metadata to replenish either thirst or hunger - this updates the players relevant metadata with the amount specified set to nil for nothing [ usually drugs ]
--amount =  number value - amount of replenishment to metadata type
--label = string value - label for progress
--duration = number value- duration of progress event in MS
--canmove = boolean value for preventing movement during consumption - usually false
--cancel = boolean value if the event can be cancelled or not
--requireditem = string value - item required to use specific item, example: a lighter for a joint or meth baggy etc
--stress = number value - amount of stress to reduce - set to 0 for nothing - can also use math.random() to determine random amounts
--health = number value - amount of health to increase - set to 0 for nothing - can also use math.random() to determine random amounts
--armour - number value - amount of armour to add - set to 0 for nothing - can also use math.random() to determine random amounts
--alcohol = number value - alcohol counter amount - example: vodka gives 10 alcohol count when over X amount set alcohol status and give screen effects - can also use math.random() to determine random amounts
--anim = string value - animation name
--dict = string value - animation dictionary name
--flag = number value - animation flag
--prop - string value - prop for animation - set to nil for no prop
--bone - player bone index for prop - if prop is set to nil this can be ignored
--pos = vec3 value for prop position - if prop is set to nil this can be ignored 
--rot = vec3 value for prop rotation - if prop is set to nil this can be ignored
--drugeffect = boolean value for screen effects to simulate drug taking
--drugtype = string value - determines the type of effect - 'weed' or 'coke' or 'crack' or 'meth' - these are screen effects available - coke, crack and meth increase the players sprint speed for a short period of time


    ['coffee'] = { 
        replenish = 'thirst', 
        amount = 10,
        label = 'Drinking coffee',
        duration = 5000,
        canmove = true,
        cancel = true,
        requireditem = nil,
        stress = 10,
        health = 0,
        armour = 0,
        alcohol = 0,
        dict = 'amb@world_human_drinking@coffee@male@idle_a',
        anim = 'idle_c',
        flag = 49,
        prop = 'p_ing_coffeecup_02',
        bone = 28422,
        pos = vec3(0.0,0.0,0.0),
        rot = vec3(0.0,0.0,0.0),
        drugeffect = false,
        drugtype = nil,
    },
    ['chocolatedoughnut'] = { 
        replenish = 'hunger', 
        amount = 10,
        label = 'Eating chocolate doughnut',
        duration = 5000,
        canmove = true,
        cancel = true,
        requireditem = nil,
        stress = 10,
        health = 10,
        armour = 0,
        alcohol = 0,
        dict = 'mp_player_inteat@burger',
        anim = 'mp_player_int_eat_burger',
        flag = 49,
        prop = 'prop_donut_02',
        bone = 60309,
        pos = vec3(0.00, -0.03, -0.01),
        rot = vec3(10.0, 0.0, -1.0),
        drugeffect = false,
        drugtype = nil,
    },
    ['beer'] = { 
        replenish = 'thirst', 
        amount = 10,
        label = 'Drinking beer',
        duration = 5000,
        canmove = true,
        cancel = true,
        requireditem = nil,
        stress = 0,
        health = 0,
        armour = 0,
        alcohol = 2,
        dict = 'amb@world_human_drinking@beer@male@idle_a',
        anim = 'idle_c',
        flag = 49,
        prop = 'prop_amb_beer_bottle',
        bone = 28422,
        pos = vec3(0.0, 0.0, 0.06),
        rot = vec3(0.0, 15.0, 0.0),
        drugeffect = false,
        drugtype = nil,
    },
    ['vodka'] = { 
        replenish = 'thirst', 
        amount = 10,
        label = 'Drinking vodka',
        duration = 5000,
        canmove = true,
        cancel = true,
        requireditem = nil,
        stress = 0,
        health = 0,
        armour = 0,
        alcohol = 5,
        dict = 'mp_player_intdrink',
        anim = 'loop_bottle',
        flag = 49,
        prop = 'prop_vodka_bottle',
        bone = 18905,
        pos = vec3(0.00, -0.26, 0.10),
        rot = vec3(240.0, -60.0, 0.0),
        drugeffect = false,
        drugtype = nil,
    },
    ['whiskey'] = { 
        replenish = 'thirst', 
        amount = 10,
        label = 'Drinking whiskey',
        duration = 5000,
        canmove = true,
        cancel = true,
        requireditem = nil,
        stress = 0,
        health = 0,
        armour = 0,
        alcohol = 5,
        dict = 'mp_player_intdrink',
        anim = 'loop_bottle',
        flag = 49,
        prop = 'prop_whiskey_bottle',
        bone = 18905,
        pos = vec3(0.00, -0.22, 0.10),
        rot = vec3(240.0, -60.0, 0.0),
        drugeffect = false,
        drugtype = nil,
    },
    ['weed_joint'] = { 
        replenish = nil, 
        amount = 10,
        label = 'Smoking joint',
        duration = 10000,
        canmove = true,
        cancel = true,
        requireditem = 'lighter',
        stress = 10,
        health = 0,
        armour = 10,
        alcohol = 0,
        dict = 'amb@world_human_aa_smoke@male@idle_a',
        anim = 'idle_c',
        flag = 49,
        prop = 'prop_sh_joint_01',
        bone = 28422,
        pos = vec3(0.0,0.0,0.0),
        rot = vec3(0.0,0.0,0.0),
        drugeffect = true,
        drugtype = 'weed',
    },
    ['coke_baggy'] = { 
        replenish = nil, 
        amount = 10,
        label = 'Snorting coke',
        duration = 10000,
        canmove = true,
        cancel = true,
        requireditem = nil,
        stress = 10,
        health = 0,
        armour = 25,
        alcohol = 0,
        dict = 'switch@trevor@trev_smoking_meth',
        anim = 'trev_smoking_meth_loop',
        flag = 49,
        prop = nil,
        bone = 60309,
        pos = vec3(0.0,0.0,0.0),
        rot = vec3(0.0,0.0,0.0),
        drugeffect = true,
        drugtype = 'coke',
    },
    ['meth_baggy'] = { 
        replenish = nil, 
        amount = 0,
        label = 'Smoking meth',
        duration = 10000,
        canmove = true,
        cancel = true,
        requireditem = 'lighter',
        stress = 10,
        health = 0,
        armour = 20,
        alcohol = 0,
        dict = 'switch@trevor@trev_smoking_meth',
        anim = 'trev_smoking_meth_loop',
        flag = 49,
        prop = 'prop_cs_meth_pipe',
        bone = 57005,
        pos = vec3(0.13, 0.0, -0.01),
        rot = vec3(-0.07, -3.36, 0.47),
        drugeffect = true,
        drugtype = 'crack',
    },
    ['oxy'] = { 
        replenish = nil, 
        amount = 0,
        label = 'Taking oxy',
        duration = 5000,
        canmove = true,
        cancel = true,
        requireditem = nil,
        stress = 25,
        health = 25,
        armour = 25,
        alcohol = 0,
        dict = 'mp_player_intdrink',
        anim = 'loop_bottle',
        flag = 49,
        prop = 'prop_cs_pills',
        bone = 18905,
        pos = vec3(0.13, 0.03, 0.0),
        rot = vec3(80.0, 398.0, 167.0),
        drugeffect = false,
        drugtype = nil,
    },

}