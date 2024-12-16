-- Change battery charger/discharger energies back, if another mod has changed them.
-- data.raw.furnace["battery-charger"].energy_usage = "1MW"
-- data.raw["burner-generator"]["battery-discharger"].max_power_output = "2MW"

-- Look through recipes and check if they use accumulators - if so, replace with charged batteries.
local Util = require("code.util")
if settings.startup["FulgoraLives-remove-accumulators"].value then
	for _, recipe in pairs(data.raw.recipe) do
		if recipe.name ~= "accumulator-recycling" then
			Util.substituteIngredient(recipe.name, "accumulator", "charged-battery", nil, false)
		end
	end
	Util.hideRecipe("accumulator-recycling")
end

-- Change charged battery recycling recipes to just discharge the batteries.
if data.raw.recipe["charged-battery-recycling"] then
	data.raw.recipe["charged-battery-recycling"].results = {{type = "item", name = "battery", amount = 1}}
end
if data.raw.recipe["charged-holmium-battery-recycling"] then
	data.raw.recipe["charged-holmium-battery-recycling"].results = {{type = "item", name = "holmium-battery", amount = 1}}
end
