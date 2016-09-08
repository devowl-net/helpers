
PH = {};

function PH:Test()
end

function PHFormat(message, markType)

	local mark = "circle"
	if markType ~= nil then
		mark = markType
	end

	local result = __merge("[PH]", message)

	-- {крест} [PH] Test {крест}
	return __merge(_L.Marks[mark], result, _L.Marks[mark])
end

function PHSayInstance(message, markType)

	-- Hook here
	SendChatMessage(PHFormat(message, markType), "INSTANCE_CHAT" )
end
