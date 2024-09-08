## Lusty94_Consumables


<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

PLEASE MAKE SURE TO READ THIS ENTIRE FILE AS IT COVERS SOME IMPORTANT INFORMATION

<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>




======================================
SCRIPT SUPPORT VIA DISCORD: https://discord.gg/BJGFrThmA8
======================================



## Features

- Consumables system with ability to add custom animations, props and toggleable effects for different items
- Toggleable required items
- Toggleable screen visual effects
- Toggleable buffs for each item - for example: ``drugs that give you health, amrour and stress relief``
- 10 Preset items ``Coffee, Chocolate Doughnut, Beer, Whiskey, Vodka, Joint, Coke, Crack, Meth & Oxy``
- Easily change animations for each item
- Easily add more items with custom animations, props and effects
- Language section for custom translations




## SUPPORT SCRIPTS
- Below is a list of resources that are supported by default in this resource

``Notify``
- qb-core notify
- okokNotify
- mythic_notify
- boii_ui notify
- ox_lib notify


``Inventory``
- qb-inventory
- ox_inventory

``Progress``
- ox_lib progressBar
- ox_lib progressCirlce
- qb-progressBar



## DEPENDENCIES

- [qb-core](https://github.com/qbcore-framework/qb-core)
- [qb-inventory](https://github.com/qbcore-framework/qb-inventory) or [ox_inventory](https://github.com/overextended/ox_inventory/releases)
- [ox_lib](https://github.com/overextended/ox_lib/releases/) or [qb-progressbar](https://github.com/qbcore-framework/progressbar)





## INSTALLATION

- Add the relevant items snippet below into your core/shared/items.lua file - ox_inventory users place items inside inventory/data/items.lua
- Add all .png images inside [IMAGES] folder into your inventory/html/images folder - ox_inventory users place images inside inventory/web/images


# QB-CORE ITEMS

```

    coffee 			        = {name = 'coffee', 			  label = 'Coffee', 		     weight = 200, 		  type = 'item', 		 image = 'coffee.png', 				    unique = false, 	useable = true, 	shouldClose = true,      combinable = nil,   description = ''},
    chocolatedoughnut 		= {name = 'chocolatedoughnut', 	  label = 'Chocolate Doughnut',  weight = 200, 		  type = 'item', 		 image = 'chocolatedoughnut.png', 		unique = false, 	useable = true, 	shouldClose = true,      combinable = nil,   description = ''},
    beer 				 	= {name = 'beer', 			  	  label = 'Beer', 				 weight = 200, 		  type = 'item', 		 image = 'beer.png', 					unique = false, 	useable = true, 	shouldClose = true,	     combinable = nil,   description = ''},
    vodka 				 	= {name = 'vodka', 			  	  label = 'Vodka', 				 weight = 200, 		  type = 'item', 		 image = 'vodka.png', 					unique = false, 	useable = true, 	shouldClose = true,	     combinable = nil,   description = ''},
    whiskey 				= {name = 'whiskey', 			  label = 'Whiskey', 		     weight = 200, 		  type = 'item', 		 image = 'whiskey.png', 			    unique = false, 	useable = true, 	shouldClose = true,	     combinable = nil,   description = ''},
    weed_joint              = {name = 'weed_joint',           label = 'Weed Joint',          weight = 1000,       type = 'item',         image = 'weed_joint.png',              unique = false,     useable = true,     shouldClose = true,      combinable = nil,   description = ''},
    coke_baggy              = {name = 'coke_baggy',           label = 'Bag of Cocaine',      weight = 100,        type = 'item',         image = 'coke_baggy.png',              unique = false,     useable = true,     shouldClose = true,      combinable = nil,   description = ''},
    crack_baggy             = {name = 'crack_baggy',          label = 'Bag of Crack',        weight = 100,        type = 'item',         image = 'crack_baggy.png',             unique = false,     useable = true,     shouldClose = true,      combinable = nil,   description = ''},
    meth_baggy              = {name = 'meth_baggy',           label = 'Bag of Meth',         weight = 100,        type = 'item',         image = 'meth_baggy.png',              unique = false,     useable = true,     shouldClose = true,      combinable = nil,   description = ''},
    oxy                     = {name = 'oxy',                  label = 'Oxy',                 weight = 100,        type = 'item',         image = 'oxy.png',                     unique = false,     useable = true,     shouldClose = true,      combinable = nil,   description = ''},
    lighter                 = {name = 'lighter',              label = 'Lighter',             weight = 100,        type = 'item',         image = 'lighter.png',                 unique = false,     useable = true,     shouldClose = true,      combinable = nil,   description = ''},


```


# OX_INVENTORY ITEMS

```

    ["beer"] = {
		label = "Beer",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "beer.png",
		}
	},

    ["vodka"] = {
		label = "Vodka",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "vodka.png",
		}
	},

    ["whiskey"] = {
		label = "Whiskey",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "whiskey.png",
		}
	},

	["chocolatedoughnut"] = {
		label = "Chocolate Doughnut",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "chocolatedoughnut.png",
		}
	},

	["meth_baggy"] = {
		label = "Bag of Meth",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "meth_baggy.png",
		}
	},

	["coffee"] = {
		label = "Coffee",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "coffee.png",
		}
	},

	["lighter"] = {
		label = "Lighter",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "lighter.png",
		}
	},

	["weed_joint"] = {
		label = "Weed Joint",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "weed_joint.png",
		}
	},

	["coke_baggy"] = {
		label = "Bag of Cocaine",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "coke_baggy.png",
		}
	},

	["crack_baggy"] = {
		label = "Bag of Crack",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "crack_baggy.png",
		}
	},

	["oxy"] = {
		label = "Oxy",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "oxy.png",
		}
	},	

```