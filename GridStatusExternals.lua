------------------------------------------------------------------------------
-- GridStatusExternals
-- Old Tank Status Cool Downs by Slaren Rezed By Doadin
------------------------------------------------------------------------------
local isClassic = (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC)
if (IsAddOnLoaded("Grid")) then
    local GridStatusExternals = Grid:GetModule("GridStatus"):NewModule("GridStatusExternals")  --luacheck: ignore 211
end

if (IsAddOnLoaded("Plexus")) then
    local GridStatusExternals = Plexus:GetModule("PlexusStatus"):NewModule("GridStatusExternals")  --luacheck: ignore 211
end
GridStatusExternals.menuName = "Tanking cooldowns"  --luacheck: ignore 112
--@retail@
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
        105737, -- Might of Ursoc (Mass Regeneration tier bonus)
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
        243435, -- Fortifying Brew
        116849, -- Life Cocoon
        124275, -- Light Stagger
        124274, -- Moderate Stagger
        124273, -- Heavy Stagger
        115176, -- Zen Meditation
    },
    ["PALADIN"] = {
        31850,   -- Ardent Defender
        1044,    -- Blessing of Freedom
        1022,    -- Blessing of Protection
        6940,    -- Blessing of Sacrifice
        204018,  -- Blessing of Spellwarding
        465,     -- Devotion Aura
        498,     -- Divine Protection
        642,     -- Divine Shield
        86659,   -- Guardian of Ancient Kings
        132403,  -- Shield of the Righteous
        184662,  -- Shield of Vengeance
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
--@end-retail@

--[===[@non-retail@
local tankingbuffs = {
    ["DRUID"] = {
        22812,  -- Barkskin
        102342, -- Ironbark
        192081, -- Ironfur
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
    ["PALADIN"] = {
        31850,   -- Ardent Defender
        1044,    -- Blessing of Freedom
        1022,    -- Blessing of Protection
        6940,    -- Blessing of Sacrifice
        204018,  -- Blessing of Spellwarding
        465,     -- Devotion Aura
        498,     -- Divine Protection
        642,     -- Divine Shield
        86659,   -- Guardian of Ancient Kings
        132403,  -- Shield of the Righteous
        184662,  -- Shield of Vengeance
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
--@end-non-retail@]===]

GridStatusExternals.tankingbuffs = tankingbuffs --luacheck: ignore 112

-- locals
if (IsAddOnLoaded("Grid")) then
local GridRoster = Grid:GetModule("GridRoster") --luacheck: ignore 211
end

if (IsAddOnLoaded("Plexus")) then
local GridRoster = Plexus:GetModule("PlexusRoster") --luacheck: ignore 211
end
local GetSpellInfo = GetSpellInfo
local UnitBuff = UnitBuff
local UnitGUID = UnitGUID

local settings
local spellnames = {} --luacheck: ignore 241
local spellid_list = {}

--@retail@
GridStatusExternals.defaultDB = { --luacheck: ignore 112
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
            243435, -- Fortifying Brew
        },
        inactive_spellids = { -- used to remember priority of disabled spells
        }
    }
}
--@end-retail@

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
        set = function(_, v) GridStatusExternals.db.profile.alert_externals.showtextas = v end, --luacheck: ignore 112
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

function GridStatusExternals:OnInitialize() --luacheck: ignore 112
    self.super.OnInitialize(self)

    for class, buffs in pairs(tankingbuffs) do --luacheck: ignore 213
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
        for class, buffs in pairs(tankingbuffs) do --luacheck: ignore 213
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
    self:UpdateAuraScanList()
end

function GridStatusExternals:UpdateAuraScanList() --luacheck: ignore 212 112
    spellid_list = {}

    for _, spellid in ipairs(settings.active_spellids) do
        spellid_list[spellid] = true
    end
end

function GridStatusExternals:OnStatusEnable(status) --luacheck: ignore 112
    if status == "alert_externals" then
        self:RegisterEvent("UNIT_AURA", "ScanUnit")
        self:RegisterEvent("GROUP_ROSTER_UPDATE", "Grid_UnitJoined")
        self:UpdateAllUnits()
    end
end

function GridStatusExternals:OnStatusDisable(status) --luacheck: ignore 112
    if status == "alert_externals" then
        self:UnregisterEvent("UNIT_AURA")
        self:UnregisterEvent("GROUP_ROSTER_UPDATE")
        self.core:SendStatusLostAllUnits("alert_externals")
    end
end

function GridStatusExternals:Grid_UnitJoined(guid, unitid) --luacheck: ignore 112
    self:ScanUnit("Grid_UnitJoined", unitid, guid)
end

function GridStatusExternals:UpdateAllUnits() --luacheck: ignore 112
    for guid, unitid in GridRoster:IterateRoster() do
        self:ScanUnit("UpdateAllUnits", unitid, guid)
    end
    self:UpdateAuraScanList()
end

function GridStatusExternals:ScanUnit(_, unitid, unitguid) --luacheck: ignore 112
    if not unitguid then unitguid = UnitGUID(unitid) end
    if not GridRoster:IsGUIDInRaid(unitguid) then
        return
    end

    for i =1, 40 do
        local name, uicon, count, _, duration, expirationTime, _, _, _, spellId = UnitBuff(unitid, i)
        if not spellId then
            break
        end

        if spellid_list[spellId] then
            local text
            if settings.showtextas == "caster" then
                if caster then
                    text = UnitName(caster)
                end
            else
                if not name then
                    break
                else
                    text = name
                end
            end

            self.core:SendStatusGained(unitguid,
                        "alert_externals",
                        settings.priority,
                        (settings.range and 40),
                        settings.color,
                        text,
                        0,							-- value
                        nil,						-- maxValue
                        uicon,						-- icon
                        expirationTime - duration,	-- start
                        duration,					-- duration
                        count)						-- stack
            return
        end
    end

    self.core:SendStatusLost(unitguid, "alert_externals")
end
