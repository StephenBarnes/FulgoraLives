local Util = require("code.util")

local ironStick = Util.firstExisting({"rocs-rusting-iron-iron-stick-rusty", "iron-stick-rusty", "iron-stick"}, data.raw.item)
local ironGear = Util.firstExisting({"rocs-rusting-iron-iron-gear-wheel-rusty", "iron-gear-wheel-rusty", "iron-gear-wheel"}, data.raw.item)

-- Change scrap recycling outputs.
local scrapRecyclingRecipe = data.raw.recipe["scrap-recycling"]
scrapRecyclingRecipe.results = {
	{ type = "item", name = "processing-unit",       amount = 1, probability = 0.02, show_details_in_recipe_tooltip = false },
	{ type = "item", name = "advanced-circuit",      amount = 1, probability = 0.03, show_details_in_recipe_tooltip = false },
	{ type = "item", name = "low-density-structure", amount = 1, probability = 0.01, show_details_in_recipe_tooltip = false },
	--{ type = "item", name = "solid-fuel",            amount = 1, probability = 0.01, show_details_in_recipe_tooltip = false },
		-- Changed 0.07 -> 0.01. Actually rather removing this bc you can make it from sludge easily and it's not useful for power gen any more.
	{ type = "item", name = "steel-plate",           amount = 1, probability = 0.04, show_details_in_recipe_tooltip = false },
	{ type = "item", name = "concrete",              amount = 1, probability = 0.03, show_details_in_recipe_tooltip = false },
	{ type = "item", name = "refined-concrete",      amount = 1, probability = 0.03, show_details_in_recipe_tooltip = false },
	--{ type = "item", name = "stone-brick",           amount = 1, probability = 0.02, show_details_in_recipe_tooltip = false },
		-- Added. Then removed bc rather just do concrete.
	{ type = "item", name = "battery",               amount = 1, probability = 0.08, show_details_in_recipe_tooltip = false },
		-- Increased 0.04 -> 0.08, since it's now also used for power and sulfuric acid (for holmium solution).
	{ type = "item", name = "holmium-battery",               amount = 1, probability = 0.0005, show_details_in_recipe_tooltip = false },
		-- Added - basically a rare lucky drop.
	--{ type = "item", name = "ice",                   amount = 1, probability = 0.05, show_details_in_recipe_tooltip = false },
		-- Removed this. I'm making water scarce, and adding ways to get light oil (for rocket fuel) and holmium solution without water.
	{ type = "item", name = "stone",                 amount = 1, probability = 0.04, show_details_in_recipe_tooltip = false },
	{ type = "item", name = "holmium-ore",           amount = 1, probability = 0.005, show_details_in_recipe_tooltip = false },
		-- Reduced 0.01 -> 0.003, bc I'm adding it as product of sludge filtration, and adding holmium farming. Also adding fulgorite shards as product.
	-- Rather don't produce fulgorite shards - should need to grow them to continue everything.
	{ type = "item", name = ironGear,       amount = 1, probability = 0.08, show_details_in_recipe_tooltip = false },
		-- Changed to rusty variant, and reduced 0.20 -> 0.08.
	{ type = "item", name = ironStick,       amount = 1, probability = 0.08, show_details_in_recipe_tooltip = false },
		-- Added.
	{ type = "item", name = "copper-cable",          amount = 1, probability = 0.03, show_details_in_recipe_tooltip = false },
	{ type = "item", name = "plastic-bar",          amount = 1, probability = 0.02, show_details_in_recipe_tooltip = false },
		-- Added.
}

-- Enlarge result inventory of recycler if needed.
local recycler = data.raw.furnace.recycler
if recycler.result_inventory_size < #scrapRecyclingRecipe.results then
	recycler.result_inventory_size = #scrapRecyclingRecipe.results
end

-- Change holmium solution recipe to not require water, since I'm making that scarce.
-- (In batteries file, I'm adding a recipe to get sulfuric acid from batteries, so sulfuric acid is available on Fulgora.)
Util.substituteIngredient("holmium-solution", "water", "sulfuric-acid")

-- Increase power consumption of EM plants and recyclers.
if settings.startup["FulgoraLives-increase-power-consumption"].value then
	data.raw["assembling-machine"]["electromagnetic-plant"].energy_usage = "4MW" -- Doubling 2MW -> 4MW.
	data.raw["furnace"]["recycler"].energy_usage = "400kW" -- Increasing 180kW -> 400kW.
end