Api = {};

Api.CombatLogs = {
	"SWING",
	"RANGE",
	"SPELL",
	--"SPELL_PERIODIC", 
	"SPELL_BUILDING",
	"ENVIRONMENTAL"
};

function Api.NewFrame(workCallback, ...)
	local frame =  CreateFrame("Frame");
	frame["Subscribe"] = Api.Subscribe
		-- ������� �� ������� ������������� ������������
	frame.Events = ...
	frame["WorkCallback"] = workCallback
	
	combatLog = false
	Api.__Enumerate(frame, Api.CombatLogs,
		function(self, combatEventName)
			Api.__Enumerate(self, self.Events,
				function(self, eventName)
					if(string.sub(eventName,1,string.len(combatEventName)) == combatEventName) then
						combatLog = true
					end
				end)
		end)
	
	frame.Internal_Events = {};
	if combatLog then
		-- ������� ������� ����� ��� �� ������� �� ������� �� ����������� ����
		-- http://wowwiki.wikia.com/wiki/API_COMBAT_LOG_EVENT
		frame.Internal_Events = { "COMBAT_LOG_EVENT_UNFILTERED" }
	end
	
	frame["Unsubscribe"] = Api.Unsubscribe
	frame["__Enumerate"] = Api.__Enumerate
	return frame
end

function eventHandler(self, eventName, ...)
	if eventName == nil then return end

	if self.Events[eventName] and EventWorks(self) then
		FireEvent(self, eventName, ...)
	elseif self.Internal_Events[eventName] then
		FireUnfilteredEvent(self, eventName, ...)
	end
end

function EventWorks(self)
	return self.WorkCallback ~= nil and self.WorkCallback() == true
end

function FireUnfilteredEvent(self, eventName, param1, param2, ...)
	-- ���������������
	-- param1 - timestamp
	-- param2 - ��� �������
	eventName = param2
	
	if self.Events[eventName] and EventWorks(self) then
		self[eventName](self, ...)
	end
	
end

function FireEvent(self, eventName, ...)
	-- ������� �������
	self[eventName](self, ...)
end

function IsUnfiltered(eventName)
	return not eventName == nil and string.find(eventName, "UNFILTERED") ~= nil
end

-- ��������
function Api:Subscribe()
	self:SetScript("OnEvent", eventHandler);
	
	-- ���������������� �������
	Api.__Enumerate(self, self.Events, 
		function(self, eventName)
			self:RegisterEvent(eventName); 
			self.Events[eventName] = true
			--if not self:IsEventRegistered(eventName) then
			--	print("(-) Not subscripted on " .. eventName)
			--else
			--	print("(+) subscripted on " .. eventName)
			--end
		end)

	-- ���������� �������
	self:__Enumerate(self.Internal_Events, 
		function(self, eventName)
			self:RegisterEvent(eventName); 
			self.Internal_Events[eventName] = true
		end)
end

-- �������
function Api.Unsubscribe()
end

-- ������������
function Api:__Enumerate(sourceTable, callback)
	for f, t in ipairs( sourceTable ) do
		local functionName = t
		callback(self, functionName)
	end
end
