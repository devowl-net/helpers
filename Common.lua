
Common = { };

function IsInsidePvpZone()
	local instance, instanceType = IsInInstance();
	if ( instance and instanceType == "pvp" ) then
		return true;
	end
	return false;
end



------------------------------------------------
-- явл€етс€ ли данный игрок участником текущей г
------------------------------------------------
function IsPlayerFromBattlegroundRaid(playerName)
	for i = 1, 40 do 

		-- http://wowwiki.wikia.com/wiki/API_GetRaidRosterInfo
		-- Gets information about a raid member.
		-- raidIndex 
		--     Number - Index of raid member between 1 and MAX_RAID_MEMBERS (40). If you specify an index that is out of bounds, the function returns nil. 
		-- Returns
		-- name
		--     String - raid member's name. In cross-realm battlegrounds, returns "Name-Server" for cross-realm players. 
		-- rank
		--     Integer - Returns 2 if the raid member is the leader of the raid, 1 if the raid member is promoted to assistant, and 0 otherwise. 
		-- subgroup
		--     Integer - The raid party this character is currently a member of. Raid subgroups are numbered as on the standard raid window. 
		-- level
		--     Number - The level of the character. If this character is offline, the level will show as 0 (not nil). 
		-- class
		--     String - The character's class (localized), with the first letter capitalized (e.g. "Priest"). This function works as normal for offline characters. 
		-- fileName
		--     String - The system representation of the character's class; always in english, always fully capitalized. 
		-- zone
		--     String - The name of the zone this character is currently in. This is the value returned by GetRealZoneText. It is the same value you see if you mouseover their portrait (if in group). If the character is offline, this value will be the string "Offline". 
		--     BUG (as of 6/07/2013): Sometimes values are different, example: Thron des Donners and Der Thron des Donners. 
		--     BUG (as of 2/26/2005): It seems that the person calling this function will have their Zone value returned as nil if they have not changed locations since last reloading their UI. Once you change locations (get the name to popup on screen), it seems to return as normal. This only seems to affect when you look at the zone value of yourself from the raid. Could a call to SetMapToCurrentZone() cure this? 
		--     You should use functions categorised under Location Functions for getting your own location text --Salanex 
		--     Possible values: nil, "Offline", any valid location 
		-- online
		--     Boolean - Returns 1 if raid member is online, nil otherwise. 
		-- isDead
		--     Boolean - Returns 1 if raid member is dead (hunters Feigning Death are considered alive), nil otherwise. 
		-- role
		--     String - The player's role within the raid ("maintank" or "mainassist"). 
		-- isML
		--     Boolean - Returns 1 if the raid member is master looter, nil otherwise 
		local name, _ = GetRaidRosterInfo(i);
		
		if name == playerName then 
			return true;
		end;
	end;

	return false
end

function IsPlayerInRaid()
	return 
		-- http://wowprogramming.com/docs/api/UnitInParty
		-- Returns whether a unit is a player unit in the player's party. Always returns 1 for the player unit. 
		-- Returns nil for the player's or party members' pets.
		UnitInParty("player") 
		and 
		-- http://wowwiki.wikia.com/wiki/API_UnitInRaid
		-- Returns a number if the unit is in your raid group, nil otherwise. 
		UnitInRaid("player") ~= nil
end

function IsPlayerLeader() 
	-- http://wowwiki.wikia.com/wiki/API_UnitIsGroupLeader
	-- Returns true if the unit is leader party or raid group, false otherwise. 
	return UnitIsGroupLeader("player")
end

-- ѕризнак того что поле бо€ уже идЄт.
function IsBattlegroundGoing()

	for i = 1, GetNumBattlefieldScores() do 
		-- http://wowprogramming.com/docs/api/GetBattlefieldScore
		local name, 
			killingBlows, 
			honorableKills, 
			deaths, 
			honorGained, 
			faction, 
			rank, 
			race, 
			class = GetBattlefieldScore(i);
		if honorableKills ~= 0 then
			return true
		end
	end

	return false
end