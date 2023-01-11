local f = CreateFrame("Frame")

function string.starts(String,Start)
	return string.sub(String,1,string.len(Start))==Start
 end

local function OnEvent(self, event, ...)
	if(string.starts(event, 'CHAT_MSG')) then
		CHAT_MSG(event, ...)
	else
		self[event](self, event, ...)
	end
end

function f:ADDON_LOADED(event, addOnName)
	if(addOnName == 'MSGChatFXAddon') then
		print("Alert Effect loaded!")
	end
end

function CHAT_MSG(event, text, ...)
	if (text == '!!!') then
		PlaySoundFile("Interface\\AddOns\\MSGChatFXAddon\\alert.mp3", "Effects")
	end
end


local allBinds = 
{
	"ADDON_LOADED", "CHAT_MSG_CHANNEL", "CHAT_MSG_SAY", "CHAT_MSG_WHISPER", "CHAT_MSG_PARTY", "CHAT_MSG_PARTY_LEADER", "CHAT_MSG_YELL", "CHAT_MSG_GUILD"
}

local testsBinds = {}
for _, bindName in ipairs(allBinds) do
	testsBinds[bindName] = f:RegisterEvent(bindName)
end

for k, v in pairs(testsBinds) do
	print("Testing " .. k)
	if(not v) then
		print("Failed to bind" .. k)
	end
end

f:SetScript("OnEvent", OnEvent)