/// @description Master Item Object

//All Item Properties
enum Item {
	Name,
	Sprite,
	Amount,
	Type,
	Price,
	Object,
	Height
}

enum Type {
	Weapon,
	Armor,
	Consumable
}

enum Ailment {
	Poison,
	Confused,
	Drunk
}

enum SortType {
	Name,
	Amount,
	Type,
	Price,
	Height
}




///Master item list
///             0   1
///0 (Name)  
///1 (Sprite) 
///2 (Amount)
///3 (Type)
///4 (Price)
///5 (Object)

global.AllItems = ds_grid_create(0, Item.Height);


AddItemToMasterList(["Small Knife", sprKnife, 1, Type.Weapon, 5, objKnife]);
AddItemToMasterList(["Broad Sword", sprSword, 1, Type.Weapon, 50, objSword]);
AddItemToMasterList(["Blue Jelly", sprJellyBlue, 1, Type.Consumable, 20, objJellyBlue]);
AddItemToMasterList(["Red Jelly", sprJellyRed, 1, Type.Consumable, 15, objJellyRed]);
AddItemToMasterList(["Legendary Crystal Armor", sprCrystalArmor, 1, Type.Armor, 5000, objArmorCrystal]);
AddItemToMasterList(["Pretty Teal Bow", sprBowTeal, 1, Type.Armor, 100, objBowTeal]);
AddItemToMasterList(["Mage's Staff", sprStaff, 1, Type.Weapon, 100, objStaff]);
AddItemToMasterList(["Fluffy Cape", sprCape, 1, Type.Armor, 200, objCape]);







