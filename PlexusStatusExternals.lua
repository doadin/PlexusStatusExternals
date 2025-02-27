------------------------------------------------------------------------------
-- PlexusStatusExternals
-- Old Tank Status Cool Downs by Slaren Rezed By Doadin
-- WoW 10.0 New Aura Driver by Elnarfim
------------------------------------------------------------------------------

local function IsClassicWow() --luacheck: ignore 212
    return WOW_PROJECT_ID == WOW_PROJECT_CLASSIC
end

local function IsTBCWow() --luacheck: ignore 212
    return WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC and LE_EXPANSION_LEVEL_CURRENT == LE_EXPANSION_BURNING_CRUSADE
end

local function IsWrathWow() --luacheck: ignore 212
    return WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC and LE_EXPANSION_LEVEL_CURRENT == LE_EXPANSION_WRATH_OF_THE_LICH_KING
end

local function IsCataWow() --luacheck: ignore 212
    return WOW_PROJECT_ID == WOW_PROJECT_CATACLYSM_CLASSIC and LE_EXPANSION_LEVEL_CURRENT == LE_EXPANSION_CATACLYSM
end

local function IsRetailWow() --luacheck: ignore 212
    return WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
end

local PlexusStatusExternals = Plexus:GetModule("PlexusStatus"):NewModule("PlexusStatusExternals")  --luacheck: ignore 211
PlexusStatusExternals.menuName = "Tanking cooldowns"  --luacheck: ignore 112
local tankingbuffs
if IsRetailWow() then
tankingbuffs = {
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
        203819,  -- Demon Spikes
        187827,  -- Metamorphosis
        207810,  -- Nether Bond
    },
    ["DRUID"] = {
        22812,  -- Barkskin
        102351, -- Cenarion Ward
        102342, -- Ironbark
        192081, -- Ironfur
        105737, -- Might of Ursoc (Mass Regeneration tier bonus)
        61336,  -- Survival Instincts
        740,    -- Tranquility
    },
    ["EVOKER"] = {
        357170, -- Time Dilation
        363534, -- Rewind
        363916, -- Obsidian Scale
        374348, -- Renewing Blaze
        360827, -- Blistering Scales
    },
    ["HUNTER"] = {
        186265,  -- Aspect of the Turtle
        19263,  -- Deterrence
    },
    ["MAGE"] = {
        11426,  -- Ice Barrier
        235313, -- Blazing Barrier
        235450, -- Prismatic Barrier
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
end

if IsClassicWow() then
    tankingbuffs = {
        ["DRUID"] = {
            22812,  -- Barkskin
            740,    -- Tranquility
        },
        ["HUNTER"] = {
            19263,  -- Deterrence
        },
        ["MAGE"] = {
            11426,  -- Ice Barrier
            168, -- Frost Armor
        },
        ["PALADIN"] = {
            1044,    -- Blessing of Freedom
            1022,    -- Blessing of Protection
            6940,    -- Blessing of Sacrifice
            465,     -- Devotion Aura
            498,     -- Divine Protection
            642,     -- Divine Shield
        },
        ["PRIEST"] = {
            15286,  -- Vampiric Embrace
        },
        ["ROGUE"] = {
            5277,   -- Evasion
        },
        ["SHAMAN"] = {
        },
        ["WARLOCK"] = {
        },
        ["WARRIOR"] = {
            12975,  -- Last Stand
            2565,   -- Shield Block
            871,    -- Shield Wall
        }
    }
    end

if IsTBCWow() or IsWrathWow() or IsCataWow() then
tankingbuffs = {
    ["DRUID"] = {
        22812,  -- Barkskin
        740,    -- Tranquility
    },
    ["HUNTER"] = {
        19263,  -- Deterrence
    },
    ["MAGE"] = {
        11426,  -- Ice Barrier
        168, -- Frost Armor
    },
    ["PALADIN"] = {
        1044,    -- Blessing of Freedom
        1022,    -- Blessing of Protection
        6940,    -- Blessing of Sacrifice
        465,     -- Devotion Aura
        498,     -- Divine Protection
        642,     -- Divine Shield
    },
    ["PRIEST"] = {
        15286,  -- Vampiric Embrace
    },
    ["ROGUE"] = {
        5277,   -- Evasion
    },
    ["SHAMAN"] = {
    },
    ["WARLOCK"] = {
    },
    ["WARRIOR"] = {
        12975,  -- Last Stand
        2565,   -- Shield Block
        871,    -- Shield Wall
    }
}
end

PlexusStatusExternals.tankingbuffs = tankingbuffs --luacheck: ignore 112

-- locals
local PlexusRoster = Plexus:GetModule("PlexusRoster") --luacheck: ignore 211
local GetSpellInfo = C_Spell and C_Spell.GetSpellInfo and C_Spell.GetSpellInfo or GetSpellInfo
local UnitBuff = UnitBuff
local UnitGUID = UnitGUID
local GetAuraDataByAuraInstanceID
local ForEachAura
if IsRetailWow() then
    GetAuraDataByAuraInstanceID = C_UnitAuras.GetAuraDataByAuraInstanceID
    ForEachAura = AuraUtil.ForEachAura
end

local settings
local spellnames = {} --luacheck: ignore 241
local spellid_list = {}

if IsRetailWow() then
PlexusStatusExternals.defaultDB = { --luacheck: ignore 112
    debug = false,
    alert_externals = {
        enable = true,
        color = { r = 1, g = 1, b = 0, a = 1 },
        priority = 99,
        range = false,
        showtextas = "caster",
        active_spellids =  { -- default spells
            --86659,	-- Guardian of Ancient Kings
            --31850,	-- Ardent Defender
            --642,     -- Divine Shield
            --498,     -- Divine Protection
            --132403,  -- Shield of the Righteous
            --184662,  -- Shield of Vengeance
            --48792, 	-- Icebound Fortitude
            --195181, -- Bone Shield
            --48707, -- Anti-Magic Shell
            --49028, -- Dancing Rune Weapon
            --55233, -- Vampiric Blood
            --77535, -- Blood Shield
            --61336,	-- Survival Instincts
            --22812,  -- Barkskin
            --102351, -- Cenarion Ward
            --192081, -- Ironfur
            --102342, -- Ironbark
            --243435, -- Fortifying Brew
            --115308, -- Elusive Brew
            --122278, -- Dampen Harm
            --122783, -- Diffuse Magic
            --115176, -- Zen Meditation
            --871,	-- Shield Wall
            --12975,  -- Last Stand
            --23920,  -- Spell Reflection
            --190456, -- Ignore Pain
            --2565,   -- Shield Block
            --114030, -- Vigilance
            --187827,  -- Metamorphosis
            --203819,  -- Demon Spikes
            --209426,  -- Darkness
            --198589, -- Blur
            --97463,  -- Commanding Shout
            --740,    -- Tranquility
            --357170, -- Time Dilation
            --363534, -- Rewind
            --363916, -- Obsidian Scale
            --374348, -- Renewing Blaze
            --360827, -- Blistering Scales
            --64843,  -- Divine Hymn
            --207399, -- Ancestral Protection Totem
            --98008,  -- Spirit Link Totem
            --114893, -- Stone Bulwark Totem
            --81782,  -- Power Word: Barrier
            --50461, -- Anti-Magic Zone
            --15286,  -- Vampiric Embrace
            --47788,	-- Guardian Spirit
            --33206,	-- Pain Suppression
            --6940, 	-- Hand of Sacrifice
            --116849, -- Life Cocoon
            --124275, -- Light Stagger
            --124274, -- Moderate Stagger
            --124273, -- Heavy Stagger
            --118038, -- Die by the Sword
            --186265,  -- Aspect of the Turtle
            --45438,  -- Ice Block
            --11426,  -- Ice Barrier
            --235313, -- Blazing Barrier
            --235450, -- Prismatic Barrier
            --47585,  -- Dispersion
            --31224,  -- Cloak of Shadows
            --5277,   -- Evasion
            --1966,   -- Feint
            --76577,  -- Smoke Bomb
            --108271, -- Astral Shift
            --108416, -- Dark Pact
            --104773, -- Unending Resolve
            --1044,    -- Blessing of Freedom
            --1022,    -- Blessing of Protection
            --204018,  -- Blessing of Spellwarding
            --465,     -- Devotion Aura
        },
        inactive_spellids = { -- used to remember priority of disabled spells
        }
    }
}
end

if IsClassicWow() or IsTBCWow() or IsWrathWow() or IsCataWow() then
PlexusStatusExternals.defaultDB = { --luacheck: ignore 112
    debug = false,
    alert_externals = {
        enable = true,
        color = { r = 1, g = 1, b = 0, a = 1 },
        priority = 99,
        range = false,
        showtextas = "caster",
        active_spellids =  { -- default spells
            --871,    -- Shield Wall
            --12975, -- Last Stand
            --2565,   -- Shield Block
            --498, -- Divine Protection
            --642, -- Divine Shield
            --22812, -- Barkskin
            --740,    -- Tranquility
            --1022,    -- Blessing of Protection
            --6940,    -- Blessing of Sacrifice
            --1044,    -- Blessing of Freedom
            --465,   -- Devotion Aura
            --19263, -- Deterrence
            --11426,  -- Ice Barrier
            --168, -- Frost Armor
            --5277,   -- Evasion
            --15286,  -- Vampiric Embrace
        },
        inactive_spellids = { -- used to remember priority of disabled spells
        }
    }
}
end

local myoptions = {
    ["PSE_header_1"] = {
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
        get = function() return PlexusStatusExternals.db.profile.alert_externals.showtextas end,
        set = function(_, v) PlexusStatusExternals.db.profile.alert_externals.showtextas = v end, --luacheck: ignore 112
    },
    ["PSE_header_2"] = {
        type = "header",
        order = 203,
        name = "Spells",
    },
    ["spells_description"] = {
        type = "description",
        order = 204,
        name = "Check the spells that you want PlexusStatusExternals to keep track of. Their position on the list defines their priority in the case that a unit has more than one of them.",
    },
    ["spells"] = {
        type = "input",
        order = 205,
        name = "Spells",
        control = "PSE-SpellsConfig",
    },
}

function PlexusStatusExternals:OnInitialize() --luacheck: ignore 112
    self.super.OnInitialize(self)

    for class, buffs in pairs(tankingbuffs) do --luacheck: ignore 213
        for _, spellid in pairs(buffs) do
            local spellInfo = GetSpellInfo(spellid)
            local sname = spellInfo and spellInfo.name or nil
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

function PlexusStatusExternals:UpdateAuraScanList() --luacheck: ignore 212 112
    if settings.active_spellids == nil then
        return
    end
    spellid_list = {}

    for _, spellid in ipairs(settings.active_spellids) do
        spellid_list[spellid] = true
    end
end

function PlexusStatusExternals:OnStatusEnable(status) --luacheck: ignore 112
    if status == "alert_externals" then
        if IsRetailWow() then
            self:RegisterEvent("UNIT_AURA", "ScanUnitByAuraInfo")
        else
            self:RegisterEvent("UNIT_AURA", "ScanUnit")
        end
        self:RegisterMessage("Plexus_UnitJoined")
        self:UpdateAllUnits()
    end
end

function PlexusStatusExternals:OnStatusDisable(status) --luacheck: ignore 112
    if status == "alert_externals" then
        self:UnregisterEvent("UNIT_AURA")
        self:UnregisterMessage("Plexus_UnitJoined")
        self.core:SendStatusLostAllUnits("alert_externals")
    end
end

function PlexusStatusExternals:Plexus_UnitJoined(_, guid, unitid) --luacheck: ignore 112
    if IsRetailWow() then
        self:ScanUnitByAuraInfo(_, unitid, {isFullUpdate = true})
    end
    if IsClassicWow() or IsTBCWow() or IsWrathWow() then
        self:ScanUnit("Plexus_UnitJoined", unitid, guid)
    end
end

function PlexusStatusExternals:UpdateAllUnits() --luacheck: ignore 112
    for guid, unitid in PlexusRoster:IterateRoster() do
        if IsRetailWow() then
            self:ScanUnitByAuraInfo(_, unitid, {isFullUpdate = true})
        else
            self:ScanUnit("UpdateAllUnits", unitid, guid)
        end
    end
    self:UpdateAuraScanList()
end

local unitAuras
function PlexusStatusExternals:ScanUnitByAuraInfo(event, unit, updatedAuras)
    if not unit then return end
    local guid = UnitGUID(unit)
    if not guid then
        return
    end
    if not unitAuras then
        unitAuras = {}
    end
    if not PlexusRoster:IsGUIDInRaid(guid) then
        return
    end

    -- Full Update
    if updatedAuras and updatedAuras.isFullUpdate then
        local unitauraInfo = {}
        ForEachAura(unit, "HELPFUL", nil,
            function(aura)
                if aura and aura.auraInstanceID then
                    unitauraInfo[aura.auraInstanceID] = aura
                end
            end,
        true)

        if unitAuras[guid] then
            unitAuras[guid] = nil
            self.core:SendStatusLost(guid, "alert_externals")
        end

        for _, v in pairs(unitauraInfo) do
            if not unitAuras[guid] then
                unitAuras[guid] = {}
            end
            if v.spellId and spellid_list[v.spellId] then
                unitAuras[guid][v.auraInstanceID] = v
            end
        end
    end

    if updatedAuras and updatedAuras.addedAuras then
        for _, aura in pairs(updatedAuras.addedAuras) do
            if aura.spellId and spellid_list[aura.spellId] then
                if not unitAuras[guid] then
                    unitAuras[guid] = {}
                end
                unitAuras[guid][aura.auraInstanceID] = aura
            end
        end
    end

    if updatedAuras and updatedAuras.updatedAuraInstanceIDs then
        for _, auraInstanceID in ipairs(updatedAuras.updatedAuraInstanceIDs) do
            local auraTable = GetAuraDataByAuraInstanceID(unit, auraInstanceID)
            if unitAuras[guid] and unitAuras[guid][auraInstanceID] and not auraTable then
                self.core:SendStatusLost(guid, "alert_externals")
                unitAuras[guid][auraInstanceID] = nil
            end
            if auraTable and auraTable.spellId and spellid_list[auraTable.spellId] then
                if not unitAuras[guid] then
                    unitAuras[guid] = {}
                end
                unitAuras[guid][auraInstanceID] = auraTable
            end
        end
    end

    if updatedAuras and updatedAuras.removedAuraInstanceIDs then
        for _, auraInstanceID in ipairs(updatedAuras.removedAuraInstanceIDs) do
            if unitAuras[guid] and unitAuras[guid][auraInstanceID] then
                unitAuras[guid][auraInstanceID] = nil
                self.core:SendStatusLost(guid, "alert_externals")
            end
        end
    end

    if unitAuras[guid] then
        local numAuras = 0
        for instanceID, info in pairs(unitAuras[guid]) do
            if unitAuras[guid][instanceID] then
                numAuras = numAuras + 1
                local name, uicon, count, duration, expirationTime, caster = info.name, info.icon, info.applications, info.duration, info.expirationTime, info.sourceUnit
                local text
                if settings.showtextas == "caster" and caster then
                    text = UnitName(caster)
                else
                    text = name
                end
                self.core:SendStatusGained(guid,
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
                    count                       -- stack
                )
            end
        end

        if numAuras == 0 then
            unitAuras[guid] = nil
            self.core:SendStatusLost(guid, "alert_externals")
        end
    end
end

function PlexusStatusExternals:ScanUnit(_, unitid, unitguid) --luacheck: ignore 112
    if not unitguid then unitguid = UnitGUID(unitid) end
    if not PlexusRoster:IsGUIDInRaid(unitguid) then
        return
    end

    local name, uicon, count, duration, expirationTime, caster, spellId

    for i =1, 40 do
        if IsRetailWow() or IsTBCWow() or IsWrathWow() then
            name, uicon, count, _, duration, expirationTime, caster, _, _, spellId = UnitAura(unitid, i, "HELPFUL")
        end
        if IsClassicWow() then
            name, uicon, count, _, duration, expirationTime, caster, _, _, spellId = UnitBuff(unitid, i)
        end
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
                count                       -- stack
            )
            return
        end
    end

    self.core:SendStatusLost(unitguid, "alert_externals")
end