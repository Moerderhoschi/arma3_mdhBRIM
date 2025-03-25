///////////////////////////////////////////////////////////////////////////////////////////////////
// MDH BOHEMIA REVIVE ICON MARKER MOD(by Moerderhoschi) - v2025-03-16
// github: https://github.com/Moerderhoschi/arma3_mdhBRIM
// steam mod version: https://steamcommunity.com/sharedfiles/filedetails/?id=753249732
///////////////////////////////////////////////////////////////////////////////////////////////////
if (missionNameSpace getVariable ["pMdhBRIM",99] == 99 && {isMultiplayer}) then
{
	0 spawn
	{
		_valueCheck = 99;
		_defaultValue = 99;
		_env  = hasInterface;

		_diary  = 0;
		_mdhFnc = 0;
		//_icon = "\a3\ui_f\data\Map\MarkerBrushes\cross_ca.paa";
		//_icon = "\a3\ui_f\data\GUI\Cfg\Cursors\add_gs.paa";
		//_icon = "\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\icon_cross_ca.paa";
		_icon = "\a3\3den\Data\CfgWaypoints\support_ca.paa";

		if (hasInterface) then
		{
			_diary =
			{
				waitUntil {!(isNull player)};
				_c = true;
				_t = "Bohemia Revive Icon Marker";
				if (player diarySubjectExists "MDH Mods") then
				{
					{
						if (_x#1 == _t) exitWith {_c = false}
					} forEach (player allDiaryRecords "MDH Mods");
				}
				else
				{
					player createDiarySubject ["MDH Mods","MDH Mods"];
				};
		
				if(_c) then
				{
					player createDiaryRecord
					[
						"MDH Mods",
						[
							_t,
							(
							  '<br/>Bohemia Revive Icon Marker is a mod, created by Moerderhoschi for Arma 3, to add an icon and Mapmarker to unconscious players. '
							+ 'If you have any question you can contact me at the steam workshop page.<br/>'
							+ '<br/>'
							+ '<img image="'+_icon+'"/>'
							+ '<br/>'
							+ '<br/>'
							+ 'Credits and Thanks:<br/>'
							+ 'Xeno - sharing his code and knowledge to realize this addon<br/>'
							+ 'Armed-Assault.de Crew - For many great ArmA moments in many years<br/>'
							+ 'BIS - For ArmA3<br/>'
							)
						]
					]
				};
				true
			};
		};

		if (_env) then
		{
			_mdhFnc =
			{
				///////////////////////////////////////////////////////
				// addMissionEventHandler
				///////////////////////////////////////////////////////
				if (isNil"mdhBRIMmissionEH") then
				{
					mdhBRIMmissionEH = addMissionEventHandler
					[
						"Draw3D",
						{
							{
								if (_x != player && {alive _x} && {side group player getFriend side group _x > 0.5} && {(lifeState _x) == "INCAPACITATED"} ) then
								{
									_dist = player distance _x;
									if (_dist < 200) then
									{
										_pos = getPosATLVisual _x;
										_pos set [2, (_pos select 2) + 1 + (_dist * 0.05)];
										//_icon = "\a3\ui_f\data\Map\MarkerBrushes\cross_ca.paa";
										//_icon = "\a3\ui_f\data\GUI\Cfg\Cursors\add_gs.paa";
										//_icon = "\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\icon_cross_ca.paa";
										_icon = "\a3\3den\Data\CfgWaypoints\support_ca.paa";
										drawIcon3D [_icon, [1,0,0,1 - (_dist / 200)], _pos, 1, 1, 0, "(Uncon) " + name _x, 1, 0.032 - (_dist / 9000), "RobotoCondensed"];
									}
								}
							} forEach allPlayers;
						}
					];
				};

				if (missionNameSpace getVariable ["pPlayerMapMarkers",0] == 0) then
				{
					{deleteMarkerLocal _x} forEach _markers;
					{
						if (side group player getFriend side group _x > 0.5 && {alive _x} && {(lifeState _x) == "INCAPACITATED"}) then
						{
							_marker = createMarkerLocal ["mdhBRIMmarker_" + format["%1",_forEachIndex], position _x];
							_markers pushBack _marker;
							_marker setMarkerShapeLocal "ICON";
							_marker setMarkerTypeLocal "hd_dot";
							_marker setMarkerTextLocal ("(Uncon) " + name _x);
							_marker setMarkerColorLocal "ColorBLUE";
						};
					} forEach allPlayers;
				};
			};
		};

		if (hasInterface) then
		{
			uiSleep 1.8;
			call _diary;
		};

		_markers = [];
		sleep (5 + random 2);
		while {missionNameSpace getVariable ["pMdhBRIM",_defaultValue] == _valueCheck} do
		{
			if (_env) then {call _mdhFnc};
			sleep (4 + random 2);
			if (hasInterface) then {call _diary};
		};
		{deleteMarkerLocal _x} forEach _markers;
	};
};