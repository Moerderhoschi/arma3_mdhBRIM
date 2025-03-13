///////////////////////////////////////////////////////////////////////////////////////////////////
// MDH BOHEMIA REVIVE ICON MARKER MOD(by Moerderhoschi) - v2025-03-13
// github: https://github.com/Moerderhoschi/arma3_mdhBRIM
// steam mod version: https://steamcommunity.com/sharedfiles/filedetails/?id=753249732
///////////////////////////////////////////////////////////////////////////////////////////////////
if (missionNameSpace getVariable ["pMdhBRIM",99] == 99) then
{
	if (hasInterface) then
	{
		///////////////////////////////////////////////////////////////////////////////////////////////////
		// DIARYRECORD
		///////////////////////////////////////////////////////////////////////////////////////////////////
		0 spawn
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
							+ '<img image="mdhBrim\brimIconX.paa"/>'
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
			_sleep = 1.8;
			uiSleep _sleep;
			while {missionNameSpace getVariable ["pMdhBRIM",99] == 99} do
			{
				call _diary;
				sleep 10 + _sleep;
			};
		};
	};

	if (hasInterface) then
	{
		///////////////////////////////////////////////////////
		// mdhFunction
		///////////////////////////////////////////////////////
		0 spawn
		{
			_mdhFunction =
			{
				///////////////////////////////////////////////////////
				// addMissionEventHandler
				///////////////////////////////////////////////////////
				if (isNil"mdhBRIMmissionEH") then
				{
					mdhBRIMmissionEH = true;
					addMissionEventHandler
					[
						"Draw3D",
						{
							{
								_mdhBRIMalreadySet = (_x getVariable ["mdhBRIMset",false]);
								_side = (_x getVariable ["mdhBRIMside",east]);
								if ( _mdhBRIMalreadySet && {alive _x} && {side player getFriend _side > 0.5} && {(lifeState _x) == "INCAPACITATED"} ) then
								{
									_dist = player distance _x;
									if (_dist < 200) then
									{
										_pos = getPosATLVisual _x;
										_pos set [2, (_pos select 2) + 1 + (_dist * 0.05)];
										drawIcon3D ["mdhBrim\brimIconX.paa", [1,0,0,1 - (_dist / 200)], _pos, 1, 1, 0, "(Uncon) " + name _x, 1, 0.032 - (_dist / 9000), "RobotoCondensed"];
									}
								}
							} forEach allPlayers;
						}
					];
				};

				{deleteMarkerLocal _x} forEach _markers;
				{
					_mdhBRIMalreadySet = (_x getVariable ["mdhBRIMset",false]);
					if (!_mdhBRIMalreadySet) then				
					{
						if ( _x != player && {alive _x} && {!((lifeState _x) == "INCAPACITATED")} ) then
						{
							_x setVariable ["mdhBRIMset",true];
							_x setVariable ["mdhBRIMside",(side _x)];
						};				
					}
					else
					{
						_side = (_x getVariable ["mdhBRIMside",east]);
						if (side player getFriend _side > 0.5 && {alive _x} && {(lifeState _x) == "INCAPACITATED"}) then
						{
							_marker = createMarkerLocal ["mdhBRIMmarker_" + format["%1",_forEachIndex], position _x];
							_markers pushBack _marker;
							_marker setMarkerShapeLocal "ICON";
							_marker setMarkerTypeLocal "hd_dot";
							_marker setMarkerTextLocal ("(Uncon) " + name _x);
							_marker setMarkerColorLocal "ColorBLUE";
						};
					};
				} forEach allPlayers;

				///////////////////////////////////////////////////////
				// loop
				///////////////////////////////////////////////////////
				sleep (3 + random 2);
				_markers = [];
				while {missionNameSpace getVariable ["pMdhBRIM",99] == 99} do
				{
					call _mdhFunction;
					sleep 10;
					sleep random 1;
				};			
				{deleteMarkerLocal _x} forEach _markers;
			};
		};
	};
};