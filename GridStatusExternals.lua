------------------------------------------------------------------------------
-- GridStatusExternals
-- Old Tank Status Cool Downs by Slaren Rezed By Doadin
------------------------------------------------------------------------------
GridStatusExternals = Grid:GetModule("GridStatus"):NewModule("GridStatusExternals")
GridStatusExternals.menuName = "Tanking cooldowns"

local tankingbuffs = {
	["DEATHKNIGHT"] = {
		48707, -- Anti-Magic Shell
		50461, -- Anti-Magic Zone
		77535, -- Blood Shield		
		195181, -- Bone Shield
		49028, -- Dancing Rune Weapon
		48792, -- Icebound Fortitude
		55233, -- Vampiric Blood
	},
	["DEMONHUNTER"] = {
		198589, -- Blur
		209426,  -- Darkness
		203720,  -- Demon Spikes
		187827,  -- Metamorphosis
		207810,  -- Nether Bond
	},
	["DRUID"] = {
		22812,  -- Barkskin
		102342, -- Ironbark
		192081, -- Ironfur
		105737, -- Mass Regeneration (tier bonus)
		61336,  -- Survival Instincts
        740,    -- Tranquility
	},
	["HUNTER"] = {
		186265,  -- Aspect of the Turtle
		19263,  -- Deterrence
	},
	["MAGE"] = {
		157913, -- Evanesce
		11426,  -- Ice Barrier
		45438,  -- Ice Block
		113862, -- Greater Invisibility
	},
	["MONK"] = {
		122278, -- Dampen Harm
		122783, -- Diffuse Magic
		115308, -- Elusive Brew
		115203, -- Fortifying Brew
		116849, -- Life Cocoon
		115176, -- Zen Meditation
	},
	["PALADIN"] = {
        204150,  -- Aegis of Light
		31850,  -- Ardent Defender
		183415,  -- Aura of Mercy
		183416,  -- Aura of Sacrifice
		1044,  -- Blessing of Freedom
		1022,   -- Blessing of Protection
		6940,   -- Blessing of Sacrifice
		204018,  -- Blessing of Spellwarding
		210320,  -- Devotion Aura
		498,    -- Divine Protection
		642,    -- Divine Shield
		86659,  -- Guardian of Ancient Kings
		152261, -- Holy Shield
		132403, -- Shield of the Righteous
		184662, -- Shield of Vengeance
	},
	["PRIEST"] = {
		47585,  -- Dispersion
		64843,  -- Divine Hymn
		47788,  -- Guardian Spirit
		33206,  -- Pain Suppression
		81782,  -- Power Word: Barrier
		15286,  -- Vampiric Embrace
	},
	["ROGUE"] = {
		31224,  -- Cloak of Shadows
		5277,   -- Evasion
		1966,   -- Feint
		76577,  -- Smoke Bomb
	},
	["SHAMAN"] = {
		207399, -- Ancestral Protection Totem
		108271, -- Astral Shift
		98008,  -- Spirit Link Totem
		114893, -- Stone Bulwark Totem
	},
	["WARLOCK"] = {    
		108359, -- Dark Regeneration
		212295, -- Nether Ward
		108416, -- Dark Pact
		104773, -- Unending Resolve
	},
	["WARRIOR"] = {
		118038, -- Die by the Sword
		190456, -- Ignore Pain
		12975,  -- Last Stand
		97463,  -- Commanding Shout
		122973, -- Safeguard	
		2565,   -- Shield Block
		871,    -- Shield Wall
		23920,  -- Spell Reflection
		114030, -- Vigilance
	}
}

GridStatusExternals.tankingbuffs = tankingbuffs

-- locals
local GridRoster = Grid:GetModule("GridRoster")
local GetSpellInfo = GetSpellInfo
local UnitBuff = UnitBuff
local UnitDebuff = UnitDebuff
local UnitGUID = UnitGUID

local settings
local spellnames = {}

GridStatusExternals.defaultDB = {
	debug = false,
	alert_externals = {
		enable = true,
		color = { r = 1, g = 1, b = 0, a = 1 },
		priority = 99,
		range = false,
		showtextas = "caster",
		active_spellids =  { -- default spells
			31850,	-- Ardent Defender
			86659,	-- Guardian of Ancient Kings
			47788,	-- Guardian Spirit
			6940, 	-- Hand of Sacrifice
			48792, 	-- Icebound Fortitude
			33206,	-- Pain Suppression
			871,	-- Shield Wall
			61336,	-- Survival Instincts
			115203, -- Fortifying Brew
		},
		inactive_spellids = { -- used to remember priority of disabled spells
		}
	}
}

