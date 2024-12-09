-- This file has some stuff for compatibility with Any Planet Start mod, starting on Fulgora.

local Util = require("code.util")

if mods["any-planet-start"] ~= nil and settings.startup["aps-planet"].value == "fulgora" then
	-- We want to avoid softlocking in the case of using Any Planet Start mod and starting on Fulgora.
	-- One issue: lightning rod needs stone bricks, which needs solid fuel. Or you could recycle concrete, but that needs power, so needs lightning rods.
	-- Well, you can get some stone bricks from mining lightning rods - each mined rod gives 2, new rods cost 4. But that's still tedious.
	-- You also need fuel for burner miners and furnaces. So, changing scrap recycling recipe to give solid fuel too.
	table.insert(data.raw.recipe["scrap-recycling"].results,
		{ type = "item",  name = "solid-fuel",  amount = 1, probability = 0.04, show_details_in_recipe_tooltip = false })
	--Util.substituteIngredient("lightning-rod", "stone-brick", "concrete")

	-- If Any Planet Start mod is installed, sludge filtration isn't usable until you have "oil-gathering" technology for offshore pump.
	-- And you don't have water, so for blue science you need some other recipe for sulfur. And for military, some other recipe for coal.
	-- So, let's move sludge filtration to oil-gathering, and add sulfur and coal to sludge processing results.
	Util.addRecipeToTech("fulgoran-sludge-filtration", "oil-gathering")
	Util.removeRecipeFromTech("fulgoran-sludge-filtration", "recycling")
	table.insert(data.raw.recipe["fulgoran-sludge-filtration"].results,
		{ type = "item",  name = "sulfur",  amount = 1, probability = 0.04, show_details_in_recipe_tooltip = false })
	table.insert(data.raw.recipe["fulgoran-sludge-filtration"].results,
		{ type = "item",  name = "coal",  amount = 1, probability = 0.03, show_details_in_recipe_tooltip = false })
end