class CfgPatches
{
	class sg_arsenal
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 1.0;
		requiredAddons[] = {"A3_UI_F", "cba_xeh_a3"};
		author = "Yol";
		version = 0.0.2;
		versionStr = "0.0.2";
		versionAr[] = {0,0,2};
	};
};

#include "CfgFunctions.hpp"

class RscButtonMenu;
class RscControlsGroup;
class RscDisplayArsenal {
	class Controls {
		class ButtonExport: RscButtonMenu {
		    idc = -1;
			x = "0.505156 * safezoneW + safezoneX";
			y = "0.94 * safezoneH + safezoneY";
			w = "0.16 * safezoneW";
			h = "0.022 * safezoneH";
			text = $STR_SG_EXPORT_EQUIP;
			color[] = {1,1,1,1};
			color2[] = {0,0,0,1};
			color2Secondary[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0.8};
			colorBackground2[] = {0.75,0.75,0.75,1};
		    colorBackgroundFocused[] = {1,1,1,1};
			colorDisabled[] = {1,1,1,0.25};
			colorDisabledSecondary[] = {1,1,1,0.25};
			colorFocused[] = {0,0,0,1};
			colorFocusedSecondary[] = {0,0,0,1};
			colorSecondary[] = {1,1,1,1};
			colorText[] = {1,1,1,1};
			action = "[(missionnamespace getvariable ['BIS_fnc_arsenal_center',player]),true] call sg_arsenal_fnc_arsenal_export";
		};
		class ButtonClean: RscButtonMenu {
		    idc = -1;
			x = "0.335 * safezoneW + safezoneX";
			y = "0.94 * safezoneH + safezoneY";
			w = "0.16 * safezoneW";
			h = "0.022 * safezoneH";
		    text = $STR_SG_CLEAR_EQUIP;
			color[] = {1,1,1,1};
			color2[] = {0,0,0,1};
			color2Secondary[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0.8};
			colorBackground2[] = {0.75,0.75,0.75,1};
		    colorBackgroundFocused[] = {1,1,1,1};
			colorDisabled[] = {1,1,1,0.25};
			colorDisabledSecondary[] = {1,1,1,0.25};
			colorFocused[] = {0,0,0,1};
			colorFocusedSecondary[] = {0,0,0,1};
			colorSecondary[] = {1,1,1,1};
			colorText[] = {1,1,1,1};
			action = "[(missionnamespace getvariable ['BIS_fnc_arsenal_center',player])] call sg_arsenal_fnc_arsenal_clean";
			
			
		};	
	};
};


class Extended_PostInit_EventHandlers
{
	class ExportArsenal
	{
		clientInit = "if (missionName == 'Arsenal') then { diag_log 'cba_xeh: ExportArsenal'; [] spawn {waitUntil{TF_radio_request_mutex=true;TF_respawnedAt=time;TF_last_request_time=time; false}}; [] spawn {waituntil {!(IsNull (findDisplay 46))}; (findDisplay 46) displayAddEventHandler [""KeyUp"", ""if ((_this select 1) == 199) then {createDialog 'RscDisplayDebugPublic';}""];};};";
	};
};
