local Professions = {}

local tradeskills = {
	(GetSpellInfo(2259)), -- Alchemy
	(GetSpellInfo(2018)), -- Blacksmithing
	(GetSpellInfo(2550)), -- Cooking
	(GetSpellInfo(7411)), -- Enchanting
	(GetSpellInfo(4036)), -- Engineering
	(GetSpellInfo(3273)), -- First Aid
	(GetSpellInfo(25229)), -- Jewelcrafting
	(GetSpellInfo(2108)), -- Leatherworking
	(GetSpellInfo(2656)), -- Smelting
	(GetSpellInfo(2842)), -- Poisons
	(GetSpellInfo(3908)), -- Tailoring
	(GetSpellInfo(53428)), -- Runeforging
	(GetSpellInfo(45357)), -- Inscription
}

local eventFrame = CreateFrame("Frame")
eventFrame:Hide()
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
eventFrame:SetScript("OnEvent", function() Professions:Update() end)

function Professions:Update()
	for k,v in pairs(tradeskills) do
		if GetSpellInfo(v) then
			local myicon = select(3, GetSpellInfo(v))
			Professions[v] = LibStub("LibDataBroker-1.1"):NewDataObject(v,	{
				type = "launcher",
				icon = myicon,
				OnClick = function() CastSpellByName(v) end,
			})
		end
	end
end
