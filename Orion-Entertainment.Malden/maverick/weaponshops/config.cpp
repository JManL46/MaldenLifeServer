/*--------------------------------------------------------------------------
    Author:		Maverick Applications
    Website:	https://maverick-applications.com

    You're not allowed to use this file without permission from the author!
---------------------------------------------------------------------------*/

// Configuration file for the weaponshop

class maverick_weaponshop_cfg {

	cashVar = "life_cash";								//--- Cash Variable
	cashSymbol = "$"; 									//--- Currency Symbol
	rotationSpeed = 2; 									//--- Rotation speed for item in preview (1 - 10)
	saveFunction = "[] call SOCK_fnc_updateRequest"; 	//--- Function to save gear etc. once items are purchased

	class localization {
		//--- localization for hints etc.
		msgParamEmpty =						"Shop Parameter is empty!";
		msgInVehicle =						"You cannot be in a Vehicle!";
		msgShopExists =						"Shop doesn't Exist!";
		msgCondition =						"Not permitted to access this Shop!";
		msgCashOnHand =						"Cash on Hand - %1%2";
		msgCartTotal =						"Your Cart - %1%2";
		msgInfoTooltip =					"--> HOLD YOUR LEFT MOUSE BUTTON DOWN WHILE MOVING MOUSE TO ROTATE WEAPON.\n--> DOUBLE CLICK ON AN ITEM IN THE CART TO REMOVE IT.\n--> USE THE 'OVERRIDE GEAR' CHECKBOX TO REPLACE WEAPONS ON HAND WITH PURCHASED WEAPONS.";
		msgInfoTooltip2 = 					"--> DOUBLE CLICK ON AN ITEM IN THE CART TO REMOVE IT.\n--> USE THE 'OVERRIDE GEAR' CHECKBOX TO REPLACE WEAPONS ON HAND WITH PURCHASED WEAPONS.";
		msgEmptyShop = 						"Nothing Found...";
		msgInfoText	=						"<t color='#FFFFFF'>Price:</t> <t color='%1'>%3%2</t>";
		msgCartFull	=						"Cart is Full";
		msgCartEmpty =						"Cart is Empty";
		msgNotEnoughCash =					"Not enough Cash for this Transaction";
		msgOverrideAlert =					"Use the override feature to override gear!";
		msgTransactionComplete =			"Purchase completed for %1%2";
		msgNotEnoughSpace =				 	"You didn't have enough space for all the items. You however only paid for those you had space for!";
		msgClear =							"Clear";
		msgSearch =							"Search";

		//--- localization for dialogs
		#define dialogTabWeapon				"Weapon"
		#define dialogTabMagazines			"Magazines"
		#define dialogTabAttachments		"Attachments"
		#define dialogTabOther				"Other"
		#define dialogAddBtn				"Add"
		#define dialogOverrideTooltip		"Override Gear"
		#define dialogCompleteBtn			"Complete"
		#define dialogCloseBtn 				"Close"
	};

	class shops {
		class gun {
			title = "Gun Shop"; //--- Title of Shop
			condition = "side player == civilian"; 	//--- Condition to meet to access shop
			simple = 0; 			//--- Type of GUI 0-Weapon View 1-No Weapon View
			maxCart = 50; 			//--- Max Amount of Items in Shopping Cart

			weapons[] = {
				//--- item classname, price, condition, custom display name
				{"hgun_Rook40_F", 5000, "license_civ_gun1", ""},
				{"hgun_Pistol_heavy_02_F", 7500, "license_civ_gun1", ""},
				{"hgun_ACPC2_F", 15000, "license_civ_gun1", ""},
				{"hgun_PDW2000_F", 20000, "license_civ_gun2", ""},
				{"SMG_05_F", 25000, "license_civ_gun2", ""},
				{"SMG_01_F", 30000, "license_civ_gun2", ""},
				{"arifle_TRG21_F", 45000, "license_civ_gun3", ""},
				{"arifle_Mk20_F", 45000, "license_civ_gun3", ""},
				{"arifle_SPAR_01_blk_F", 140000, "license_civ_gun3", ""}
			};

			magazines[] = {
				{"30Rnd_9x21_Mag", 100, "", ""},
				{"30Rnd_9x21_Mag", 100, "", ""},
				{"30Rnd_9x21_Mag", 100, "", ""},
				{"30Rnd_9x21_Mag", 100, "", ""},
				{"30Rnd_9x21_Mag", 100, "", ""},
				{"30Rnd_9x21_Mag", 100, "", ""},
				{"30Rnd_9x21_Mag", 100, "", ""},
				{"20Rnd_762x51_Mag", 100, "", ""}
			};

			attachments[] = {
				{"optic_Arco", 2500, "true", ""},
				{"optic_Arco_blk_F", 2500, "true", ""},
				{"optic_ERCO_blk_F", 2500, "true", ""},
				{"optic_Holosight_blk_F", 2500, "true", ""},
				{"optic_Holosight_smg_blk_F", 2500, "true", ""},
				{"optic_MRCO", 2500, "true", ""},
				{"optic_DMS", 10000, "true", ""},
				{"acc_flashlight", 2500, "true", ""},
				{"acc_flashlight_pistol", 2500, "true", ""},
				{"bipod_01_F_blk", 2500, "true", ""}
			};
			
			items[] = {
				{"Binocular", 50, "", ""},
				{"NVGoggles", 100, "", ""}, //--- NV goggles won't be shown on preview
				{"U_O_GhillieSuit", 100, "", ""} //--- Clothing can also be sold but isn't guaranteed to be previewed - just make sure override checkbox is used to override clothing on player
			};
		};
	};
};

#include "gui\weapon_gui_master.cpp"
