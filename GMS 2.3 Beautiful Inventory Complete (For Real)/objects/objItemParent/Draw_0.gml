/// @description Draw Info
draw_self();

//Info for when displaying description sprite
if (isShowingInfo == true) {
	draw_set_alpha(1);
	//Name
	draw_set_font(fntSmaller);
	draw_set_color(c_red);
	draw_text_ext(CameraMiddleX() + 60, CameraY() + 125, name, 20, textWidth + 15);
	//Description
	draw_set_font(fntLarger);
	draw_set_color(c_black);
	draw_text_ext(CameraMiddleX() + 60, CameraMiddleY() - 75, description, 20, textWidth);
	//Attributes
	if (damage != undefined) {
		draw_sprite_ext(sprSwordIcon, 0, CameraX() + 395, CameraY() + 340,
		iconScale, iconScale, 0, c_white, 1);
		draw_text(CameraX() + 385 + sprite_get_width(sprSwordIcon) * iconScale, 
		CameraY() + 332, string(damage));
	}
	if (defense != undefined) {
		draw_sprite_ext(sprArmorIcon, 0, CameraX() + 455, CameraY() + 340,
		iconScale, iconScale, 0, c_white, 1);
		draw_text(CameraX() + 445 + sprite_get_width(sprArmorIcon) * iconScale,
		CameraY() + 332, string(defense));
	}
	if (healthRestored != undefined) {
		draw_sprite_ext(sprHealthIcon, 0, CameraX() + 490, CameraY() + 340,
		iconScale, iconScale, 0, c_white, 1);
		draw_text(CameraX() + 480 + sprite_get_width(sprHealthIcon) * iconScale,
		CameraY() + 332, string(healthRestored));
	}
	if (manaRestored != undefined) {
		draw_sprite_ext(sprManaIcon, 0, CameraX() + 550, CameraY() + 340,
		iconScale, iconScale, 0, c_white, 1);
		draw_text(CameraX() + 540 + sprite_get_width(sprManaIcon) * iconScale,
		CameraY() + 332, string(manaRestored));
	}
	if (ailmentsCured != undefined) {
		draw_sprite_ext(sprAilmentIcon, 0, CameraX() + 395, CameraY() + 385,
		iconScale, iconScale, 1, c_white, 1);
		for(var i = 0; i < array_length(ailmentsCured); ++i) {
			if(i == Ailment.Confused) {
				draw_text(CameraX() + 390 + sprite_get_width(sprAilmentIcon) * iconScale, 
				CameraY() + 340 + (i * 20), "Cures Confusion");
			}
			if(i == Ailment.Drunk) {
				draw_text(CameraX() + 390 + sprite_get_width(sprAilmentIcon) * iconScale, 
				CameraY() + 360 + (i * 20), "Cures Drunkness");
			}
			if(i == Ailment.Poison) {
				draw_text(CameraX() + 390 + sprite_get_width(sprAilmentIcon) * iconScale, 
				CameraY() + 380 + (i * 20), "Cures Poison");
			}
		}
	}
	//Buttons
	if (type == Type.Armor) {
		draw_sprite(sprEquipButton, 0, CameraX() + 480, CameraY() + 455);
	}
	if (type == Type.Weapon) {
		draw_sprite(sprEquipButton, 0, CameraX() + 480, CameraY() + 455);
	}
	if (type == Type.Consumable) {
		draw_sprite(sprUseButton, 0, CameraX() + 480, CameraY() + 455);
	}
}
if (isInMenu == true) {
	//Price
	draw_set_color(c_orange);
	draw_set_font(fntSmaller);
	draw_text_ext(CameraX() + 55, CameraY() + 390, name + " is worth " + string(price) + " gold each.",
	font_get_size(fntSmaller) * 1.5, sprite_get_width(sprInventoryFront) - 20);
}