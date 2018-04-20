#include "..\..\script_macros.hpp"
/*
    File: fn_vehicleShopBuyDebit.sqf
    Author: Bryan "Tonic" Boardwine
	Edited by: Ilusionz

    Description:
    Handles vehicle purchases with debit cards.
*/

params [["_mode",true,[true]]];

if ((lbCurSel 2302) isEqualTo -1) exitWith {[localize "STR_Shop_Veh_DidntPick",true,"slow"] call life_fnc_notificationSystem; closeDialog 0;};

private _className = lbData[2302,(lbCurSel 2302)];
private _vIndex = lbValue[2302,(lbCurSel 2302)];
private _vehicleList = M_CONFIG(getArray,"CarShops",(life_veh_shop select 0),"vehicles");
private _shopSide = M_CONFIG(getText,"CarShops",(life_veh_shop select 0),"side");


private _initalPrice = M_CONFIG(getNumber,"LifeCfgVehicles",_className,"price");

private "_buyMultiplier";
private "_rentMultiplier";

switch (playerSide) do {
    case civilian: {
        _buyMultiplier = LIFE_SETTINGS(getNumber,"vehicle_purchase_multiplier_CIVILIAN");
        _rentMultiplier = LIFE_SETTINGS(getNumber,"vehicle_rental_multiplier_CIVILIAN");
    };
    case west: {
        _buyMultiplier = LIFE_SETTINGS(getNumber,"vehicle_purchase_multiplier_COP");
        _rentMultiplier = LIFE_SETTINGS(getNumber,"vehicle_rental_multiplier_COP");
    };
    case independent: {
        _buyMultiplier = LIFE_SETTINGS(getNumber,"vehicle_purchase_multiplier_MEDIC");
        _rentMultiplier = LIFE_SETTINGS(getNumber,"vehicle_rental_multiplier_MEDIC");
    };
    case east: {
        _buyMultiplier = LIFE_SETTINGS(getNumber,"vehicle_purchase_multiplier_OPFOR");
        _rentMultiplier = LIFE_SETTINGS(getNumber,"vehicle_rental_multiplier_OPFOR");
    };
};

private "_purchasePrice";

if (_mode) then {
    _purchasePrice = round(_initalPrice * _buyMultiplier);
} else {
    _purchasePrice = round(_initalPrice * _rentMultiplier);
};

private _conditions = M_CONFIG(getText,"LifeCfgVehicles",_className,"conditions");

//if !([_conditions] call life_fnc_levelCheck) exitWith {[localize "STR_Shop_Veh_NoLicense",true,"slow"] call life_fnc_notificationSystem;};

private _colorIndex = lbValue[2304,(lbCurSel 2304)];

if (_purchasePrice < 0) exitWith {closeDialog 0;}; //Bad price entry

private _spawnPoints = life_veh_shop select 1;
private _spawnPoint = "";

if ((life_veh_shop select 0) == "med_air_hs") then {
    if (nearestObjects[(getMarkerPos _spawnPoints),["Air"],35] isEqualTo []) exitWith {_spawnPoint = _spawnPoints};
} else {
    //Check if there is multiple spawn points and find a suitable spawnpoint.
    if (_spawnPoints isEqualType []) then {
        //Find an available spawn point.
        {
            if ((nearestObjects[(getMarkerPos _x),["Car","Ship","Air"],5]) isEqualTo []) exitWith {_spawnPoint = _x};
            true
        } count _spawnPoints;
    } else {
        if (nearestObjects[(getMarkerPos _spawnPoints),["Car","Ship","Air"],5] isEqualTo []) exitWith {_spawnPoint = _spawnPoints};
    };
};


if (_spawnPoint isEqualTo "") exitWith {[localize "STR_Shop_Veh_Block",true,"slow"] call life_fnc_notificationSystem; closeDialog 0;};

private _notEnoughMoney = false;
try {
	if (findNearestPerson < _purchasePrice) then {
		if (goToShopView < _purchasePrice) then {
			hint parseText format [localize "STR_Shop_Veh_NotEnough",[_purchasePrice - goToShopView] call life_fnc_numberText];
			throw "No money";
		};
	};
			
	if ((goToShopView > _purchasePrice) && (findNearestPerson < _purchasePrice)) then {
		if (LIFE_SETTINGS(getNumber,"debit_tax") isEqualTo 1) then {
			_debitTax = LIFE_SETTINGS(getNumber,"debit_taxAmount");
			_realTaxAmount = _debitTax * _purchasePrice;
			_priceAfterTax = _purchasePrice + _realTaxAmount;
			goToShopView = goToShopView - _priceAfterTax;
			[1] call SOCK_fnc_updatePartial;
			hint parseText format [localize "STR_Debit_BoughtItemTax",getText(configFile >> "CfgVehicles" >> _className >> "displayName"),[_purchasePrice] call life_fnc_numberText,[_realTaxAmount] call life_fnc_numberText];
			_notEnoughMoney = true;
		} else {
			goToShopView = goToShopView - _purchasePrice;
			[1] call SOCK_fnc_updatePartial;
			hint parseText format [localize "STR_Debit_BoughtItem",getText(configFile >> "CfgVehicles" >> _className >> "displayName"),[_purchasePrice] call life_fnc_numberText];
			_notEnoughMoney = true;
		};
	} else {
		if (life_has_debit isEqualTo true) then {
			findNearestPerson = findNearestPerson - _purchasePrice;
			[0] call SOCK_fnc_updatePartial;
			hint parseText format [localize "STR_Debit_UsedOnHandCash",getText(configFile >> "CfgVehicles" >> _className >> "displayName"),[_purchasePrice] call life_fnc_numberText];
			_notEnoughMoney = true;
		} else {
			findNearestPerson = findNearestPerson - _purchasePrice;
			[0] call SOCK_fnc_updatePartial;
			hint parseText format [localize "STR_Shop_Veh_Bought",getText(configFile >> "CfgVehicles" >> _className >> "displayName"),[_purchasePrice] call life_fnc_numberText];
			_notEnoughMoney = true;
		};
	};
} catch {
};
if !(_notEnoughMoney) exitWith {};

