params ["_unit", ["_clp",false]];
private ["_fnc_load", "_out", "_item"];

_fnc_load = {
	params ["_cmd", "_arr"];

	_arr = _arr call BIS_fnc_consolidateArray;

	{
		if (_x select 1 > 1) then {
			_out = _out + format ["for '_i' from 1 to %1 do { _unit %2 '%3';};", _x select 1, _cmd, _x select 0] + endl;
		} else {
			_out = _out + format ["_unit %1 '%2';", _cmd, _x select 0] + endl;
		};
		true
	} count _arr;
};

/*
_fnc_allowedClassname = {
	params ["_allClassnames", "_allUnitMagazines", "_currentClassname"];
	_allClassnames = getArray (configFile >> "cfgWeapons" >> ((getUnitLoadout (missionConfigFile >> "MyLoadout") select 0) select 0) >> "magazines");
};
*/

// Доб. временный рюкзак
_out = "// Squad Games" + endl + endl + "_unit addBackpack ""B_Carryall_Base"";" + endl + endl;

_out = _out + "// Weapons with attachments:" + endl;


// Труба
if (secondaryWeapon _unit != "") then {
	_out = _out + endl;
	if (secondaryWeaponMagazine _unit select 0 != "<null>") then {
		_out = _out + format ["_unit addItem ""%1"";", secondaryWeaponMagazine _unit select 0] + endl;
	};
	_out = _out + format ["_unit addWeapon ""%1"";", secondaryWeapon _unit] + endl;
	{
		if (_x != "") then {
			_out = _out + format ["_unit addSecondaryWeaponItem ""%1"";", _x] + endl;
		};
	} count (secondaryWeaponItems _unit);
};


// Вт. оружие
if (handgunWeapon _unit != "") then {
	_out = _out + endl;
	if (handgunMagazine _unit select 0 != "<null>") then {
		_out = _out + format ["_unit addItem ""%1"";", handgunMagazine _unit select 0] + endl;
	};
	_out = _out + format ["_unit addWeapon ""%1"";", handgunWeapon _unit] + endl;
	{
		if (_x != "") then {
			_out = _out + format ["_unit addHandgunItem ""%1"";", _x] + endl;
		};
	} count (handgunItems _unit);
};


// Осн. оружие
if (primaryWeapon _unit != "") then {
	_out = _out + endl;	
	if (primaryWeaponMagazine _unit select 0 != "<null>") then {
		_out = _out + format ["_unit addItem ""%1"";", primaryWeaponMagazine _unit select 0] + endl;
	};
	_out = _out + format ["_unit addWeapon ""%1"";", primaryWeapon _unit] + endl;
	{
		if (_x != "") then {
			_out = _out + format ["_unit addPrimaryWeaponItem ""%1"";", _x] + endl;
		};
	} count (primaryWeaponItems _unit);
};


// Бинокль
if (binocular _unit != "") then {
	_out = _out + endl;
	_out = _out + format ["_unit addWeapon ""%1"";", binocular _unit] + endl;
};

_out = _out + endl + "removeBackpack _unit;" + endl + endl;

// Форма
if (uniform _unit != "") then {
	_out = _out + endl + "// Uniform with items:" + endl;
	_out = _out + format ["_unit forceAddUniform ""%1"";", uniform _unit] + endl;
	["addItemToUniform", (uniformItems _unit)] call _fnc_load;
};

// Разгрузка
if (vest _unit != "") then {
	_out = _out + endl + "// Vest with items:" + endl;
	_out = _out + format ["_unit addVest ""%1"";", vest _unit] + endl;
	["addItemToVest", (vestItems _unit)] call _fnc_load;
};

// Рюкзак
if (backpack _unit != "") then {
	_out = _out + endl + "// Backpack with items:" + endl;
	_out = _out + format ["_unit addBackpack ""%1"";", backpack _unit] + endl;
	["addItemToBackpack ", (backpackItems _unit)] call _fnc_load;
};

// Каска
if (headgear _unit != "") then {
	_out = _out + format ["_unit addHeadgear ""%1"";", headgear _unit] + endl + endl;
};

// Рация, жепес, компас и т.д.
{
	_item = _x;
	if (_item != "") then {
		{
			if (_item select [0, count _x] == _x) exitwith {
				_item = _x;
			};
			true
		} count ["tf_anprc152", "tf_anprc148jem", "tf_fadak", "tf_rf7800str", "tf_anprc154", "tf_pnr1000a"];

		if (_x isKindOf ["ItemCore", configFile >> "CfgWeapons"]) then {
			_out = _out + format ["_unit linkItem ""%1"";", _item] + endl;
		};
	};
} count (assignedItems _unit);

// Экспорт в буфер
if (_clp) then {copyToClipboard _out;};
_out