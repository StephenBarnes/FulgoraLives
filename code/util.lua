local Export = {}

Export.ifThenElse = function(condition, thenValue, elseValue)
	if condition then
		return thenValue
	else
		return elseValue
	end
end

Export.substituteIngredient = function(recipeName, ingredientName, newIngredientName, newAmount)
	for _, ingredient in pairs(data.raw.recipe[recipeName].ingredients) do
		if ingredientName == ingredient.name then
			ingredient.name = newIngredientName
			if newAmount ~= nil then
				ingredient.amount = newAmount
			end
			return
		end
	end
	log("Warning: ingredient not found: "..ingredientName.." in recipe "..recipeName)
end

Export.addRecipeToTech = function(recipeName, techName, index)
	local unlock = {
		type = "unlock-recipe",
		recipe = recipeName,
	}
	local tech = data.raw.technology[techName]
	if tech == nil then
		log("ERROR: Couldn't find tech "..techName.." to add recipe "..recipeName.." to.")
		return
	end
	if not tech.effects then
		tech.effects = {unlock}
	else
		if index == nil then
			table.insert(tech.effects, unlock)
		else
			table.insert(tech.effects, index, unlock)
		end
	end
end

Export.copyAndEdit = function(t, edits)
	-- Returns a copy of t, with edits applied.
	local new = table.deepcopy(t)
	for k, v in pairs(edits) do
		new[k] = v
	end
	return new
end

Export.extend = function(t, l)
	for _, val in pairs(l) do
		table.insert(t, val)
	end
end

Export.addIngredients = function(recipeName, extraIngredients)
	local recipe = data.raw.recipe[recipeName]
	Export.extend(recipe.ingredients, extraIngredients)
end

Export.addSciencePack = function(techName, sciencePackName)
	local tech = data.raw.technology[techName]
	if tech == nil then
		log("ERROR: Couldn't find tech "..techName.." to add science pack "..sciencePackName.." to.")
		return
	end
	table.insert(tech.unit.ingredients, {sciencePackName, 1})
end

Export.addTechDependency = function(firstTech, secondTech)
	local secondTechData = data.raw.technology[secondTech]
	if secondTechData == nil then
		log("ERROR: Couldn't find tech "..secondTech.." to add dependency "..firstTech.." to.")
		return
	end
	if secondTechData.prerequisites == nil then
		secondTechData.prerequisites = {firstTech}
	else
		table.insert(secondTechData.prerequisites, firstTech)
	end
end

Export.replacePrereq = function(techName, oldPrereq, newPrereq)
	for i, prereq in pairs(data.raw.technology[techName].prerequisites) do
		if prereq == oldPrereq then
			data.raw.technology[techName].prerequisites[i] = newPrereq
			return
		end
	end
end

Export.hideRecipe = function(recipeName)
	local recipe = data.raw.recipe[recipeName]
	if recipe == nil then
		log("ERROR: Couldn't find recipe "..recipeName.." to hide.")
		return
	else
		recipe.hidden = true
	end
end

Export.hideTech = function(techName)
	local tech = data.raw.technology[techName]
	if tech == nil then
		log("Couldn't find tech "..techName.." to hide.")
		return
	end
	tech.enabled = false
	tech.hidden = true
end

Export.removePrereq = function(techName, oldPrereq)
	for i, prereq in pairs(data.raw.technology[techName].prerequisites) do
		if prereq == oldPrereq then
			table.remove(data.raw.technology[techName].prerequisites, i)
			return
		end
	end
end

return Export