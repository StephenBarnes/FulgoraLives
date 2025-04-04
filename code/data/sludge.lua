--[[ This file creates the sludge fluid and recipe to separate it.
Some code taken from Fulgoran Sludge mod by Tatticky.
Icon taken from Unused Renders by Malcolm Riley.

Since I'm making water scarce, heavy oil can't be cracked (that requires water). But you need light oil for rocket fuel. So I'm also making sludge filtration produce both heavy and light oil.
I'm also adding the Ocean Dumping mod which lets you dump anything you don't want into the sea. So eg to get rid of excess heavy/light oil you can just turn it into solid fuel and dump it into the sea.
]]

local Util = require("code.util")

local ironStick = Util.firstExisting({"rocs-rusting-iron-iron-stick-rusty", "iron-stick-rusty", "iron-stick"}, data.raw.item)
local ironGear = Util.firstExisting({"rocs-rusting-iron-iron-gear-wheel-rusty", "iron-gear-wheel-rusty", "iron-gear-wheel"}, data.raw.item)

-- Create sludge fluid, and a recipe to separate it.
data:extend({
	{
		type = "fluid",
		name = "fulgoran-sludge",
		icon = "__FulgoraLives__/graphics/from_malcolmriley/sludge.png",
		icon_size = 128,
		mipmap_count = 4,
		base_color = { r = 0.24, g = 0.16, b = 0.16 },
		flow_color = { r = 0.08, g = 0.08, b = 0.08 },
		default_temperature = 5,
		auto_barrel = false,
		subgroup = "fluid",
		order = "b[new-fluid]-c[fulgora]-aa[sludge]",
	},
	{
		type = "recipe",
		name = "fulgoran-sludge-filtration",
		category = "chemistry",
		icons = {
			{
				icon = "__FulgoraLives__/graphics/from_malcolmriley/sludge.png",
				icon_size = 128,
				scale = 0.18,
				shift = { 0, -4.8 }
			},
			{
				icon = "__base__/graphics/icons/fluid/heavy-oil.png",
				scale = 0.25,
				shift = { -9, 6 }
			},
			{
				icon = "__base__/graphics/icons/fluid/light-oil.png",
				scale = 0.25,
				shift = { 9, 6 }
			},
			{
				icon = "__space-age__/graphics/icons/scrap-4.png",
				scale = 0.2,
				shift = { 0, 9 }
			},
		},
		enabled = false,
		energy_required = 4,
		ingredients = {
			{ type = "fluid", name = "fulgoran-sludge", amount = 100, fluidbox_multiplier = 10 }
		},
		results = {
			{ type = "fluid", name = "heavy-oil", amount = 60 },
			{ type = "fluid", name = "light-oil", amount = 20 },
			{ type = "item",  name = "stone",  amount = 1, probability = 0.02, show_details_in_recipe_tooltip = false },
			{ type = "item",  name = ironGear,  amount = 1, probability = 0.02, show_details_in_recipe_tooltip = false },
			{ type = "item",  name = ironStick,  amount = 1, probability = 0.02, show_details_in_recipe_tooltip = false },
			--{ type = "item",  name = "steel-plate",  amount = 1, probability = 0.01, show_details_in_recipe_tooltip = false },
			--{ type = "item",  name = "stone-brick",  amount = 1, probability = 0.01, show_details_in_recipe_tooltip = false },
			--{ type = "item",  name = "battery",  amount = 1, probability = 0.01, show_details_in_recipe_tooltip = false },
			{ type = "item",  name = "copper-cable",  amount = 1, probability = 0.03, show_details_in_recipe_tooltip = false },
			{ type = "item",  name = "holmium-ore",  amount = 1, probability = 0.005, show_details_in_recipe_tooltip = false },
			{ type = "item",  name = "plastic-bar",  amount = 1, probability = 0.01, show_details_in_recipe_tooltip = false },
		},
		main_product = "heavy-oil",
		allow_as_intermediate = false,
		subgroup = "fulgora-processes",
		order = "b[holmium]-a[fulgoran-sludge-filtration]", -- Before the recipe for holmium solution.
		allow_productivity = true,
		maximum_productivity = 3,
		---@diagnostic disable-next-line: assign-type-mismatch
		auto_recycle = false,
		crafting_machine_tint = {
			primary = { r = 0.5, g = 0.4, b = 0.25, a = 1.000 },
			secondary = { r = 0, g = 0, b = 0, a = 1.000 },
			tertiary = { r = 0.75, g = 0.5, b = 0.5 },
			quaternary = { r = 0.24, g = 0.16, b = 0.16 }
		}
	}
})
Util.addRecipeToTech("fulgoran-sludge-filtration", "recycling")
data.raw["tile"]["oil-ocean-shallow"].fluid = "fulgoran-sludge"
data.raw["tile"]["oil-ocean-deep"].fluid = "fulgoran-sludge"