local myoptions = {
	["GSE_header_1"] = {
		type = "header",
		order = 200,
		name = "Options",
	},
	["showtextas"] = {
		order = 201,
		type = "select",
		name = "Show text as",
		desc = "Text to show when assigned to an indicator capable of displaying text",
		values = { ["caster"] = "Caster name", ["spell"] = "Spell name" },
		style = "radio",
		get = function() return GridStatusExternals.db.profile.alert_externals.showtextas end,
		set = function(_, v) GridStatusExternals.db.profile.alert_externals.showtextas = v end,
	},
	["GSE_header_2"] = {
		type = "header",
		order = 203,
		name = "Spells",
	},
	["spells_description"] = {
		type = "description",
		order = 204,
		name = "Check the spells that you want GridStatusExternals to keep track of. Their position on the list defines their priority in the case that a unit has more than one of them.",
	},
	["spells"] = {
		type = "input",
		order = 205,
		name = "Spells",
		control = "GSE-SpellsConfig",
	},
}

function GridStatusExternals:OnInitialize()
	self.super.OnInitialize(self)
	
	for class, buffs in pairs(tankingbuffs) do
		for _, spellid in pairs(buffs) do
			local sname = GetSpellInfo(spellid)
			if not sname then print(spellid, ": Bad spellid") end
			spellnames[spellid] = sname or tostring(spellid)
		end
	end
	
	self:RegisterStatus("alert_externals", "External cooldowns", myoptions, true)

	settings = self.db.profile.alert_externals

	-- delete old format settings
	if settings.spellids then
		settings.spellids = nil
	end
	
	-- remove old spellids
	for p, aspellid in ipairs(settings.active_spellids) do
		local found = false
		for class, buffs in pairs(tankingbuffs) do
			for _, spellid in pairs(buffs) do
				if spellid == aspellid then
					found = true
					break
				end				
			end
		end
		
		if not found then
			table.remove(settings.active_spellids, p)
		end
		
		-- remove duplicates
		for i = #settings.active_spellids, p + 1, -1 do
			if settings.active_spellids[i] == aspellid then
				table.remove(settings.active_spellids, i)
			end
		end
	end
end

function GridStatusExternals:OnStatusEnable(status)
	if status == "alert_externals" then
		self:RegisterEvent("UNIT_AURA", "ScanUnit")
		self:RegisterEvent("Grid_UnitJoined")
		-- self:ScheduleRepeatingEvent("GridStatusExternals:UpdateAllUnits", self.UpdateAllUnits, 0.5, self)
		self:UpdateAllUnits()
	end
end

function GridStatusExternals:OnStatusDisable(status)
	if status == "alert_externals" then
		self:UnregisterEvent("UNIT_AURA")
		self:UnregisterEvent("Grid_UnitJoined")

		--self:CancelScheduledEvent("GridStatusExternals:UpdateAllUnits")
		self.core:SendStatusLostAllUnits("alert_externals")
	end
end

function GridStatusExternals:Grid_UnitJoined(guid, unitid)
	self:ScanUnit("Grid_UnitJoined", unitid, guid)
end

function GridStatusExternals:UpdateAllUnits()
	for guid, unitid in GridRoster:IterateRoster() do
		self:ScanUnit("UpdateAllUnits", unitid, guid)
	end
end

function GridStatusExternals:ScanUnit(event, unitid, unitguid)
	unitguid = unitguid or UnitGUID(unitid)
	if not GridRoster:IsGUIDInRaid(unitguid) then
		return
	end

	for _, spellid in ipairs(settings.active_spellids) do
		local name, _, icon, count, _, duration, expirationTime, caster = UnitBuff(unitid, spellnames[spellid])
		
		-- Used to check for debuffs when Argent Defender was a debuff - it is not necessary anymore
		--[[
		if not name then
			name, _, icon, count, _, duration, expirationTime, caster = UnitDebuff(unitid, spellnames[spellid])
		end
		]]

		if name then
			local text 
			if settings.showtextas == "caster" then
				if caster then
					text = UnitName(caster)
				end
			else
				text = name
			end

			self.core:SendStatusGained(unitguid, 
						"alert_externals",
						settings.priority,
						(settings.range and 40),
						settings.color,
						text,
						0,							-- value
						nil,						-- maxValue
						icon,						-- icon
						expirationTime - duration,	-- start
						duration,					-- duration
						count)						-- stack
			return
		end
	end

	self.core:SendStatusLost(unitguid, "alert_externals")
end
