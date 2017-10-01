
PH = {};

function PH:Test()
end

function PHFormat(message, markType)

	local mark = "circle"
	if markType ~= nil then
		mark = markType
	end

	local result = __merge("[PH]", message)
	return __merge(_L.Marks[mark], result, _L.Marks[mark])
end

local lastMessage = nil
function PHSayInstance(message, markType, isWarning)

	if message == lastMessage then
		return
	end

	lastMessage = message

	--!!!!!!!!!!
	--print(PHFormat(message, markType))
	-- Hook here
	
	local chat = "INSTANCE_CHAT"
	if isWarning then
		chat = "RAID_WARNING"
	end
	
	SendChatMessage(PHFormat(message, markType), chat )
end

function PHSay(message, markType)
	--print(PHFormat(message, markType))
	-- Hook here
	SendChatMessage(PHFormat(message, markType), "SAY" )
end

function __merge(str1, str2, str3)
-- TODO на ... сделать
	local result = ""
	if str1 ~= nil then
		result = __tostring(str1) 
	end

	if str2 ~= nil then
		result = result .. " " .. __tostring(str2)
	end
	
	if str3 ~= nil then
		result = result .. " " .. __tostring(str3)
	end

	return result
end

-- Вывод параметров
function __unpackToString(...)
	local result = ""
	local args = { params = select("#", ...), ... }
	for i = 1, args.params do
      result = result ..tostring(i)..") ".. tostring(args[i]) .. " | "
	end
	return result
end

function __tostring(obj)
	if obj == nil then
		return "nil"
	else
		return tostring(obj)
	end
end