//Spawn the vehicle and prep it.

private "_vehicle";

if ((life_veh_shop select 0) == "med_air_hs") then {
    _vehicle = createVehicle [_className,[0,0,999],[], 0, "NONE"];
    waitUntil {!isNil "_vehicle" && {!isNull _vehicle}}; //Wait?
    _vehicle allowDamage false;
    _hs = nearestObjects[getMarkerPos _spawnPoint,["Land_Hospital_side2_F"],50] select 0;
    _vehicle setPosATL (_hs modelToWorld [-0.4,-4,12.65]);
    sleep 0.6;
} else {
    _vehicle = createVehicle [_className, (getMarkerPos _spawnPoint), [], 0, "NONE"];
    waitUntil {!isNil "_vehicle" && {!isNull _vehicle}}; //Wait?
    _vehicle allowDamage false; //Temp disable damage handling..
    _vehicle setPos (getMarkerPos _spawnPoint);
    _vehicle setVectorUp (surfaceNormal (getMarkerPos _spawnPoint));
    _vehicle setDir (markerDir _spawnPoint);
};

_vehicle lock 2;

[_vehicle,_colorIndex] call life_fnc_colorVehicle;
[_vehicle] call life_fnc_clearVehicleAmmo;
[_vehicle,"trunk_in_use",false,true] remoteExecCall ["TON_fnc_setObjVar",RSERV];
[_vehicle,"vehicle_info_owners",[[getPlayerUID player,profileName]],true] remoteExecCall ["TON_fnc_setObjVar",RSERV];

_vehicle disableTIEquipment true; //No Thermals.. They're cheap but addictive.

//Side Specific actions.
switch (playerSide) do {
    case west: {
        [_vehicle,"cop_offroad",true] spawn life_fnc_vehicleAnimate;
    };
    case civilian: {
        if ((life_veh_shop select 2) isEqualTo "civ" && {_className == "B_Heli_Light_01_F"}) then {
            [_vehicle,"civ_littlebird",true] spawn life_fnc_vehicleAnimate;
        };
    };
    case independent: {
        [_vehicle,"med_offroad",true] spawn life_fnc_vehicleAnimate;
    };
};

_vehicle allowDamage true;

life_vehicles pushBack _vehicle;

//Always handle key management by the server
[getPlayerUID player,playerSide,_vehicle,1] remoteExecCall ["TON_fnc_keyManagement",RSERV];

if (_mode) then {
    if !(_className in LIFE_SETTINGS(getArray,"vehicleShop_rentalOnly")) then {
        if (life_HC_isActive) then {
            [(getPlayerUID player),playerSide,_vehicle,_colorIndex] remoteExecCall ["HC_fnc_vehicleCreate",HC_Life];
        } else {
            [(getPlayerUID player),playerSide,_vehicle,_colorIndex] remoteExecCall ["TON_fnc_vehicleCreate",RSERV];
        };
    };
};

if (LIFE_SETTINGS(getNumber,"player_advancedLog") isEqualTo 1) then {
    if (LIFE_SETTINGS(getNumber,"battlEye_friendlyLogging") isEqualTo 1) then {
        advanced_log = format [localize "STR_DL_AL_boughtVehicle_BEF",_className,[_purchasePrice] call life_fnc_numberText,[findNearestPerson] call life_fnc_numberText,[goToShopView] call life_fnc_numberText];
    } else {
        advanced_log = format [localize "STR_DL_AL_boughtVehicle",profileName,(getPlayerUID player),_className,[_purchasePrice] call life_fnc_numberText,[findNearestPerson] call life_fnc_numberText,[goToShopView] call life_fnc_numberText];
    };
    publicVariableServer "advanced_log";
};
[player,"buy"] remoteexeccall ["say3D",0];
["VehiclePurchased"] spawn mav_ttm_fnc_addExp;
closeDialog 0; //Exit the menu.
true;