-- Перевод в строчку значения
function __tostring(obj)
	if obj == nil then
		return "nil"
	else
		return tostring(obj)
	end
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
