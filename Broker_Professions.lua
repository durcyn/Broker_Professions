local _G = getfenv(0)
local LibStub = _G.LibStub
local GetSpellInfo = _G.GetSpellInfo
local pairs = _G.pairs
local select = _G.select

local primary = {
	(GetSpellInfo(2259)), -- Alchemy
	(GetSpellInfo(2018)), -- Blacksmithing
	(GetSpellInfo(7411)), -- Enchanting
	(GetSpellInfo(4036)), -- Engineering
	(GetSpellInfo(25229)), -- Jewelcrafting
	(GetSpellInfo(2108)), -- Leatherworking
	(GetSpellInfo(2656)), -- Smelting
	(GetSpellInfo(3908)), -- Tailoring
	(GetSpellInfo(53428)), -- Runeforging
	(GetSpellInfo(45357)), -- Inscription
}

local secondary = {
	(GetSpellInfo(78670)), -- Archaeology
	(GetSpellInfo(2550)), -- Cooking
	(GetSpellInfo(3273)), -- First Aid
}

local f = CreateFrame("Frame")
f:Hide()
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("SPELLS_CHANGED")
f:SetScript("OnEvent", function(self, event, ...)
	self[event](self, ...)
end)

function f:Update()
	local counter = 1
	for k,v in pairs(primary) do
		local icon = select(3, GetSpellInfo(v))
		if icon then
			f:create(v, icon, counter)
			counter = counter + 1
		end
	end

	for k,v in pairs(secondary) do
		local icon = select(3, GetSpellInfo(v))
		if icon then
			f:create(v, icon)
		end
	end
end

function f:SPELLS_CHANGED()
	f:Update()
end

function f:PLAYER_ENTERING_WORLD()
	f:Update()
end

function f:create(spell, icon, index)
	local prof = ("Profession_%s"):format(index or spell)
	if not f[prof] then
		f[prof] = LibStub("LibDataBroker-1.1"):NewDataObject(prof, {type = "launcher", label = prof, icon = icon})
	end
	if f[prof].icon ~= icon then f[prof].icon = icon end
	if f[prof].label ~= prof then f[prof].label = prof end
	f[prof].OnClick = function() CastSpellByName(spell) end
end
