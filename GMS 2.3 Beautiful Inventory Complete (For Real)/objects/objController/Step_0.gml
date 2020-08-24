/// @description Control Menu

if (keyboard_check_pressed(ord("M"))) {
	if (isShowingMenu == true) {
		isShowingMenu = false;
		if (sequence != undefined) {
			layer_sequence_destroy(sequence);
			instance_destroy(objItemParent);
			showingDescription = false;
		}
	}
	else {
		isShowingMenu = true;
		SortInventory(myItems, sortType);
	}
}

//Sort
if (isShowingMenu) {
	if (keyboard_check_pressed(ord("S"))) {
		++sortType;
		if (sortType >= SortType.Height) {
			sortType = 0;
		}
		SortInventory(myItems, sortType);
	}
}

//Animations
if (sequence != undefined && layer_sequence_is_finished(sequence) && layer_sequence_get_headdir(sequence) == seqdir_right) {
	showingDescription = true;
	if (instance_exists(objItemParent) == true) {
		currentItem.isShowingInfo = true;
	}
}
if (sequence != undefined && layer_sequence_is_finished(sequence) && layer_sequence_get_headdir(sequence) == seqdir_left) {
	layer_sequence_destroy(sequence);
}