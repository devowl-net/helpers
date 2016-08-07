
Common = { };

function Common:IsInsidePvpZone()
	local instance, instanceType = IsInInstance();
	if ( instance and instanceType == "pvp" ) then
		return true;
	end
	return false;
end

function Common:FormatInstanceMessage(message)
	-- [PH] Test
	local result = __merge("[PH]", message)

	-- {крест} [PH] Test {крест}
	return __merge(_L.Marks["circle"], result, _L.Marks["circle"])
end

