-- Change battery charger energy usage back, if another mod (eg PowerMultiplier) has increased it.
data.raw.furnace["battery-charger"].energy_usage = "5MW"

-- Look through recipes and check if they use accumulators - if so, replace with charged batteries.
local Util = require("code.util")
for _, recipe in pairs(data.raw.recipe) do
	if recipe.name ~= "accumulator-recycling" then
		Util.substituteIngredient(recipe.name, "accumulator", "charged-battery", nil, false)
	end
end
Util.hideRecipe("accumulator-recycling")