class CfgPatches 
{
	class mdhBRIM
	{
		author = "Moerderhoschi";
		name = "BohemiaReviveIconMarker";
		url = "https://steamcommunity.com/sharedfiles/filedetails/?id=753249732";
		units[] = {};
		weapons[] = {};
		requiredVersion = 1.0;
		requiredAddons[] = {};
		version = "1.20160827";
		versionStr = "1.20160827";
		versionAr[] = {1,20160827};
		authors[] = {};
	};
};

class CfgFunctions
{
	class mdh
	{
		class mdhFunctions
		{
			class mdhBRIM
			{
				file = "mdhBRIM\init.sqf";
				postInit = 1;
			};
		};
	};
};

class CfgMods
{
	class mdhBRIM
	{
		dir = "@mdhBRIM";
		name = "BohemiaReviveIconMarker";
		picture = "mdhBrim\brimIconX.paa";
		hidePicture = "true";
		hideName = "true";
		actionName = "Website";
		action = "https://steamcommunity.com/sharedfiles/filedetails/?id=753249732";
	};
};