/// @description Add an item to a DS Grid
/// @param Grid The DS Grid
/// @param Attributes An array of the Item enum attributes
function AddItem(grid, attributes) {
	var canStack = true;
	
	//First Check - are the arguments acceptable?
	if (ds_exists(grid, ds_type_grid) == false) {
		show_message("No grid found.");
		return;
	}
	if (is_array(attributes) == false || array_length(attributes) != Item.Height) {
		show_message("Wrong attributes.");
		return;
	}
	
	//Second Check - is this item in the master list?
	var isInMasterList = false;
	for(var i = 0; i < ds_grid_width(global.AllItems); ++i) {
		if (global.AllItems[# i, Item.Name] == attributes[Item.Name]) {
			isInMasterList = true;
		}
	}
	if (isInMasterList == false) {
		show_message("Cannot find this item");
		return;
	}
	
	//Third check - Can it stack?
	if (attributes[Item.Type] != Type.Consumable) {
		canStack = false;
		if (attributes[Item.Amount] > 1) {
			for(var i = 0; i < attributes[Item.Amount]; ++i) {
				AddItem(grid, [attributes[Item.Name], attributes[Item.Sprite], 1, attributes[Item.Type], attributes[Item.Price], attributes[Item.Object]]);
			}
			return;
		}
	}
	
	//Fourth Check - Is it already in the grid
	if (canStack) {
		for(var i = 0; i < ds_grid_width(grid); ++i) {
			if (attributes[Item.Name] == grid[# i, Item.Name]) {
				//It's in here, so add amount to item in grid
				grid[# i, Item.Amount] += attributes[Item.Amount];
				return;
			}
		}
	}
	
	//Fifth Check - do I have space?
	if (maxInventorySlots <= ds_grid_width(grid)) {
		return;
	}
	
	//Sixth Check - Not in the grid, so add it
	ds_grid_resize(grid, ds_grid_width(grid) + 1, ds_grid_height(grid));
	for(var i = 0; i < array_length(attributes); ++i) {
		grid[# ds_grid_width(grid) - 1, i] = attributes[i];
	}
	
}

/// @description Add an item to master list
/// @param Attributes The array of attributes to add
function AddItemToMasterList(attributes){
	
	//Does the global variable exist?
	if (variable_global_exists("AllItems") == false) {
		show_message("No variable found called allitems.");
		return;
	}
	//Is the global variable a ds grid?
	if (ds_exists(global.AllItems, ds_type_grid) == false) {
		show_message("No ds grid found");
		return;
	}
	//Are the attributes proper?
	if (is_array(attributes) == false || array_length(attributes) != Item.Height) {
		show_message("Input for adding items isn't right.");
		return;
	}
	
	//Add the item
	ds_grid_resize(global.AllItems, ds_grid_width(global.AllItems) + 1, ds_grid_height(global.AllItems));
	for (var i = 0; i < array_length(attributes); ++i) {
		global.AllItems[# ds_grid_width(global.AllItems) - 1, i] = attributes[i];
	}
}

/// @description Sort An Inventory
/// @param Grid The grid to sort
/// @param SortType How to sort the inventory
function SortInventory(grid, sortType) {
	
	//convert sorttype to item attribute
	switch(sortType) {
		case SortType.Name:
			sortType = Item.Name;
		break;
		case SortType.Amount:
			sortType = Item.Amount;
		break;
		case SortType.Price:
			sortType = Item.Price;
		break;
		case SortType.Type:
			sortType = Item.Type;
		break;
	}
	
	//Create a temporary DS grid
	var sortedGrid = ds_grid_create(0, Item.Height);
	var lowestItem = 0, savedItems;
	savedItems[0] = undefined; //Items are already got from the grid
	
	for(var i = 0; i < ds_grid_width(grid); ++i) {
		for(var j = 0; j < ds_grid_width(grid); ++j) {
			var item1 = grid[# lowestItem, sortType];
			var item2 = grid[# j, sortType];
			if(item2 <= item1 && ArrayContains(savedItems, j) == false) {
				lowestItem = j;
			}
		}
		//End of inner loop
		AddItem(sortedGrid, [grid[# lowestItem, Item.Name], grid[# lowestItem, Item.Sprite], grid[# lowestItem, Item.Amount],
		grid[# lowestItem, Item.Type], grid[# lowestItem, Item.Price], grid[# lowestItem, Item.Object]]);
		//Add to saved items
		savedItems[i] = lowestItem;
		//Find Next lowest Item
		for(var l = 0; l < ds_grid_width(grid); ++l) {
			if(ArrayContains(savedItems, l) == false) {
				lowestItem = l;
			}
		}
	}
	
	//Copy items and return
	ds_grid_set_grid_region(grid, sortedGrid, 0, 0, ds_grid_width(sortedGrid), Item.Height, 0, 0);
	ds_grid_destroy(sortedGrid);
	return grid;
}

/// @description Find if an array of numbers contains a specific number
/// @param Array The array to check
/// @param Number The number to check for
function ArrayContains(array, number) {
	for(var i = 0; i < array_length(array); ++i) {
		if (array[i] == number) {
			return true;
		}
	}
	return false;
}






















