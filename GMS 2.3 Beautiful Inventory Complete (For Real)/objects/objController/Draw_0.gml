/// @description Draw The Menu
draw_self();

if (isShowingMenu) {
	//Pause the game
	draw_set_color(c_black);
	draw_set_alpha(.75);
	draw_rectangle(0, 0, room_width, room_height, false);
	
	//Back of the inventory
	draw_set_alpha(1);
	draw_sprite(sprInventoryBackDrop, 0, CameraX() + 175, CameraMiddleY());
	
	//Items
	for(var i = 0; i < ds_grid_width(myItems); ++i) {
		var itemX = CameraX() + 81 + (i * itemSeperation);
		var itemY = CameraY() + 111;
		var sprite = myItems[# i, Item.Sprite];
		
		//Check for additional rows needed
		if (i >= menuWidth && i < menuWidth * 2) {
			itemX = CameraX() + 81 + ((i - menuWidth) * itemSeperation);
			itemY = CameraY() + 147;
		}
		if (i >= menuWidth * 2 && i < menuWidth * 3) {
			itemX = CameraX() + 81 + ((i - menuWidth * 2) * itemSeperation);
			itemY = CameraY() + 183;
		}
		if(i >= 18 && i < menuWidth * 4) {
			itemX = CameraX() + 81 + ((i - menuWidth * 3) * itemSeperation);
			itemY = CameraY() + 219;
		}
		if(i >= 24 && i < menuWidth * 5) {
			itemX = CameraX() + 81 + ((i - menuWidth * 4) * itemSeperation);
			itemY = CameraY() + 255 ;
		}
		if(i >= 30 && i < menuWidth * 6) {
			itemX = CameraX() + 81 + ((i - menuWidth * 5) * itemSeperation);
			itemY = CameraY() + 291;
		}
		if(i >= 36 && i < menuWidth * 7) {
			itemX = CameraX() + 81 + ((i - menuWidth * 6) * itemSeperation);
			itemY = CameraY() + 327;
		}
		if(i >= 42 && i < menuWidth * 8) {
			itemX = CameraX() + 81 + ((i - menuWidth * 7) * itemSeperation);
			itemY = CameraY() + 363;
		}
		
		draw_sprite_ext(sprite, 0, itemX, itemY, itemScale, itemScale, 0, c_white, 1);
		
		//Amount
		draw_set_color(c_white);
		draw_set_alpha(1);
		draw_set_font(fntSmaller);
		draw_text(itemX - 16, itemY + 4, myItems[# i, Item.Amount]);
		
		//Check if mouse is hovering over an item
		if (point_in_rectangle(mouse_x, mouse_y, itemX - 16, itemY - 16, itemX + 16, itemY + 16)) {
			draw_set_alpha(0.25);
			draw_set_color(c_blue);
			draw_rectangle(itemX - 16, itemY - 16, itemX + 16, itemY + 16, false);
			draw_set_alpha(1);
			currentItemSlot = i;
			
			//Draw item info
			if (instance_exists(myItems[# i, Item.Object]) == false && draggingItem == false && itemLocked == false) {
				currentItem = instance_create_layer(-32, -32, "MenuItems", myItems[# i, Item.Object]);
				currentItem.price = myItems[# i, Item.Price];
				currentItem.type = myItems[# i, Item.Type];
				currentItem.name = myItems[# i, Item.Name];
				currentItem.isInMenu = true;
				if (showingDescription) {
					currentItem.isShowingInfo = true;
				}
			}
			
			//Clicked on an item
			if (mouse_check_button_pressed(mb_left) && showingDescription == false) {
				sequence = layer_sequence_create("Instances", CameraMiddleX(), CameraMiddleY(), sqDescriptionAnimation);
			}
			//Lock Item
			if (mouse_check_button_pressed(mb_right) && itemLocked == false && showingDescription == true) {
				itemLocked = true;
				lockedItemX = itemX;
				lockedItemY = itemY;
			}
			else if (mouse_check_button_pressed(mb_right) && itemLocked == true) {
				itemLocked = false;
			}
		}
	}
	
	//Draw locked item
	if (itemLocked == true) {
		draw_set_alpha(0.5);
		draw_set_color(c_red);
		draw_rectangle(lockedItemX - 16, lockedItemY - 16, lockedItemX + 16, lockedItemY + 16, false);
		draw_set_alpha(1);
	}
	
	//Dragging System
	if (mouse_check_button(mb_middle)) {
		draggedItem = instance_find(objItemParent, 0);
		draggedItem.x = mouse_x;
		draggedItem.y = mouse_y;
		draggedItem.visible = true;
		draggedItem.image_xscale = itemScale;
		draggedItem.image_yscale = itemScale;
		draggingItem = true;
	}
	if (mouse_check_button_pressed(mb_middle)) {
		draggedItemSlot = currentItemSlot;
	}
	if (mouse_check_button_released(mb_middle)) {
		draggedItem.x = -100;
		draggedItem.y = -100;
		draggingItem = false;
		alarm[0] = 1;
	}
	
	//Exit description
	if (point_in_rectangle(mouse_x, mouse_y, CameraX() + 580, CameraY() + 35, CameraX() + 620, CameraY() + 70) == true) {
		if(mouse_check_button_pressed(mb_left)) {
			layer_sequence_headdir(sequence, seqdir_left);
			layer_sequence_play(sequence);
			showingDescription = false;
			instance_destroy(objItemParent);
		}
	}
	
	//Ensure only 1 item exists at a time
	if (instance_number(objItemParent) > 1) {
		instance_destroy(objItemParent);
	}
	
	//Locked Item Slots
	for(var i = maxInventorySlots; i < menuHeight * menuWidth; ++i) {
		var itemX = CameraX() + 81 + (i * itemSeperation);
		var itemY = CameraY() + 111;
		var sprite = sprLockedIcon;
		
		//Check for additional rows needed
		if (i >= menuWidth && i < menuWidth * 2) {
			itemX = CameraX() + 81 + ((i - menuWidth) * itemSeperation);
			itemY = CameraY() + 147;
		}
		if (i >= menuWidth * 2 && i < menuWidth * 3) {
			itemX = CameraX() + 81 + ((i - menuWidth * 2) * itemSeperation);
			itemY = CameraY() + 183;
		}
		if(i >= 18 && i < menuWidth * 4) {
			itemX = CameraX() + 81 + ((i - menuWidth * 3) * itemSeperation);
			itemY = CameraY() + 219;
		}
		if(i >= 24 && i < menuWidth * 5) {
			itemX = CameraX() + 81 + ((i - menuWidth * 4) * itemSeperation);
			itemY = CameraY() + 255 ;
		}
		if(i >= 30 && i < menuWidth * 6) {
			itemX = CameraX() + 81 + ((i - menuWidth * 5) * itemSeperation);
			itemY = CameraY() + 291;
		}
		if(i >= 36 && i < menuWidth * 7) {
			itemX = CameraX() + 81 + ((i - menuWidth * 6) * itemSeperation);
			itemY = CameraY() + 327;
		}
		if(i >= 42 && i < menuWidth * 8) {
			itemX = CameraX() + 81 + ((i - menuWidth * 7) * itemSeperation);
			itemY = CameraY() + 363;
		}
		
		draw_sprite_ext(sprite, 0, itemX, itemY, .5, .5, 0, c_white, 1);
	}
	
	//Front of the inventory
	draw_sprite(sprInventoryFront, 0, CameraX() + 175, CameraMiddleY() + 20);
	
	//Sort Type
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_set_font(fntSmaller);
	if (sortType == SortType.Name) {
		draw_text(CameraX() + 75, CameraY() + 425, "Sorting by Name");
	}
	if (sortType == SortType.Amount) {
		draw_text(CameraX() + 75, CameraY() + 425, "Sorting by Amount");
	}
	if (sortType == SortType.Price) {
		draw_text(CameraX() + 75, CameraY() + 425, "Sorting by Price");
	}
	if (sortType == SortType.Type) {
		draw_text(CameraX() + 75, CameraY() + 425, "Sorting by Type");
	}
	
	//Press Button
	if (point_in_rectangle(mouse_x, mouse_y, CameraX() + 440, CameraY() + 435, CameraX() + 520, CameraY() + 470) == true && mouse_check_button_pressed(mb_left)) {
		show_message("Button pressed.");
	}
}









