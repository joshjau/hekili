-- EvokerDevastation.lua
-- October 2023

if UnitClassBase( "player" ) ~= "EVOKER" then return end

local addon, ns = ...
local Hekili = _G[ addon ]
local class, state = Hekili.Class, Hekili.State

local strformat = string.format

local spec = Hekili:NewSpecialization( 1467 )

spec:RegisterResource( Enum.PowerType.Essence )
spec:RegisterResource( Enum.PowerType.Mana )

-- Talents
spec:RegisterTalents( {
    -- Evoker
    aerial_mastery                  = {  93352, 365933, 1 }, -- Hover gains 1 additional charge.
    ancient_flame                   = {  93271, 369990, 1 }, -- Casting Emerald Blossom or Verdant Embrace reduces the cast time of your next Living Flame by 40%.
    attuned_to_the_dream            = {  93292, 376930, 2 }, -- Your healing done and healing received are increased by 3%.
    blast_furnace                   = {  93309, 375510, 1 }, -- Fire Breath's damage over time lasts 4 sec longer.
    bountiful_bloom                 = {  93291, 370886, 1 }, -- Emerald Blossom heals 2 additional allies.
    cauterizing_flame               = {  93294, 374251, 1 }, -- Cauterize an ally's wounds, removing all Bleed, Poison, Curse, and Disease effects. Heals for 41,237 upon removing any effect.
    clobbering_sweep                = { 103844, 375443, 1 }, -- Tail Swipe's cooldown is reduced by 2 min.
    draconic_legacy                 = {  93300, 376166, 1 }, -- Your Stamina is increased by 8%.
    enkindled                       = {  93295, 375554, 2 }, -- Living Flame deals 3% more damage and healing.
    expunge                         = {  93306, 365585, 1 }, -- Expunge toxins affecting an ally, removing all Poison effects.
    extended_flight                 = {  93349, 375517, 2 }, -- Hover lasts 4 sec longer.
    exuberance                      = {  93299, 375542, 1 }, -- While above 75% health, your movement speed is increased by 10%.
    fire_within                     = {  93345, 375577, 1 }, -- Renewing Blaze's cooldown is reduced by 30 sec.
    foci_of_life                    = {  93345, 375574, 1 }, -- Renewing Blaze restores you more quickly, causing damage you take to be healed back over 4 sec.
    forger_of_mountains             = {  93270, 375528, 1 }, -- Landslide's cooldown is reduced by 30 sec, and it can withstand 200% more damage before breaking.
    heavy_wingbeats                 = { 103843, 368838, 1 }, -- Wing Buffet's cooldown is reduced by 2 min.
    inherent_resistance             = {  93355, 375544, 2 }, -- Magic damage taken reduced by 4%.
    innate_magic                    = {  93302, 375520, 2 }, -- Essence regenerates 5% faster.
    instinctive_arcana              = {  93310, 376164, 2 }, -- Your Magic damage done is increased by 2%.
    landslide                       = {  93305, 358385, 1 }, -- Conjure a path of shifting stone towards the target location, rooting enemies for 15 sec. Damage may cancel the effect.
    leaping_flames                  = {  93343, 369939, 1 }, -- Fire Breath causes your next Living Flame to strike 1 additional target per empower level.
    lush_growth                     = {  93347, 375561, 2 }, -- Green spells restore 5% more health.
    natural_convergence             = {  93312, 369913, 1 }, -- Disintegrate channels 20% faster.
    obsidian_bulwark                = {  93289, 375406, 1 }, -- Obsidian Scales has an additional charge.
    obsidian_scales                 = {  93304, 363916, 1 }, -- Reinforce your scales, reducing damage taken by 30%. Lasts 12 sec.
    oppressing_roar                 = {  93298, 372048, 1 }, -- Let out a bone-shaking roar at enemies in a cone in front of you, increasing the duration of crowd controls that affect them by 50% in the next 10 sec.
    overawe                         = {  93297, 374346, 1 }, -- Oppressing Roar removes 1 Enrage effect from each enemy, and its cooldown is reduced by 30 sec.
    panacea                         = {  93348, 387761, 1 }, -- Emerald Blossom and Verdant Embrace instantly heal you for 21,170 when cast.
    potent_mana                     = {  93715, 418101, 1 }, -- Source of Magic increases the target's healing and damage done by 3%.
    protracted_talons               = {  93307, 369909, 1 }, -- Azure Strike damages 1 additional enemy.
    quell                           = {  93311, 351338, 1 }, -- Interrupt an enemy's spellcasting and prevent any spell from that school of magic from being cast for 4 sec.
    recall                          = {  93301, 371806, 1 }, -- You may reactivate Deep Breath within 3 sec after landing to travel back in time to your takeoff location.
    regenerative_magic              = {  93353, 387787, 1 }, -- Your Leech is increased by 4%.
    renewing_blaze                  = {  93354, 374348, 1 }, -- The flames of life surround you for 8 sec. While this effect is active, 100% of damage you take is healed back over 8 sec.
    rescue                          = {  93288, 370665, 1 }, -- Swoop to an ally and fly with them to the target location.
    scarlet_adaptation              = {  93340, 372469, 1 }, -- Store 20% of your effective healing, up to 23,667. Your next damaging Living Flame consumes all stored healing to increase its damage dealt.
    sleep_walk                      = {  93293, 360806, 1 }, -- Disorient an enemy for 20 sec, causing them to sleep walk towards you. Damage has a chance to awaken them.
    source_of_magic                 = {  93344, 369459, 1 }, -- Redirect your excess magic to a friendly healer for 1 |4hour:hrs;. When you cast an empowered spell, you restore 0.25% of their maximum mana per empower level. Limit 1.
    spatial_paradox                 = {  93351, 406732, 1 }, -- Evoke a paradox for you and a friendly healer, allowing casting while moving and increasing the range of most spells by 100% for 10 sec. Affects the nearest healer within 60 yds, if you do not have a healer targeted.
    tailwind                        = {  93290, 375556, 1 }, -- Hover increases your movement speed by 70% for the first 4 sec.
    terror_of_the_skies             = {  93342, 371032, 1 }, -- Deep Breath stuns enemies for 3 sec.
    time_spiral                     = {  93351, 374968, 1 }, -- Bend time, allowing you and your allies within 40 yds to cast their major movement ability once in the next 10 sec, even if it is on cooldown.
    tip_the_scales                  = {  93350, 370553, 1 }, -- Compress time to make your next empowered spell cast instantly at its maximum empower level.
    twin_guardian                   = {  93287, 370888, 1 }, -- Rescue protects you and your ally from harm, absorbing damage equal to 30% of your maximum health for 5 sec.
    unravel                         = {  93308, 368432, 1 }, -- Sunder an enemy's protective magic, dealing 120,204 Spellfrost damage to absorb shields.
    verdant_embrace                 = {  93341, 360995, 1 }, -- Fly to an ally and heal them for 84,954, or heal yourself for the same amount.
    walloping_blow                  = {  93286, 387341, 1 }, -- Wing Buffet and Tail Swipe knock enemies further and daze them, reducing movement speed by 70% for 4 sec.
    zephyr                          = {  93346, 374227, 1 }, -- Conjure an updraft to lift you and your 4 nearest allies within 20 yds into the air, reducing damage taken from area-of-effect attacks by 20% and increasing movement speed by 30% for 8 sec.

    -- Devastation
    animosity                       = {  93330, 375797, 1 }, -- Casting an empower spell extends the duration of Dragonrage by 5 sec, up to a maximum of 20 sec.
    arcane_intensity                = {  93274, 375618, 2 }, -- Disintegrate deals 8% more damage.
    arcane_vigor                    = {  93315, 386342, 1 }, -- Shattering Star grants Essence Burst.
    azure_essence_burst             = {  93333, 375721, 1 }, -- Azure Strike has a 15% chance to cause an Essence Burst, making your next Disintegrate or Pyre cost no Essence.
    burnout                         = {  93314, 375801, 1 }, -- Fire Breath damage has 16% chance to cause your next Living Flame to be instant cast, stacking 2 times.
    catalyze                        = {  93280, 386283, 1 }, -- While channeling Disintegrate your Fire Breath on the target deals damage 100% more often.
    causality                       = {  93366, 375777, 1 }, -- Disintegrate reduces the remaining cooldown of your empower spells by 0.50 sec each time it deals damage. Pyre reduces the remaining cooldown of your empower spells by 0.40 sec per enemy struck, up to 2.0 sec.
    charged_blast                   = {  93317, 370455, 1 }, -- Your Blue damage increases the damage of your next Pyre by 5%, stacking 20 times.
    dense_energy                    = {  93284, 370962, 1 }, -- Pyre's Essence cost is reduced by 1.
    dragonrage                      = {  93331, 375087, 1 }, -- Erupt with draconic fury and exhale Pyres at 3 enemies within 25 yds. For 18 sec, Essence Burst's chance to occur is increased to 100%, and you gain the maximum benefit of Mastery: Giantkiller regardless of targets' health.
    engulfing_blaze                 = {  93282, 370837, 1 }, -- Living Flame deals 25% increased damage and healing, but its cast time is increased by 0.3 sec.
    essence_attunement              = {  93319, 375722, 1 }, -- Essence Burst stacks 2 times.
    eternity_surge                  = {  93275, 359073, 1 }, -- Focus your energies to release a salvo of pure magic, dealing 91,088 Spellfrost damage to an enemy. Damages additional enemies within 12 yds of the target when empowered. I: Damages 2 enemies. II: Damages 4 enemies. III: Damages 6 enemies.
    eternitys_span                  = {  93320, 375757, 1 }, -- Eternity Surge and Shattering Star hit twice as many targets.
    event_horizon                   = {  93318, 411164, 1 }, -- Eternity Surge's cooldown is reduced by 3 sec.
    eye_of_infinity                 = {  93318, 411165, 1 }, -- Eternity Surge deals 15% increased damage to your primary target.
    feed_the_flames                 = {  93313, 369846, 1 }, -- After casting 9 Pyres, your next Pyre will explode into a Firestorm. In addition, Pyre and Disintegrate deal 20% increased damage to enemies within your Firestorm.
    firestorm                       = {  93278, 368847, 1 }, -- An explosion bombards the target area with white-hot embers, dealing 37,725 Fire damage to enemies over 10 sec.
    focusing_iris                   = {  93315, 386336, 1 }, -- Shattering Star's damage taken effect lasts 2 sec longer.
    font_of_magic                   = {  93279, 411212, 1 }, -- Your empower spells' maximum level is increased by 1, and they reach maximum empower level 20% faster.
    heat_wave                       = {  93281, 375725, 2 }, -- Fire Breath deals 20% more damage.
    hoarded_power                   = {  93325, 375796, 1 }, -- Essence Burst has a 20% chance to not be consumed.
    honed_aggression                = {  93329, 371038, 2 }, -- Azure Strike and Living Flame deal 5% more damage.
    imminent_destruction            = {  93326, 370781, 1 }, -- Deep Breath reduces the Essence costs of Disintegrate and Pyre by 1 and increases their damage by 10% for 12 sec after you land.
    imposing_presence               = {  93332, 371016, 1 }, -- Quell's cooldown is reduced by 20 sec.
    inner_radiance                  = {  93332, 386405, 1 }, -- Your Living Flame and Emerald Blossom are 30% more effective on yourself.
    iridescence                     = {  93321, 370867, 1 }, -- Casting an empower spell increases the damage of your next 2 spells of the same color by 20% within 10 sec.
    lay_waste                       = {  93273, 371034, 1 }, -- Deep Breath's damage is increased by 20%.
    onyx_legacy                     = {  93327, 386348, 1 }, -- Deep Breath's cooldown is reduced by 1 min.
    power_nexus                     = {  93276, 369908, 1 }, -- Increases your maximum Essence to 6.
    power_swell                     = {  93322, 370839, 1 }, -- Casting an empower spell increases your Essence regeneration rate by 100% for 4 sec.
    pyre                            = {  93334, 357211, 1 }, -- Lob a ball of flame, dealing 23,239 Fire damage to the target and nearby enemies.
    ruby_embers                     = {  93282, 365937, 1 }, -- Living Flame deals 4,576 damage over 12 sec to enemies, or restores 8,755 health to allies over 12 sec. Stacks 3 times.
    ruby_essence_burst              = {  93285, 376872, 1 }, -- Your Living Flame has a 20% chance to cause an Essence Burst, making your next Disintegrate or Pyre cost no Essence.
    scintillation                   = {  93324, 370821, 1 }, -- Disintegrate has a 15% chance each time it deals damage to launch a level 1 Eternity Surge at 50% power.
    scorching_embers                = {  93365, 370819, 1 }, -- Fire Breath causes enemies to take 20% increased damage from your Red spells.
    shattering_star                 = {  93316, 370452, 1 }, -- Exhale bolts of concentrated power from your mouth at 2 enemies for 30,793 Spellfrost damage that cracks the targets' defenses, increasing the damage they take from you by 20% for 4 sec. Grants Essence Burst.
    snapfire                        = {  93277, 370783, 1 }, -- Pyre and Living Flame have a 15% chance to cause your next Firestorm to be instantly cast without triggering its cooldown, and deal 100% increased damage.
    spellweavers_dominance          = {  93323, 370845, 1 }, -- Your damaging critical strikes deal 230% damage instead of the usual 200%.
    titanic_wrath                   = {  93272, 386272, 1 }, -- Essence Burst increases the damage of affected spells by 15.0%.
    tyranny                         = {  93328, 376888, 1 }, -- During Deep Breath and Dragonrage you gain the maximum benefit of Mastery: Giantkiller regardless of targets' health.
    volatility                      = {  93283, 369089, 2 }, -- Pyre has a 15% chance to flare up and explode again on a nearby target.

    -- Flameshaper
    burning_adrenaline              = {  94946, 444020, 1 }, -- Engulf quickens your pulse, reducing the cast time of your next spell by $444019s1%. Stacks up to $444019u charges.
    conduit_of_flame                = {  94949, 444843, 1 }, -- Critical strike chance against targets $?c1[above][below] $s2% health increased by $s1%.
    consume_flame                   = {  94922, 444088, 1 }, -- Engulf consumes $s1 sec of $?c1[Fire Breath][Dream Breath] from the target, detonating it and $?c1[damaging][healing] all nearby targets equal to $s3% of the amount consumed, reduced beyond $s2 targets.
    draconic_instincts              = {  94931, 445958, 1 }, -- Your wounds have a small chance to cauterize, healing you for $s1% of damage taken. Occurs more often from attacks that deal high damage.
    engulf                          = {  94950, 443328, 1, "flameshaper" }, -- Engulf your target in dragonflame, damaging them for $443329s1 Fire or healing them for $443330s1. For each of your periodic effects on the target, effectiveness is increased by $s1%.
    enkindle                        = {  94956, 444016, 1 }, -- Essence abilities are enhanced with Flame, dealing $s1% of healing or damage done as Fire over 8 sec.
    expanded_lungs                  = {  94923, 444845, 1 }, -- Fire Breath's damage over time is increased by $s1%. Dream Breath's heal over time is increased by $s1%.
    fan_the_flames                  = {  94923, 444318, 1 }, -- Casting Engulf reignites all active Enkindles, increasing their remaining damage or healing over time by $s1%.
    lifecinders                     = {  94931, 444322, 1 }, -- Renewing Blaze also applies to your target or $s1 nearby injured $Lally:allies; at $s2% value.
    red_hot                         = {  94945, 444081, 1 }, -- Engulf gains $s2 additional charge and deals $s1% increased damage and healing.
    shape_of_flame                  = {  94937, 445074, 1 }, -- Tail Swipe and Wing Buffet scorch enemies and blind them with ash, causing their next attack within $445134d to miss.
    titanic_precision               = {  94920, 445625, 1 }, -- Living Flame and Azure Strike have $s1 extra chance to trigger Essence Burst when they critically strike.
    trailblazer                     = {  94937, 444849, 1 }, -- $?c1[Hover and Deep Breath][Hover, Deep Breath, and Dream Flight] travel $s1% faster, and Hover travels $s1% further.
    traveling_flame                 = {  99857, 444140, 1 }, -- Engulf increases the duration of $?c1[Fire Breath][Fire Breath or Dream Breath] by $s1 sec and causes it to spread to a target within $?c1[$s2][$s3] yds.

    -- Scalecommander
    bombardments                    = {  94936, 434300, 1 }, -- Mass Disintegrate marks your primary target for destruction for the next 6 sec. You and your allies have a chance to trigger a Bombardment when attacking marked targets, dealing 46,562 Volcanic damage split amongst all nearby enemies.
    diverted_power                  = {  94928, 441219, 1 }, -- Bombardments have a chance to generate Essence Burst.
    extended_battle                 = {  94928, 441212, 1 }, -- Essence abilities extend Bombardments by 1 sec.
    hardened_scales                 = {  94933, 441180, 1 }, -- Obsidian Scales reduces damage taken by an additional 10%.
    maneuverability                 = {  94941, 433871, 1 }, -- Deep Breath can now be steered in your desired direction. In addition, Deep Breath burns targets for 100,547 Volcanic damage over 12 sec.
    mass_disintegrate               = {  94939, 436335, 1, "scalecommander" }, -- Empower spells cause your next Disintegrate to strike up to $s1 targets. When striking fewer than $s1 targets, Disintegrate damage is increased by $s2% for each missing target.
    melt_armor                      = {  94921, 441176, 1 }, -- Deep Breath causes enemies to take 20% increased damage from Bombardments and Essence abilities for 12 sec.
    menacing_presence               = {  94933, 441181, 1 }, -- Knocking enemies up or backwards reduces their damage done to you by 15% for 8 sec.
    might_of_the_black_dragonflight = {  94952, 441705, 1 }, -- Black spells deal 20% increased damage.
    nimble_flyer                    = {  94943, 441253, 1 }, -- While Hovering, damage taken from area of effect attacks is reduced by 10%.
    onslaught                       = {  94944, 441245, 1 }, -- Entering combat grants a charge of Burnout, causing your next Living Flame to cast instantly.
    slipstream                      = {  94943, 441257, 1 }, -- Deep Breath resets the cooldown of Hover.
    unrelenting_siege               = {  94934, 441246, 1 }, -- For each second you are in combat, Azure Strike, Living Flame, and Disintegrate deal 1% increased damage, up to 15%.
    wingleader                      = {  94953, 441206, 1 }, -- Bombardments reduce the cooldown of Deep Breath by 1 sec for each target struck, up to 3 sec.
} )


-- PvP Talents
spec:RegisterPvpTalents( {
    born_in_flame        = 5612, -- (414937) Casting Ebon Might grants 2 charges of Burnout, reducing the cast time of Living Flame by 100%.
    chrono_loop          = 5564, -- (383005) Trap the enemy in a time loop for 5 sec. Afterwards, they are returned to their previous location and health. Cannot reduce an enemy's health below 20%.
    divide_and_conquer   = 5557, -- (384689) Deep Breath forms curtains of fire, preventing line of sight to enemies outside its walls and burning enemies who walk through them for 88,223 Fire damage. Lasts 6 sec.
    dream_catcher        = 5613, -- (410962) Sleep Walk no longer has a cooldown, but its cast time is increased by 0.2 sec.
    dream_projection     = 5559, -- (377509) Summon a flying projection of yourself that heals allies you pass through for 27,099. Detonating your projection dispels all nearby allies of Magical effects, and heals for 134,138 over 20 sec.
    dreamwalkers_embrace = 5615, -- (415651) Verdant Embrace tethers you to an ally, increasing movement speed by 40% and slowing and siphoning 15,316 life from enemies who come in contact with the tether. The tether lasts up to 10 sec or until you move more than 30 yards away from your ally.
    nullifying_shroud    = 5558, -- (378464) Wreathe yourself in arcane energy, preventing the next 3 full loss of control effects against you. Lasts 30 sec.
    obsidian_mettle      = 5563, -- (378444) While Obsidian Scales is active you gain immunity to interrupt, silence, and pushback effects.
    scouring_flame       = 5561, -- (378438) Fire Breath burns away 1 beneficial Magic effect per empower level from all targets.
    swoop_up             = 5562, -- (370388) Grab an enemy and fly with them to the target location.
    time_stop            = 5619, -- (378441) Freeze an ally's timestream for 5 sec. While frozen in time they are invulnerable, cannot act, and auras do not progress. You may reactivate Time Stop to end this effect early.
    unburdened_flight    = 5560, -- (378437) Hover makes you immune to movement speed reduction effects.
} )


-- Support 'in_firestorm' virtual debuff.
local firestorm_enemies = {}
local firestorm_last = 0
local firestorm_cast = 368847
local firestorm_tick = 369374

local eb_col_casts = 0

spec:RegisterCombatLogEvent( function( _, subtype, _,  sourceGUID, sourceName, _, _, destGUID, destName, destFlags, _, spellID, spellName )
    if sourceGUID == state.GUID then
        if subtype == "SPELL_CAST_SUCCESS" then
            if spellID == firestorm_cast then
                wipe( firestorm_enemies )
                firestorm_last = GetTime()
                return
            elseif spellID == spec.abilities.emerald_blossom.id then
                eb_col_casts = ( eb_col_casts + 1 ) % 3
                return
            end
        end

        if subtype == "SPELL_DAMAGE" and spellID == firestorm_tick then
            local n = firestorm_enemies[ destGUID ]

            if n then
                firestorm_enemies[ destGUID ] = n + 1
                return
            else
                firestorm_enemies[ destGUID ] = 1
            end
            return
        end
    end
end )

spec:RegisterStateExpr( "cycle_of_life_count", function()
    return eb_col_cast
end )


-- Auras
spec:RegisterAuras( {
    -- Talent: The cast time of your next Living Flame is reduced by $w1%.
    -- https://wowhead.com/beta/spell=375583
    ancient_flame = {
        id = 375583,
        duration = 3600,
        max_stack = 1
    },
    -- Damage taken has a chance to summon air support from the Dracthyr.
    bombardments = {
        id = 434473,
        duration = 6.0,
        pandemic = true,
        max_stack = 1,
    },
    -- Next spell cast time reduced by $s1%.
    burning_adrenaline = {
        id = 444019,
        duration = 15.0,
        max_stack = 2,
    },
    -- Talent: Next Living Flame's cast time is reduced by $w1%.
    -- https://wowhead.com/beta/spell=375802
    burnout = {
        id = 375802,
        duration = 15,
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Your next Pyre deals $s1% more damage.
    -- https://wowhead.com/beta/spell=370454
    charged_blast = {
        id = 370454,
        duration = 30,
        max_stack = 20
    },
    chrono_loop = {
        id = 383005,
        duration = 5,
        max_stack = 1
    },
    cycle_of_life = {
        id = 371877,
        duration = 15,
        max_stack = 1,
    },
    --[[ Suffering $w1 Volcanic damage every $t1 sec.
    -- https://wowhead.com/beta/spell=353759
    deep_breath = {
        id = 353759,
        duration = 1,
        tick_time = 0.5,
        type = "Magic",
        max_stack = 1
    }, -- TODO: Effect of impact on target. ]]
    -- Spewing molten cinders. Immune to crowd control.
    -- https://wowhead.com/beta/spell=357210
    deep_breath = {
        id = 357210,
        duration = 6,
        type = "Magic",
        max_stack = 1
    },
    -- Suffering $w1 Spellfrost damage every $t1 sec.
    -- https://wowhead.com/beta/spell=356995
    disintegrate = {
        id = 356995,
        duration = function () return 3 * ( talent.natural_convergence.enabled and 0.8 or 1 ) * ( buff.burning_adrenaline.up and 0.7 or 1 ) end,
        tick_time = function () return ( talent.natural_convergence.enabled and 0.8 or 1 ) * ( buff.burning_adrenaline.up and 0.7 or 1 ) end,
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Essence Burst has a $s2% chance to occur.$?s376888[    Your spells gain the maximum benefit of Mastery: Giantkiller regardless of targets' health.][]
    -- https://wowhead.com/beta/spell=375087
    dragonrage = {
        id = 375087,
        duration = 18,
        max_stack = 1
    },
    -- Releasing healing breath. Immune to crowd control.
    -- https://wowhead.com/beta/spell=359816
    dream_flight = {
        id = 359816,
        duration = 6,
        type = "Magic",
        max_stack = 1
    },
    -- Healing for $w1 every $t1 sec.
    -- https://wowhead.com/beta/spell=363502
    dream_flight_hot = {
        id = 363502,
        duration = 15,
        type = "Magic",
        max_stack = 1,
        dot = "buff"
    },
    -- When $@auracaster casts a non-Echo healing spell, $w2% of the healing will be replicated.
    -- https://wowhead.com/beta/spell=364343
    echo = {
        id = 364343,
        duration = 15,
        max_stack = 1
    },
    -- Healing and restoring mana.
    -- https://wowhead.com/beta/spell=370960
    emerald_communion = {
        id = 370960,
        duration = 5,
        max_stack = 1
    },
    enkindle = {
        id = 444017,
        duration = 8,
        type = "Magic",
        tick_time = 2,
        max_stack = 1
    },
    -- Your next Disintegrate or Pyre costs no Essence.
    -- https://wowhead.com/beta/spell=359618
    essence_burst = {
        id = 359618,
        duration = 15,
        max_stack = function() return talent.essence_attunement.enabled and 2 or 1 end,
    },
    --[[ Your next Essence ability is free. TODO: ???
    -- https://wowhead.com/beta/spell=369299
    essence_burst = {
        id = 369299,
        duration = 15,
        max_stack = function() return talent.essence_attunement.enabled and 2 or 1 end,
    }, ]]
    eternity_surge_x3 = { -- TODO: This is the channel with 3 ranks.
        id = 359073,
        duration = 2.5,
        max_stack = 1
    },
    eternity_surge_x4 = { -- TODO: This is the channel with 4 ranks.
        id = 382411,
        duration = 3.25,
        max_stack = 1
    },
    eternity_surge = {
        alias = { "eternity_surge_x4", "eternity_surge_x3" },
        aliasMode = "first",
        aliasType = "buff",
        duration = 3.25,
    },
    feed_the_flames_stacking = {
        id = 405874,
        duration = 120,
        max_stack = 9
    },
    feed_the_flames_pyre = {
        id = 411288,
        duration = 60,
        max_stack = 1
    },
    fire_breath = {
        id = 357209,
        duration = function ()
            return 4 * empowerment_level + talent.blast_furnace.rank * 4
        end,
        -- TODO: damage = function () return 0.322 * stat.spell_power * action.fire_breath.spell_targets * ( talent.heat_wave.enabled and 1.2 or 1 ) * ( debuff.shattering_star.up and 1.2 or 1 ) end,
        max_stack = 1,
    },
    -- Burning for $w2 Fire damage every $t2 sec.$?$W3=1[ Silenced.][]
    -- https://wowhead.com/beta/spell=357209
    fire_breath_dot = {
        id = 357209,
        duration = 12,
        type = "Magic",
        max_stack = 1,
        copy = "fire_breath_damage"
    },
    firestorm = { -- TODO: Check for totem?
        id = 369372,
        duration = 12,
        max_stack = 1
    },
    -- Increases the damage of Fire Breath by $s1%.
    -- https://wowhead.com/beta/spell=377087
    full_belly = {
        id = 377087,
        duration = 600,
        type = "Magic",
        max_stack = 1
    },
    -- Movement speed increased by $w2%.$?e0[ Area damage taken reduced by $s1%.][]; Evoker spells may be cast while moving. Does not affect empowered spells.$?e9[; Immune to movement speed reduction effects.][]
    hover = {
        id = 358267,
        duration = function () return talent.extended_flight.enabled and 10 or 6 end,
        tick_time = 1,
        max_stack = 1
    },
    -- Essence costs of Disintegrate and Pyre are reduced by $s1, and their damage increased by $s2%.
    imminent_destruction = {
        id = 411055,
        duration = 12,
        max_stack = 1
    },
    in_firestorm = {
        duration = 12,
        max_stack = 1,
        generate = function( t )
            t.name = class.auras.firestorm.name

            if firestorm_last + 12 > query_time and firestorm_enemies[ target.unit ] then
                t.applied = firestorm_last
                t.duration = 12
                t.expires = firestorm_last + 12
                t.count = 1
                t.caster = "player"
                return
            end

            t.applied = 0
            t.duration = 0
            t.expires = 0
            t.count = 0
            t.caster = "nobody"
        end
    },
    -- Your next Blue spell deals $s1% more damage.
    -- https://wowhead.com/beta/spell=386399
    iridescence_blue = {
        id = 386399,
        duration = 10,
        max_stack = 2,
    },
    -- Your next Red spell deals $s1% more damage.
    -- https://wowhead.com/beta/spell=386353
    iridescence_red = {
        id = 386353,
        duration = 10,
        max_stack = 2
    },
    -- Talent: Rooted.
    -- https://wowhead.com/beta/spell=355689
    landslide = {
        id = 355689,
        duration = 15,
        mechanic = "root",
        type = "Magic",
        max_stack = 1
    },
    leaping_flames = {
        id = 370901,
        duration = 30,
        max_stack = function() return max_empower end,
    },
    -- Sharing $s1% of healing to an ally.
    -- https://wowhead.com/beta/spell=373267
    lifebind = {
        id = 373267,
        duration = 5,
        max_stack = 1
    },
    -- Burning for $w2 Fire damage every $t2 sec.
    -- https://wowhead.com/beta/spell=361500
    living_flame = {
        id = 361500,
        duration = 12,
        type = "Magic",
        max_stack = 3,
        copy = { "living_flame_dot", "living_flame_damage" }
    },
    -- Healing for $w2 every $t2 sec.
    -- https://wowhead.com/beta/spell=361509
    living_flame_hot = {
        id = 361509,
        duration = 12,
        type = "Magic",
        max_stack = 3,
        dot = "buff",
        copy = "living_flame_heal"
    },
    --
    -- https://wowhead.com/beta/spell=362980
    mastery_giantkiller = {
        id = 362980,
        duration = 3600,
        max_stack = 1
    },
    -- $?e0[Suffering $w1 Volcanic damage every $t1 sec.][]$?e1[ Damage taken from Essence abilities and bombardments increased by $s2%.][]
    melt_armor = {
        id = 441172,
        duration = 12.0,
        tick_time = 2.0,
        max_stack = 1,
    },
    -- Damage done to $@auracaster reduced by $s1%.
    menacing_presence = {
        id = 441201,
        duration = 8.0,
        max_stack = 1,
    },
    -- Talent: Armor increased by $w1%. Magic damage taken reduced by $w2%.$?$w3=1[  Immune to interrupt and silence effects.][]
    -- https://wowhead.com/beta/spell=363916
    obsidian_scales = {
        id = 363916,
        duration = 12,
        max_stack = 1
    },
    -- Talent: The duration of incoming crowd control effects are increased by $s2%.
    -- https://wowhead.com/beta/spell=372048
    oppressing_roar = {
        id = 372048,
        duration = 10,
        max_stack = 1
    },
    -- Talent: Movement speed reduced by $w1%.
    -- https://wowhead.com/beta/spell=370898
    permeating_chill = {
        id = 370898,
        duration = 3,
        mechanic = "snare",
        max_stack = 1
    },
    power_swell = {
        id = 376850,
        duration = 4,
        max_stack = 1
    },
    -- Talent: $w1% of damage taken is being healed over time.
    -- https://wowhead.com/beta/spell=374348
    renewing_blaze = {
        id = 374348,
        duration = function() return talent.foci_of_life.enabled and 4 or 8 end,
        max_stack = 1
    },
    -- Talent: Restoring $w1 health every $t1 sec.
    -- https://wowhead.com/beta/spell=374349
    renewing_blaze_heal = {
        id = 374349,
        duration = function() return talent.foci_of_life.enabled and 4 or 8 end,
        max_stack = 1
    },
    recall = {
        id = 371807,
        duration = 10,
        max_stack = function () return talent.essence_attunement.enabled and 2 or 1 end,
    },
    -- Talent: About to be picked up!
    -- https://wowhead.com/beta/spell=370665
    rescue = {
        id = 370665,
        duration = 1,
        max_stack = 1
    },
    -- Next attack will miss.
    shape_of_flame = {
        id = 445134,
        duration = 4.0,
        max_stack = 1,
    },
    -- Healing for $w1 every $t1 sec.
    -- https://wowhead.com/beta/spell=366155
    reversion = {
        id = 366155,
        duration = 12,
        max_stack = 1
    },
    scarlet_adaptation = {
        id = 372470,
        duration = 3600,
        max_stack = 1
    },
    -- Talent: Taking $w3% increased damage from $@auracaster.
    -- https://wowhead.com/beta/spell=370452
    shattering_star = {
        id = 370452,
        duration = function () return talent.focusing_iris.enabled and 6 or 4 end,
        type = "Magic",
        max_stack = 1,
        copy = "shattering_star_debuff"
    },
    -- Talent: Asleep.
    -- https://wowhead.com/beta/spell=360806
    sleep_walk = {
        id = 360806,
        duration = 20,
        mechanic = "sleep",
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Your next Firestorm is instant cast and deals $s2% increased damage.
    -- https://wowhead.com/beta/spell=370818
    snapfire = {
        id = 370818,
        duration = 10,
        max_stack = 1
    },
    -- Talent: $@auracaster is restoring mana to you when they cast an empowered spell.
    -- https://wowhead.com/beta/spell=369459
    source_of_magic = {
        id = 369459,
        duration = 3600,
        max_stack = 1,
        dot = "buff",
        friendly = true
    },
    -- Able to cast spells while moving and spell range increased by $s4%.
    spatial_paradox = {
        id = 406732,
        duration = 10.0,
        tick_time = 1.0,
        max_stack = 1,
    },
    -- Talent:
    -- https://wowhead.com/beta/spell=370845
    spellweavers_dominance = {
        id = 370845,
        duration = 3600,
        max_stack = 1
    },
    -- Movement speed reduced by $s2%.
    -- https://wowhead.com/beta/spell=368970
    tail_swipe = {
        id = 368970,
        duration = 4,
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Stunned.
    -- https://wowhead.com/beta/spell=372245
    terror_of_the_skies = {
        id = 372245,
        duration = 3,
        mechanic = "stun",
        max_stack = 1
    },
    -- Talent: May use Death's Advance once, without incurring its cooldown.
    -- https://wowhead.com/beta/spell=375226
    time_spiral = {
        id = 375226,
        duration = 10,
        max_stack = 1
    },
    time_stop = {
        id = 378441,
        duration = 5,
        max_stack = 1
    },
    -- Talent: Your next empowered spell casts instantly at its maximum empower level.
    -- https://wowhead.com/beta/spell=370553
    tip_the_scales = {
        id = 370553,
        duration = 3600,
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Absorbing $w1 damage.
    -- https://wowhead.com/beta/spell=370889
    twin_guardian = {
        id = 370889,
        duration = 5,
        max_stack = 1
    },
    -- Movement speed reduced by $s2%.
    -- https://wowhead.com/beta/spell=357214
    wing_buffet = {
        id = 357214,
        duration = 4,
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Damage taken from area-of-effect attacks reduced by $w1%.  Movement speed increased by $w2%.
    -- https://wowhead.com/beta/spell=374227
    zephyr = {
        id = 374227,
        duration = 8,
        max_stack = 1
    }
} )



local lastEssenceTick = 0

do
    local previous = 0

    spec:RegisterUnitEvent( "UNIT_POWER_UPDATE", "player", nil, function( event, unit, power )
        if power == "ESSENCE" then
            local value, cap = UnitPower( "player", Enum.PowerType.Essence ), UnitPowerMax( "player", Enum.PowerType.Essence )

            if value == cap then
                lastEssenceTick = 0

            elseif lastEssenceTick == 0 and value < cap or lastEssenceTick ~= 0 and value > previous then
                lastEssenceTick = GetTime()
            end

            previous = value
        end
    end )
end


spec:RegisterStateExpr( "empowerment_level", function()
    return buff.tip_the_scales.down and args.empower_to or max_empower
end )

-- This deserves a better fix; when args.empower_to = "maximum" this will cause that value to become max_empower (i.e., 3 or 4).
spec:RegisterStateExpr( "maximum", function()
    return max_empower
end )


spec:RegisterHook( "runHandler", function( action )
    local ability = class.abilities[ action ]
    local color = ability.color

    if color then
        if color == "red" and buff.iridescence_red.up then removeStack( "iridescence_red" )
        elseif color == "blue" and buff.iridescence_blue.up then removeStack( "iridescence_blue" ) end
    end

    if talent.power_swell.enabled and ability.empowered then
        applyBuff( "power_swell" ) -- TODO: Modify Essence regen rate.
    end

    empowerment.active = false
end )


spec:RegisterGear( "tier29", 200381, 200383, 200378, 200380, 200382 )
spec:RegisterAura( "limitless_potential", {
    id = 394402,
    duration = 6,
    max_stack = 1
} )


spec:RegisterGear( "tier30", 202491, 202489, 202488, 202487, 202486, 217178, 217180, 217176, 217177, 217179 )
-- 2 pieces (Devastation) : Disintegrate and Pyre pierce enemies with Obsidian Shards, dealing 12% of damage done as Volcanic damage over 8 sec.
spec:RegisterAura( "obsidian_shards", {
    id = 409776,
    duration = 8,
    tick_time = 2,
    max_stack = 1
} )
-- 4 pieces (Devastation) : Empower spells deal 8% increased damage and cause your Obsidian Shards to blaze with power, dealing 200% more damage for 5 sec. During Dragonrage, shards always blaze with power.
spec:RegisterAura( "blazing_shards", {
    id = 409848,
    duration = 5,
    max_stack = 1
} )

spec:RegisterGear( "tier31", 207225, 207226, 207227, 207228, 207230 )
-- (2) While Dragonrage is active you gain Emerald Trance every 6 sec, increasing your damage done by 5%, stacking up to 5 times.
spec:RegisterAura( "emerald_trance", {
    id = 424155,
    duration = 10,
    max_stack = 5,
    copy = { "emerald_trance_stacking", 424402 }
} )

local EmeraldTranceTick = setfenv( function()
    addStack( "emerald_trance" )
end, state )

local EmeraldBurstTick = setfenv( function()
    addStack( "essence_burst" )
end, state )

local ExpireDragonrage = setfenv( function()
    buff.emerald_trance.expires = query_time + 5 * buff.emerald_trance.stack
    for i = 1, buff.emerald_trance.stack do
        state:QueueAuraEvent( "emerald_trance", EmeraldBurstTick, query_time + i * 5, "AURA_PERIODIC" )
    end
end, state )

local QueueEmeraldTrance = setfenv( function()
    local tick = buff.dragonrage.applied + 6
    while( tick < buff.dragonrage.expires ) do
        if tick > query_time then state:QueueAuraEvent( "dragonrage", EmeraldTranceTick, tick, "AURA_PERIODIC" ) end
        tick = tick + 6
    end
    if set_bonus.tier31_4pc > 0 then
        state:QueueAuraExpiration( "dragonrage", ExpireDragonrage, buff.dragonrage.expires )
    end
end, state )


spec:RegisterHook( "reset_precast", function()
    cycle_of_life_count = nil

    max_empower = talent.font_of_magic.enabled and 4 or 3

    if essence.current < essence.max and lastEssenceTick > 0 then
        local partial = min( 0.99, ( query_time - lastEssenceTick ) * essence.regen )
        gain( partial, "essence" )
        if Hekili.ActiveDebug then Hekili:Debug( "Essence increased to %.2f from passive regen.", partial ) end
    end

    if buff.dragonrage.up and set_bonus.tier31_2pc > 0 then
        QueueEmeraldTrance()
    end
end )


spec:RegisterStateTable( "evoker", setmetatable( {},{
    __index = function( t, k )
        if k == "use_early_chaining" then k = "use_early_chain" end
        local val = state.settings[ k ]
        if val ~= nil then return val end
        return false
    end
} ) )


local empowered_cast_time

do
    local stages = {
        1,
        1.75,
        2.5,
        3.25
    }

    empowered_cast_time = setfenv( function()
        if buff.tip_the_scales.up then return 0 end
        local power_level = args.empower_to or max_empower

        if settings.fire_breath_fixed > 0 then
            power_level = min( settings.fire_breath_fixed, max_empower )
        end

        return stages[ power_level ] * ( talent.font_of_magic.enabled and 0.8 or 1 ) * ( buff.burning_adrenaline.up and 0.7 or 1 ) * haste
    end, state )
end


-- Abilities
spec:RegisterAbilities( {
    -- Project intense energy onto 3 enemies, dealing 1,161 Spellfrost damage to them.
    azure_strike = {
        id = 362969,
        cast = 0,
        cooldown = 0,
        gcd = "spell",
        school = "spellfrost",
        color = "blue",

        spend = 0.009,
        spendType = "mana",

        startsCombat = true,

        minRange = 0,
        maxRange = 25,

        -- Modifiers:
        -- x Spark of Savagery (Conduit)
        -- P Honed Aggression (Talent)
        -- x Protracted Talons (Talent)
        -- P Shattering Star (Talent)
        -- x Tyranny (Talent)

        damage = function () return stat.spell_power * 0.755 * ( debuff.shattering_star.up and 1.2 or 1 ) end, -- PvP multiplier = 1.
        critical = function() return stat.crit + conduit.spark_of_savagery.mod end,
        critical_damage = function () return talent.tyranny.enabled and 2.2 or 2 end,
        spell_targets = function() return talent.protracted_talons.enabled and 3 or 2 end,

        handler = function ()
            if talent.azure_essence_burst.enabled and buff.dragonrage.up then addStack( "essence_burst", nil, 1 ) end -- TODO:  Does this give 2 stacks if hitting 2 targets w/ Essence Attunement?
            if talent.charged_blast.enabled then addStack( "charged_blast", nil, min( active_enemies, spell_targets.azure_strike ) ) end
        end,
    },

    -- Weave the threads of time, reducing the cooldown of a major movement ability for all party and raid members by 15% for 1 |4hour:hrs;.
    blessing_of_the_bronze = {
        id = 364342,
        cast = 0,
        cooldown = 15,
        gcd = "spell",
        school = "arcane",
        color = "bronze",

        spend = 0.01,
        spendType = "mana",

        startsCombat = false,
        nobuff = "blessing_of_the_bronze",

        handler = function ()
            applyBuff( "blessing_of_the_bronze" )
            applyBuff( "blessing_of_the_bronze_evoker")
        end,
    },

    -- Talent: Cauterize an ally's wounds, removing all Bleed, Poison, Curse, and Disease effects. Heals for 4,480 upon removing any effect.
    cauterizing_flame = {
        id = 374251,
        cast = 0,
        cooldown = 60,
        gcd = "spell",
        school = "fire",
        color = "red",

        spend = 0.014,
        spendType = "mana",

        talent = "cauterizing_flame",
        startsCombat = true,

        healing = function () return 3.50 * stat.spell_power end,

        usable = function()
            return buff.dispellable_poison.up or buff.dispellable_curse.up or buff.dispellable_disease.up, "requires dispellable effect"
        end,

        handler = function ()
            removeBuff( "dispellable_poison" )
            removeBuff( "dispellable_curse" )
            removeBuff( "dispellable_disease" )
            health.current = min( health.max, health.current + action.cauterizing_flame.healing )
            if talent.everburning_flame.enabled and debuff.fire_breath.up then debuff.fire_breath.expires = debuff.fire_breath.expires + 1 end
        end,
    },

    -- Take in a deep breath and fly to the targeted location, spewing molten cinders dealing 6,375 Volcanic damage to enemies in your path. Removes all root effects. You are immune to movement impairing and loss of control effects while flying.
    deep_breath = {
        id = function ()
            if buff.recall.up then return 371807 end
            if talent.maneuverability.enabled then return 433874 end
            return 357210
        end,
        cast = 0,
        cooldown = function ()
            return talent.onyx_legacy.enabled and 60 or 120
        end,
        gcd = "spell",
        school = "firestorm",
        color = "black",

        startsCombat = true,
        texture = 4622450,
        toggle = "cooldowns",
        notalent = "breath_of_eons",

        min_range = 20,
        max_range = 50,

        damage = function () return 2.30 * stat.spell_power end,

        usable = function() return settings.use_deep_breath, "settings.use_deep_breath is disabled" end,

        handler = function ()
            if buff.recall.up then
                removeBuff( "recall" )
            else
                setCooldown( "global_cooldown", 6 ) -- TODO: Check.
                applyBuff( "recall", 9 )
                buff.recall.applied = query_time + 6
            end

            if talent.terror_of_the_skies.enabled then applyDebuff( "target", "terror_of_the_skies" ) end
        end,

        copy = { "recall", 371807, 357210, 433874 },
    },

    -- Tear into an enemy with a blast of blue magic, inflicting 4,930 Spellfrost damage over 2.1 sec, and slowing their movement speed by 50% for 3 sec.
    disintegrate = {
        id = 356995,
        cast = function() return 3 * ( talent.natural_convergence.enabled and 0.8 or 1 ) * ( buff.burning_adrenaline.up and 0.7 or 1 ) end,
        channeled = true,
        cooldown = 0,
        gcd = "spell",
        school = "spellfrost",
        color = "blue",

        spend = function () return buff.essence_burst.up and 0 or ( buff.imminent_destruction.up and 2 or 3 ) end,
        spendType = "essence",

        cycle = function() if talent.bombardments.enabled and buff.mass_disintegrate_stacks.up then return "bombardments" end end,

        startsCombat = true,

        damage = function () return 2.28 * stat.spell_power * ( 1 + 0.08 * talent.arcane_intensity.rank ) * ( talent.energy_loop.enabled and 1.2 or 1 ) * ( debuff.shattering_star.up and 1.2 or 1 ) end,
        critical = function () return stat.crit + conduit.spark_of_savagery.mod end,
        critical_damage = function () return talent.tyranny.enabled and 2.2 or 2 end,

        min_range = 0,
        max_range = 25,

        -- o Antique Oathstone (Anima Power)
        -- o Arcane Intensity
        -- x Disintegrate Rank 2 (built in)
        -- x Energy Loop (Preservation)
        -- x Essence Burst
        -- - Hover
        -- x Shattering Star

        start = function ()
            removeStack( "burning_adrenaline" )
            removeBuff( "mass_disintegrate_stacks" )
            applyDebuff( "target", "disintegrate" )
            if talent.enkindle.enabled then applyDebuff( "target", "enkindle" ) end
            if set_bonus.tier30_2pc > 0 then applyDebuff( "target", "obsidian_shards" ) end
            if buff.essence_burst.up then
                removeStack( "essence_burst", 1 )
            end
        end,

        tick = function ()
            if talent.causality.enabled then
                reduceCooldown( "fire_breath", 0.5 )
                reduceCooldown( "eternity_surge", 0.5 )
            end
            if talent.charged_blast.enabled then addStack( "charged_blast" ) end
        end
    },

    -- Talent: Erupt with draconic fury and exhale Pyres at 3 enemies within 25 yds. For 14 sec, Essence Burst's chance to occur is increased to 100%, and you gain the maximum benefit of Mastery: Giantkiller regardless of targets' health.
    dragonrage = {
        id = 375087,
        cast = 0,
        cooldown = 120,
        gcd = "off",
        school = "physical",
        color = "red",

        talent = "dragonrage",
        startsCombat = true,

        toggle = "cooldowns",

        spell_targets = function () return min( 3, active_enemies ) end,
        damage = function () return action.living_pyre.damage * action.dragonrage.spell_targets end,

        handler = function ()
            applyBuff( "dragonrage" )
            if talent.everburning_flame.enabled and debuff.fire_breath.up then debuff.fire_breath.expires = debuff.fire_breath.expires + 1 end
            if set_bonus.tier31_2pc > 0 then
                QueueEmeraldTrance()
            end
        end,
    },

    -- Grow a bulb from the Emerald Dream at an ally's location. After 2 sec, heal up to 3 injured allies within 10 yds for 2,208.
    emerald_blossom = {
        id = 355913,
        cast = 0,
        cooldown = function()
            if talent.dream_of_spring.enabled or state.spec.preservation and level > 57 then return 0 end
            return 30.0 * ( talent.interwoven_threads.enabled and 0.9 or 1 )
        end,
        gcd = "spell",
        school = "nature",
        color = "green",

        spend = function()
            if state.spec.preservation then return 2 end
            if talent.dream_of_spring.enabled then return 3 end
            return level > 57 and 0 or 3
        end,
        spendType = "essence",

        startsCombat = false,

        healing = function () return 2.5 * stat.spell_power end,    -- TODO: Make a fake aura so we know if an Emerald Blossom is pending for a target already?
                                                                    -- TODO: Factor in Fluttering Seedlings?  ( 0.9 * stat.spell_power * targets impacted )

        -- o Cycle of Life (?); every 3 Emerald Blossoms leaves a tiny sprout which gathers 10% of healing over 15 seconds, then heals allies w/in 25 yards.
        --    - Count shows on action button.

        handler = function ()
            if state.spec.preservation then
                removeBuff( "ouroboros" )
                if buff.stasis.stack == 1 then applyBuff( "stasis_ready" ) end
                removeStack( "stasis" )
            end

            removeBuff( "nourishing_sands" )

            if talent.ancient_flame.enabled then applyBuff( "ancient_flame" ) end
            if talent.causality.enabled then reduceCooldown( "essence_burst", 1 ) end
            if talent.cycle_of_life.enabled then
                if cycle_of_life_count > 1 then
                    cycle_of_life_count = 0
                    applyBuff( "cycle_of_life" )
                else
                    cycle_of_life_count = cycle_of_life_count + 1
                end
            end
            if talent.dream_of_spring.enabled and buff.ebon_might.up then buff.ebon_might.expires = buff.ebon_might.expires + 1 end
            if talent.enkindle.enabled then applyDebuff( "target", "enkindle" ) end
        end,
    },

    -- Engulf your target in dragonflame, damaging them for $443329s1 Fire or healing them for $443330s1. For each of your periodic effects on the target, effectiveness is increased by $s1%.
    engulf = {
        id = 443328,
        color = 'red',
        cast = 0.0,
        cooldown = 30,
        charges = function() return talent.red_hot.enabled and 2 or nil end,
        recharge = function() return talent.red_hot.enabled and 30 or nil end,
        gcd = "spell",

        spend = 0.050,
        spendType = 'mana',

        talent = "engulf",
        startsCombat = true,

        handler = function()
            -- Assume damage occurs.
            if talent.burning_adrenaline.enabled then addStack( "burning_adrenaline" ) end
        end,
    },

    -- Talent: Focus your energies to release a salvo of pure magic, dealing 4,754 Spellfrost damage to an enemy. Damages additional enemies within 12 yds of the target when empowered. I: Damages 1 enemy. II: Damages 2 enemies. III: Damages 3 enemies.
    eternity_surge = {
        id = function() return talent.font_of_magic.enabled and 382411 or 359073 end,
        known = 359073,
        cast = empowered_cast_time,
        -- channeled = true,
        empowered = true,
        cooldown = function() return 30 - ( 3 * talent.event_horizon.rank ) end,
        gcd = "off",
        school = "spellfrost",
        color = "blue",

        talent = "eternity_surge",
        startsCombat = true,

        spell_targets = function () return min( active_enemies, ( talent.eternitys_span.enabled and 2 or 1 ) * empowerment_level ) end,
        damage = function () return spell_targets.eternity_surge * 3.4 * stat.spell_power end,

        handler = function ()
            if buff.tip_the_scales.up then
                removeBuff( "tip_the_scales" )
                setCooldown( "tip_the_scales", action.tip_the_scales.cooldown )
            end

            if talent.animosity.enabled and buff.dragonrage.up then buff.dragonrage.expires = min( buff.dragonrage.applied + class.auras.dragonrage.duration + 20, buff.dragonrage.expires + 5 ) end
            -- TODO: Determine if we need to model projectiles instead.
            if talent.charged_blast.enabled then addStack( "charged_blast", nil, spell_targets.eternity_surge ) end
            if talent.iridescence.enabled then addStack( "iridescence_blue", nil, 2 ) end
            if talent.mass_disintegrate.enabled then addStack( "mass_disintegrate_stacks" ) end

            if set_bonus.tier29_2pc > 0 then applyBuff( "limitless_potential" ) end
            if set_bonus.tier30_4pc > 0 then applyBuff( "blazing_shards" ) end
        end,

        copy = { 382411, 359073 }
    },

    -- Talent: Expunge toxins affecting an ally, removing all Poison effects.
    expunge = {
        id = 365585,
        cast = 0,
        cooldown = 8,
        gcd = "spell",
        school = "nature",
        color = "green",

        spend = 0.10,
        spendType = "mana",

        talent = "expunge",
        startsCombat = false,
        toggle = "interrupts",
        buff = "dispellable_poison",

        handler = function ()
            removeBuff( "dispellable_poison" )
        end,
    },

    -- Inhale, stoking your inner flame. Release to exhale, burning enemies in a cone in front of you for 8,395 Fire damage, reduced beyond 5 targets. Empowering causes more of the damage to be dealt immediately instead of over time. I: Deals 2,219 damage instantly and 6,176 over 20 sec. II: Deals 4,072 damage instantly and 4,323 over 14 sec. III: Deals 5,925 damage instantly and 2,470 over 8 sec. IV: Deals 7,778 damage instantly and 618 over 2 sec.
    fire_breath = {
        id = function() return talent.font_of_magic.enabled and 382266 or 357208 end,
        known = 357208,
        cast = empowered_cast_time,
        -- channeled = true,
        empowered = true,
        cooldown = function() return 30 * ( talent.interwoven_threads.enabled and 0.9 or 1 ) end,
        gcd = "off",
        school = "fire",
        color = "red",

        spend = 0.026,
        spendType = "mana",

        startsCombat = true,
        caption = function()
            local power_level = settings.fire_breath_fixed
            if power_level > 0 then return power_level end
        end,

        spell_targets = function () return active_enemies end,
        damage = function () return 1.334 * stat.spell_power * ( 1 + 0.1 * talent.blast_furnace.rank ) * ( debuff.shattering_star.up and 1.2 or 1 ) end,
        critical = function () return stat.crit + conduit.spark_of_savagery.mod end,
        critical_damage = function () return talent.tyranny.enabled and 2.2 or 2 end,

        handler = function()
            if talent.animosity.enabled and buff.dragonrage.up then buff.dragonrage.expires = min( buff.dragonrage.applied + class.auras.dragonrage.duration + 20, buff.dragonrage.expires + 5 ) end
            if talent.iridescence.enabled then applyBuff( "iridescence_red", nil, 2 ) end
            if talent.leaping_flames.enabled then applyBuff( "leaping_flames", nil, empowerment_level ) end
            if talent.mass_disintegrate.enabled then addStack( "mass_disintegrate_stacks" ) end
            if talent.mass_eruption.enabled then applyBuff( "mass_eruption_stacks" ) end -- ???

            applyDebuff( "target", "fire_breath" )
            applyDebuff( "target", "fire_breath_damage" )

            if buff.tip_the_scales.up then
                removeBuff( "tip_the_scales" )
                setCooldown( "tip_the_scales", action.tip_the_scales.cooldown )
            end

            if set_bonus.tier29_2pc > 0 then applyBuff( "limitless_potential" ) end
            if set_bonus.tier30_4pc > 0 then applyBuff( "blazing_shards" ) end
        end,

        copy = { 382266, 357208 }
    },

    -- Talent: An explosion bombards the target area with white-hot embers, dealing 2,701 Fire damage to enemies over 12 sec.
    firestorm = {
        id = 368847,
        cast = function() return buff.snapfire.up and 0 or 2 end,
        cooldown = function() return buff.snapfire.up and 0 or 20 end,
        gcd = "spell",
        school = "fire",
        color = "red",

        talent = "firestorm",
        startsCombat = true,

        min_range = 0,
        max_range = 25,

        spell_targets = function () return active_enemies end,
        damage = function () return action.firestorm.spell_targets * 0.276 * stat.spell_power * 7 end,

        handler = function ()
            removeBuff( "snapfire" )
            applyDebuff( "target", "in_firestorm" )
            if talent.everburning_flame.enabled and debuff.fire_breath.up then debuff.fire_breath.expires = debuff.fire_breath.expires + 1 end
        end,
    },

    -- Increases haste by 30% for all party and raid members for 40 sec. Allies receiving this effect will become Exhausted and unable to benefit from Fury of the Aspects or similar effects again for 10 min.
    fury_of_the_aspects = {
        id = 390386,
        cast = 0,
        cooldown = 300,
        gcd = "off",
        school = "arcane",

        spend = 0.04,
        spendType = "mana",

        startsCombat = false,

        toggle = "cooldowns",

        handler = function ()
            applyBuff( "fury_of_the_aspects" )
            applyDebuff( "player", "exhaustion" )
        end,
    },

    -- Launch yourself and gain $s2% increased movement speed for $<dura> sec.; Allows Evoker spells to be cast while moving. Does not affect empowered spells.
    hover = {
        id = 358267,
        cast = 0,
        charges = function()
            local actual = 1 + ( talent.aerial_mastery.enabled and 1 or 0 ) + ( buff.time_spiral.up and 1 or 0 )
            if actual > 1 then return actual end
        end,
        cooldown = 35,
        recharge = function()
            local actual = 1 + ( talent.aerial_mastery.enabled and 1 or 0 ) + ( buff.time_spiral.up and 1 or 0 )
            if actual > 1 then return 35 end
        end,
        gcd = "off",
        school = "physical",

        startsCombat = false,

        handler = function ()
            applyBuff( "hover" )
        end,
    },

    -- Talent: Conjure a path of shifting stone towards the target location, rooting enemies for 30 sec. Damage may cancel the effect.
    landslide = {
        id = 358385,
        cast = function() return ( talent.engulfing_blaze.enabled and 2.5 or 2 ) * ( buff.burnout.up and 0 or 1 ) end,
        cooldown = function() return 90 - ( talent.forger_of_mountains.enabled and 30 or 0 ) end,
        gcd = "spell",
        school = "firestorm",
        color = "black",

        spend = 0.014,
        spendType = "mana",

        talent = "landslide",
        startsCombat = true,

        toggle = "cooldowns",

        handler = function ()
        end,
    },

    -- Send a flickering flame towards your target, dealing 2,625 Fire damage to an enemy or healing an ally for 3,089.
    living_flame = {
        id = function() return talent.chrono_flame.enabled and 431443 or 361469 end,
        cast = function() return ( talent.engulfing_blaze.enabled and 2.3 or 2 ) * ( buff.ancient_flame.up and 0.6 or 1 ) * haste end,
        cooldown = 0,
        gcd = "spell",
        school = "fire",
        color = "red",

        spend = 0.12,
        spendType = "mana",

        startsCombat = true,

        damage = function () return 1.61 * stat.spell_power * ( talent.engulfing_blaze.enabled and 1.4 or 1 ) end,
        healing = function () return 2.75 * stat.spell_power * ( talent.engulfing_blaze.enabled and 1.4 or 1 ) * ( 1 + 0.03 * talent.enkindled.rank ) * ( talent.inner_radiance.enabled and 1.3 or 1 ) end,
        spell_targets = function () return buff.leaping_flames.up and min( active_enemies, 1 + buff.leaping_flames.stack ) end,

        -- x Ancient Flame
        -- x Burnout
        -- x Engulfing Blaze
        -- x Enkindled
        -- - Hover
        -- x Inner Radiance

        handler = function ()
            if buff.burnout.up then removeStack( "burnout" )
            else removeBuff( "ancient_flame" ) end

            -- Burnout is not consumed.
            if talent.ruby_essence_burst.enabled and buff.dragonrage.up then
                addStack( "essence_burst", nil, buff.leaping_flames.up and ( true_active_enemies > 1 or group or health.percent < 100 ) and 2 or 1 )
            end
            if talent.everburning_flame.enabled and debuff.fire_breath.up then debuff.fire_breath.expires = debuff.fire_breath.expires + 1 end

            removeBuff( "leaping_flames" )
            removeBuff( "scarlet_adaptation" )
        end,

        copy = { 361469, "chrono_flame", 431443 }
    },

    -- Talent: Reinforce your scales, reducing damage taken by 30%. Lasts 12 sec.
    obsidian_scales = {
        id = 363916,
        cast = 0,
        charges = function() return talent.obsidian_bulwark.enabled and 2 or nil end,
        cooldown = 90,
        recharge = function() return talent.obsidian_bulwark.enabled and 90 or nil end,
        gcd = "off",
        school = "firestorm",
        color = "black",

        talent = "obsidian_scales",
        startsCombat = false,

        toggle = "defensives",

        handler = function ()
            applyBuff( "obsidian_scales" )
        end,
    },

    -- Let out a bone-shaking roar at enemies in a cone in front of you, increasing the duration of crowd controls that affect them by $s2% in the next $d.$?s374346[; Removes $s1 Enrage effect from each enemy.][]
    oppressing_roar = {
        id = 372048,
        cast = 0,
        cooldown = function() return 120 - 30 * talent.overawe.rank end,
        gcd = "spell",
        school = "physical",
        color = "black",

        talent = "oppressing_roar",
        startsCombat = true,

        toggle = "interrupts",

        handler = function ()
            applyDebuff( "target", "oppressing_roar" )
            if talent.overawe.enabled and debuff.dispellable_enrage.up then
                removeDebuff( "target", "dispellable_enrage" )
                reduceCooldown( "oppressing_roar", 20 )
            end
        end,
    },

    -- Talent: Lob a ball of flame, dealing 1,468 Fire damage to the target and nearby enemies.
    pyre = {
        id = 357211,
        cast = 0,
        cooldown = 0,
        gcd = "spell",
        school = "fire",
        color = "red",

        spend = function()
            if buff.essence_burst.up then return 0 end
            return ( buff.imminent_destruction.up and 2 or 3 ) - talent.dense_energy.rank
        end,
        spendType = "essence",

        talent = "pyre",
        startsCombat = true,

        -- TODO: Need to proc Charged Blast on Blue spells.

        handler = function ()
            removeBuff( "feed_the_flames_pyre" )

            if buff.essence_burst.up then
                removeStack( "essence_burst", 1 )
            end

            if set_bonus.tier30_2pc > 0 then applyDebuff( "target", "obsidian_shards" ) end

            if talent.causality.enabled then
                reduceCooldown( "fire_breath", min( 2, true_active_enemies * 0.4 ) )
                reduceCooldown( "eternity_surge", min( 2, true_active_enemies * 0.4 ) )
            end
            if talent.enkindle.enabled then applyDebuff( "target", "enkindle" ) end
            if talent.everburning_flame.enabled and debuff.fire_breath.up then debuff.fire_breath.expires = debuff.fire_breath.expires + 1 end
            if talent.feed_the_flames.enabled then
                if buff.feed_the_flames_stacking.stack == 8 then
                    applyBuff( "feed_the_flames_pyre" )
                    removeBuff( "feed_the_flames_stacking" )
                else
                    addStack( "feed_the_flames_stacking" )
                end
            end
            removeBuff( "charged_blast" )
        end,
    },

    -- Talent: Interrupt an enemy's spellcasting and preventing any spell from that school of magic from being cast for 4 sec.
    quell = {
        id = 351338,
        cast = 0,
        cooldown = function () return talent.imposing_presence.enabled and 20 or 40 end,
        gcd = "off",
        school = "physical",

        talent = "quell",
        startsCombat = true,

        toggle = "interrupts",
        debuff = "casting",
        readyTime = state.timeToInterrupt,

        handler = function ()
            interrupt()
        end,
    },

    -- Talent: The flames of life surround you for 8 sec. While this effect is active, 100% of damage you take is healed back over 8 sec.
    renewing_blaze = {
        id = 374348,
        cast = 0,
        cooldown = function () return talent.fire_within.enabled and 60 or 90 end,
        gcd = "off",
        school = "fire",
        color = "red",

        talent = "renewing_blaze",
        startsCombat = false,

        toggle = "defensives",

        -- TODO: o Pyrexia would increase all heals by 20%.

        handler = function ()
            if talent.everburning_flame.enabled and debuff.fire_breath.up then debuff.fire_breath.expires = debuff.fire_breath.expires + 1 end
            applyBuff( "renewing_blaze" )
            applyBuff( "renewing_blaze_heal" )
        end,
    },

    -- Talent: Swoop to an ally and fly with them to the target location.
    rescue = {
        id = 370665,
        cast = 0,
        cooldown = 60,
        gcd = "spell",
        school = "physical",

        talent = "rescue",
        startsCombat = false,
        toggle = "interrupts",

        usable = function() return not solo, "requires an ally" end,

        handler = function ()
            if talent.twin_guardian.enabled then applyBuff( "twin_guardian" ) end
        end,
    },


    action_return = {
        id = 361227,
        cast = 10,
        cooldown = 0,
        school = "arcane",
        gcd = "spell",
        color = "bronze",

        spend = 0.01,
        spendType = "mana",

        startsCombat = true,
        texture = 4622472,

        handler = function ()
        end,

        copy = "return"
    },

    -- Talent: Exhale a bolt of concentrated power from your mouth for 2,237 Spellfrost damage that cracks the target's defenses, increasing the damage they take from you by 20% for 4 sec.
    shattering_star = {
        id = 370452,
        cast = 0,
        cooldown = 20,
        gcd = "spell",
        school = "spellfrost",
        color = "blue",

        talent = "shattering_star",
        startsCombat = true,

        spell_targets = function () return min( active_enemies, talent.eternitys_span.enabled and 2 or 1 ) end,
        damage = function () return 1.6 * stat.spell_power end,
        critical = function () return stat.crit + conduit.spark_of_savagery.mod end,
        critical_damage = function () return talent.tyranny.enabled and 2.2 or 2 end,

        handler = function ()
            applyDebuff( "target", "shattering_star" )
            if talent.arcane_vigor.enabled then addStack( "essence_burst" ) end
            if talent.charged_blast.enabled then addStack( "charged_blast" ) end
        end,
    },

    -- Talent: Disorient an enemy for 20 sec, causing them to sleep walk towards you. Damage has a chance to awaken them.
    sleep_walk = {
        id = 360806,
        cast = function() return 1.5 + ( talent.dream_catcher.enabled and 0.2 or 0 ) end,
        cooldown = function() return talent.dream_catcher.enabled and 0 or 15.0 end,
        gcd = "spell",
        school = "nature",
        color = "green",

        spend = 0.01,
        spendType = "mana",

        talent = "sleep_walk",
        startsCombat = true,

        toggle = "interrupts",

        handler = function ()
            applyDebuff( "target", "sleep_walk" )
        end,
    },

    -- Talent: Redirect your excess magic to a friendly healer for 30 min. When you cast an empowered spell, you restore 0.25% of their maximum mana per empower level. Limit 1.
    source_of_magic = {
        id = 369459,
        cast = 0,
        cooldown = 0,
        gcd = "spell",
        school = "spellfrost",
        color = "blue",

        talent = "source_of_magic",
        startsCombat = false,

        handler = function ()
            active_dot.source_of_magic = 1
        end,
    },


    -- Evoke a paradox for you and a friendly healer, allowing casting while moving and increasing the range of most spells by $s4% for $d.; Affects the nearest healer within $407497A1 yds, if you do not have a healer targeted.
    spatial_paradox = {
        id = 406732,
        color = 'bronze',
        cast = 0.0,
        cooldown = 180,
        gcd = "off",

        talent = "spatial_paradox",
        startsCombat = false,
        toggle = "cooldowns",

        handler = function()
            applyBuff( "spatial_paradox" )
        end,

        -- Effects:
        -- #0: { 'type': APPLY_AURA, 'subtype': MOD_DISPEL_RESIST, 'target': TARGET_UNIT_CASTER, }
        -- #1: { 'type': APPLY_AURA, 'subtype': ANIM_REPLACEMENT_SET, 'value': 1013, 'schools': ['physical', 'fire', 'frost', 'shadow', 'arcane'], 'target': TARGET_UNIT_CASTER, }
        -- #2: { 'type': APPLY_AURA, 'subtype': CAST_WHILE_WALKING, 'target': TARGET_UNIT_CASTER, }
        -- #3: { 'type': APPLY_AURA, 'subtype': ADD_PCT_MODIFIER_BY_LABEL, 'points': 100.0, 'target': TARGET_UNIT_CASTER, 'modifies': RANGE, }
        -- #4: { 'type': APPLY_AURA, 'subtype': ADD_PCT_MODIFIER_BY_LABEL, 'points': 100.0, 'target': TARGET_UNIT_CASTER, 'modifies': RANGE, }
        -- #5: { 'type': APPLY_AURA, 'subtype': MOD_ATTACKER_RANGED_CRIT_CHANCE, 'points': 40.0, 'target': TARGET_UNIT_CASTER, }
        -- #6: { 'type': APPLY_AURA, 'subtype': ADD_PCT_MODIFIER, 'points': 100.0, 'target': TARGET_UNIT_CASTER, 'modifies': RADIUS, }
        -- #7: { 'type': APPLY_AURA, 'subtype': ADD_PCT_MODIFIER_BY_LABEL, 'points': -50.0, 'target': TARGET_UNIT_CASTER, 'modifies': RANGE, }
        -- #8: { 'type': DUMMY, 'subtype': NONE, 'attributes': ["Don't Fail Spell On Targeting Failure"], 'target': TARGET_UNIT_TARGET_ALLY, }
        -- #9: { 'type': APPLY_AURA, 'subtype': PERIODIC_DUMMY, 'tick_time': 1.0, 'target': TARGET_UNIT_CASTER, }
        -- #10: { 'type': APPLY_AURA, 'subtype': ADD_PCT_MODIFIER_BY_LABEL, 'points': 100.0, 'target': TARGET_UNIT_CASTER, 'modifies': RADIUS, }

        -- Affected by:
        -- spatial_paradox[406732] #7: { 'type': APPLY_AURA, 'subtype': ADD_PCT_MODIFIER_BY_LABEL, 'points': -50.0, 'target': TARGET_UNIT_CASTER, 'modifies': RANGE, }
    },


    swoop_up = {
        id = 370388,
        cast = 0,
        cooldown = 90,
        gcd = "spell",

        pvptalent = "swoop_up",
        startsCombat = false,
        texture = 4622446,

        toggle = "cooldowns",

        handler = function ()
        end,
    },


    tail_swipe = {
        id = 368970,
        cast = 0,
        cooldown = function() return 180 - ( talent.clobbering_sweep.enabled and 120 or 0 ) end,
        gcd = "spell",

        startsCombat = true,
        toggle = "interrupts",

        handler = function()
            if talent.walloping_blow.enabled then applyDebuff( "target", "walloping_blow" ) end
        end,
    },

    -- Talent: Bend time, allowing you and your allies to cast their major movement ability once in the next 10 sec, even if it is on cooldown.
    time_spiral = {
        id = 374968,
        cast = 0,
        cooldown = 120,
        gcd = "spell",
        school = "arcane",
        color = "bronze",

        talent = "time_spiral",
        startsCombat = false,

        toggle = "interrupts",

        handler = function ()
            applyBuff( "time_spiral" )
            active_dot.time_spiral = group_members
            setCooldown( "hover", 0 )
        end,
    },


    time_stop = {
        id = 378441,
        cast = 0,
        cooldown = 120,
        gcd = "off",
        icd = 1,

        pvptalent = "time_stop",
        startsCombat = false,
        texture = 4631367,

        toggle = "cooldowns",

        handler = function ()
            applyBuff( "target", "time_stop" )
        end,
    },

    -- Talent: Compress time to make your next empowered spell cast instantly at its maximum empower level.
    tip_the_scales = {
        id = 370553,
        cast = 0,
        cooldown = 120,
        gcd = "off",
        school = "arcane",
        color = "bronze",

        talent = "tip_the_scales",
        startsCombat = false,

        toggle = "cooldowns",
        nobuff = "tip_the_scales",

        handler = function ()
            applyBuff( "tip_the_scales" )
        end,
    },

    -- Talent: Sunder an enemy's protective magic, dealing 6,991 Spellfrost damage to absorb shields.
    unravel = {
        id = 368432,
        cast = 0,
        cooldown = 9,
        gcd = "spell",
        school = "spellfrost",
        color = "blue",

        spend = 0.01,
        spendType = "mana",

        talent = "unravel",
        startsCombat = true,
        debuff = "all_absorbs",

        usable = function() return settings.use_unravel, "use_unravel setting is OFF" end,

        handler = function ()
            removeDebuff( "all_absorbs" )
            if buff.iridescence_blue.up then removeStack( "iridescence_blue" ) end
            if talent.charged_blast.enabled then addStack( "charged_blast" ) end
        end,
    },

    -- Talent: Fly to an ally and heal them for 4,557.
    verdant_embrace = {
        id = 360995,
        cast = 0,
        cooldown = 24,
        gcd = "spell",
        school = "nature",
        color = "green",
        icd = 0.5,

        spend = 0.10,
        spendType = "mana",

        talent = "verdant_embrace",
        startsCombat = false,

        usable = function()
            return settings.use_verdant_embrace, "use_verdant_embrace setting is off"
        end,

        handler = function ()
            if talent.ancient_flame.enabled then applyBuff( "ancient_flame" ) end
        end,
    },


    wing_buffet = {
        id = 357214,
        cast = 0,
        cooldown = function() return 180 - ( talent.heavy_wingbeats.enabled and 120 or 0 ) end,
        gcd = "spell",

        startsCombat = true,

        handler = function()
            if talent.walloping_blow.enabled then applyDebuff( "target", "walloping_blow" ) end
        end,
    },

    -- Talent: Conjure an updraft to lift you and your 4 nearest allies within 20 yds into the air, reducing damage taken from area-of-effect attacks by 20% and increasing movement speed by 30% for 8 sec.
    zephyr = {
        id = 374227,
        cast = 0,
        cooldown = 120,
        gcd = "spell",
        school = "physical",

        talent = "zephyr",
        startsCombat = false,

        toggle = "defensives",

        handler = function ()
            applyBuff( "zephyr" )
            active_dot.zephyr = min( 5, group_members )
        end,
    },
} )


spec:RegisterSetting( "dragonrage_pad", 0.5, {
    name = strformat( "%s: %s Padding", Hekili:GetSpellLinkWithTexture( spec.abilities.dragonrage.id ), Hekili:GetSpellLinkWithTexture( spec.talents.animosity[2] ) ),
    type = "range",
    desc = strformat( "If set above zero, extra time is allotted to help ensure that %s and %s are used before %s expires, reducing the risk that you'll fail to extend "
        .. "it.\n\nIf %s is not talented, this setting is ignored.", Hekili:GetSpellLinkWithTexture( spec.abilities.fire_breath.id ),
        Hekili:GetSpellLinkWithTexture( spec.abilities.eternity_surge.id ), Hekili:GetSpellLinkWithTexture( spec.abilities.dragonrage.id ),
        Hekili:GetSpellLinkWithTexture( spec.talents.animosity[2] ) ),
    min = 0,
    max = 1.5,
    step = 0.05,
    width = "full",
} )

    spec:RegisterStateExpr( "dr_padding", function()
        return talent.animosity.enabled and settings.dragonrage_pad or 0
    end )

spec:RegisterSetting( "use_deep_breath", true, {
    name = strformat( "Use %s", Hekili:GetSpellLinkWithTexture( spec.abilities.deep_breath.id ) ),
    type = "toggle",
    desc = strformat( "If checked, %s may be recommended, which will force your character to select a destination and move.  By default, %s requires your Cooldowns "
        .. "toggle to be active.\n\n"
        .. "If unchecked, |W%s|w will never be recommended, which may result in lost DPS if left unused for an extended period of time.",
        Hekili:GetSpellLinkWithTexture( spec.abilities.deep_breath.id ), spec.abilities.deep_breath.name, spec.abilities.deep_breath.name ),
    width = "full",
} )

spec:RegisterSetting( "use_unravel", false, {
    name = strformat( "Use %s", Hekili:GetSpellLinkWithTexture( spec.abilities.unravel.id ) ),
    type = "toggle",
    desc = strformat( "If checked, %s may be recommended if your target has an absorb shield applied.  By default, %s also requires your Interrupts toggle to be active.",
        Hekili:GetSpellLinkWithTexture( spec.abilities.unravel.id ), spec.abilities.unravel.name ),
    width = "full",
} )


spec:RegisterSetting( "fire_breath_fixed", 0, {
    name = strformat( "%s: Empowerment", Hekili:GetSpellLinkWithTexture( spec.abilities.fire_breath.id ) ),
    type = "range",
    desc = strformat( "If set to |cffffd1000|r, %s will be recommended at different empowerment levels based on the action priority list.\n\n"
        .. "To force %s to be used at a specific level, set this to 1, 2, 3 or 4.\n\n"
        .. "If the selected empowerment level exceeds your maximum, the maximum level will be used instead.", Hekili:GetSpellLinkWithTexture( spec.abilities.fire_breath.id ),
        spec.abilities.fire_breath.name ),
    min = 0,
    max = 4,
    step = 1,
    width = "full"
} )


spec:RegisterSetting( "use_early_chain", false, {
    name = strformat( "%s: Chain Channel", Hekili:GetSpellLinkWithTexture( spec.abilities.disintegrate.id ) ),
    type = "toggle",
    desc = strformat( "If checked, %s may be recommended while already channeling |W%s|w, extending the channel.",
        Hekili:GetSpellLinkWithTexture( spec.abilities.disintegrate.id ), spec.abilities.disintegrate.name ),
    width = "full"
} )

spec:RegisterSetting( "use_clipping", false, {
    name = strformat( "%s: Clip Channel", Hekili:GetSpellLinkWithTexture( spec.abilities.disintegrate.id ) ),
    type = "toggle",
    desc = strformat( "If checked, other abilities may be recommended during %s, breaking its channel.", Hekili:GetSpellLinkWithTexture( spec.abilities.disintegrate.id ) ),
    width = "full",
} )

spec:RegisterSetting( "use_verdant_embrace", false, {
    name = strformat( "%s: %s", Hekili:GetSpellLinkWithTexture( spec.abilities.verdant_embrace.id ), Hekili:GetSpellLinkWithTexture( spec.talents.ancient_flame[2] ) ),
    type = "toggle",
    desc = strformat( "If checked, %s may be recommended to cause %s.", spec.abilities.verdant_embrace.name, spec.auras.ancient_flame.name ),
    width = "full"
} )


spec:RegisterRanges( "azure_strike" )

spec:RegisterOptions( {
    enabled = true,

    aoe = 3,
    gcdSync = false,

    nameplates = false,
    rangeChecker = 30,

    damage = true,
    damageDots = true,
    damageOnScreen = true,
    damageExpiration = 8,

    potion = "tempered_potion",

    package = "Devastation",
} )


spec:RegisterPack( "Devastation", 20240921, [[Hekili:S3xBZTnosc)BX1vJI1eBzjA7KSZJL3ko2ENm1UZmvuUzR7lwIscsIvOi1sszzVLl9B)P7gGKaGaKuV5j1ExD3oo2eSrJg97DdIh68WxFO3y3e2d)QtBNl6448HwTFFNoTV8HEjpVG9qVfUJ(M7u4Fe4oh(V3YE0noXnXlmaF2Z(HUJryehUmAe88zjjlI)PZoBQxYSLdBnkC(zXEZx6tVXOi3jj4Vp6SH(HdplzgBLB0kyOEbNXcM6fWoBKVBCC)5HJx6ZIpZDHp()6ZEm8BSOwJwS4HEdx65N85GhgAgZ7aiZc2Oh(1ox8U3diK34Xm(GzXJEOho4tB)xo1PZpTEqpV5FA9GLlq4eV(xw)lPpTZLWt)OVF4Q1dUnYDAya8FyRh4fa)5F7U8H((tDE)jRhaVs7le)8dWR(Fla5GjrHZfZJ87ComMVoda4)0nc(pef4HE(EXjXi1KH)3FL2CybUd9zJF4Mh65oIt2zjSOaVKN7hVmc3zyZxeUIf1pj8HEWQF0ZJ8z9tCHNbq7xX)sKh8kEUCq8iRplGn3drVR6UEqN1dE76bjU(SGKwPWoUF8c3GwIzF9GxEz9GHlNmP14mQrRi2CxVaekaqA9(lxp4hxpaO9((9NbmjWQRrjV018Pw)vmnrlxqG641d0X)RP)65YRGjHbj9dN0FU7uVr5lGM0uDCnxUnP)FexkmJaA)ocDoQcOW54I8wW31UtmiGBa32aMLLXW6nYn4BRhmpmobMRfl89gHVma6qe80EyRhsaM8TGzWzZzgCiQJdrS2rwcNwBdhHb(iC5F(wS8pFZx(CoPZR7Y)OQ46kNgHtylNTGkzG0IePl0isYeJlStZkqKsG)VEtgwMoOjErS(dJyUjZkQakJeF8RKsdlYQ8bJprSlfpkmAeOQDAF28HSO48nkU884qyNmFL1FS7CC6t8g9n4L0eOVhg46b3qJuvAgKJJcxauGefb51dgfUmi5moYuUyTc91oplxIfxHvqQ3BcJze7kiP6AIkrg2YATwcxLUS3NYxB36(CtILvkdDbxcCmBI7s)KYedxeY)PcJ5TmFxWmd8mUdl9(k8ZjRh8C4sG3ezADhgUmHZA2R36bNYna5dVueZh8WlaE4KqWZKWfaRg8ZvZy47rqyf94B)YPxF)nNEDVENEDuyQhH57E2THFekhe6poCvqR4zUj4laKrWRYiAu2S66KTfmmmoMG2eVPZs6lZNF(LMKQcb3gJzj50ThDbKeEk(V8xI6atXiJms)vcXpwcXv1HMpuGu(bcpV(VQ(csB2ggDtTTW)qGFWEeqHwpGHOj3JsyRa2tdypb)5XYUMcpBiSdUkmcvwb7D0wm6K5C3NaFWb)qhYswXWxN(ZYV9iqEYnymTfd73cUXyqVM30GWicGF62VapzYe2ieJIt8MJyulIA2NhEaIw9ZHRjP(s3lsHZcGS1h4a77nwMPsi75nFoeQaOtaOzjrlj4OOkxmU5m)K(UrZdJm(u3a2YhzrUd98HDsz324YD9ABG9GXwuyB8kABSbsuIzbJyWOM4nYljZEf36cjsigs)HlJIta(Dtkiuyf(YYfcr15UFJj26IC9g7ZChJYMZaZnpNto)xlbDwp0dmhbQmN0F6OXCt6)6L4SKoQLW(ZJmF5PfgY7SOMzKlOgK)l9XGu4HQi2RsaUJVHEoaa49AaWULlKYaoOb7FEJsipZsNSOLbwNl3qIN6dwWZYE14eUw1frmiQ0HUg1RwTIcXQTvsNwGDH(izg3xf2g(Z9HEXTM7ffbInGXYjrWAyzeBmysbKaIcxfllHjET(DiqfVDAnZMBNYqS)CE42qmCYjgwuB5nrMPoLG0sJAMAQtAVjxdYYiYy56b)GK5bjZo5daerAZxxLpUFOQzIdiDJm3Yg5nMHwu8gnldeCDnlC9qZ(EjZKtacyoaeFMGADaRXGs4LOJrKDJo5)EMcbJSBXphmYklvFMFm8VB36YmESoM0qkTBuMzK89v(SwYoNJLDoNxTDoJZu2oxPKNl3EjxsRXqMpiua)N4(G5fWNMauJpUnxudtWZZxYa5oUbeYZTfEbJ9zMgC8INNJEphf3FfBOEgrsDHayHY5AwpGqrUZmGM6fUCVpi7EPuiW7MjI)K49awZXEpc8ZJ5Vj3dNm6y2W56kqBZqmA44JBTEWp7YXbVGeW4j5FZ8WXEt8qsWXJwc0MaY94oTU8PMCjKPG5m6LMboHIJdc4dCuctWd(yjqLUYAjY5NXzjEw4sFe3Xv5m3GP4cbrlPrNpdEbJaFqIrsh6M(yM4xHP4JOpIWBWFBx55GCPhJeWvsAFLho2WO0)vag2akUKk(NsZv90lxGg8JAPRVj3h2a2qNnGn0ztydDmXgAsdr(Yq3jMQxgTntzcbNV6pYL88OGplBjuDuH6FzJHQQaA0YHp3hcPWFr)4zextrHyW(aeimkf2h47CJcaz2(EJeqVWQM90i)LJj)060E7rpNAGEoBm65OGEwC)RUMvsLh1YArPEfy3WdUYQYSuLwMotza472p)H55ahZVXBlXxQSrAaH46g4zi)6cyLr)potza1gR0D31ow1rcRuTv2jJZIYbvhlo5w1woptG93LDEtpxE7vMR2)rFEisYsIWFS812gfQn37HwTlKizTWpPmA2jlLaIXcMfCXswawWvOtrDivt9P)oItM8ClIvzcaghb0yiuBeo9XO(YJk)cR5kHSVXZpcAcgZOeGIZa2rYdI0KAig4YfG3f0dW8Aqv2l8UwuszUNQA3C0uoMNdCmxeZa(RygBo8((EzrIhVIbM2xeIoGmeZ4IxYBqFyyrptEetMN9qU3yaLMGL7dMGFofNimbIiHNPNaQ2sWmfgmoM7LYq2ukhd4cAig5k3PdWgjpbYDm573MsGJLY2yVpCWOV9(khL3C)eY0P4fGvcUppxPEbtwgdVq)2s6AavskgorviSNW01563FHhHa6w4ZMxw0y3GemLUqaJ6Ic)n0DPE0oqpWoJp(RFCS7IeXm)7a9CjM7LcjSkMp8(UzJolBti6O7AqH3htEyCsy0CL8yDSsnidMU0FITYtr2r1R5rt1urttaHp6ovymN8frjPSJRJnnkdtYrdFWdEWm(eFxs7rcpHpLK)BT8hxEb)mfkMiT0cKZnAKBaR)JEtLtzO86YsXaBumL1xXtWLche26ad44oQejgvA8Blq5jUR24AafZNqkeqXgsoZvePXu)WHU(IaUfsF8x0f70agmQ7UXuMCYPbyId7ZEKY)z4JS5u6udOuy(oL8uodEAuk5b84uTajTrt1nYl)YCSPng7fJbRmncDadqVrFlwJ(wyyQeztKWlu4tjSYuYnlR2sCgB1DIEavFmwabXJPWbhbZ5h79XFVqDmIdCxGd1s(ARAY(4O)1sVOulgienjJZWStbH9qC)XYki0vXRQvkYD46bFoYdwoFHI(nL9rk9(ixcvpGPrESjCT1GoXGyceP4FX08walLeDKz(Rw0YlcJ1EeLECLnDHvdaNAPuqmPu3ozOPOllGBwsOF5veiF1lLA)SOaZEwEjnuZyUTmrN4TGhdlqtzXABzF1din31dy4tslwSOwXY1jweuozUDHV7Z0U29eZXm3fONyHWmeTYdl8mbY7VPEvGZqJ0SHn)qJYm90mZ6JXQFH4rttXUQqJ(e5EPCn2bo6Eyfjbpw8(3Kr0Fc0EgGPLH7lkMzdrUAeLgmnNg(0Z)q8B50uGjejWm6FsoAHQJzyrf5oHDE746jvOyc2KSbvUsdBe2snyUwwPOf0Dgw36UBG38Wyfw(MP71ALifvE)b(7BO4P8unwqYRqy8g2P0AVP)VnRTzZIl)3IE1KqWsjRo7yf0JQ3GpsBOSyJj(WKoqt7Y3EdFNliT3cqFui3rO)Y0qEQAbNwqd1tO(NmTOOA(rAr9uXsOIUrzkY9TYhqAwvRbl5Pcrnn8W5Up1xmGxp3e7r(MGDMbx7psgghYIdEtImH9UBorYYoHnyWJ47I(x(PBnMuGCAr5D7uXqm0BwdLv(yg3tj1X0x8NjD(w9uqT3BEF(wl3YIX8iKXXk5nzn263DhvL86D0mCIg3FiQYsIpQtBDHE1rMl4RTX)FJMY)hUOUTBLMCUm3NUbBUJGKuMGrUlmMaGukZINJQGIyQHA5UClXl)yi282(MvyvLwrmWbqeICP4IAsukpmsfosHGisOcuvPQotL3MVA5MtP3tu2E(9NrVrU4RVLYHZ54p5HF9hz0i6jDCOWZa2kEHNWDo4p)7aG5)cLFKB)IXKHOT9PY(AKJJAYeNAiDPTFyG5OSKJOeCEv8v50EqpAaOGYGv20NuWeRXELcvukJ(xkbjd5xjfO0ZDdg5b4ch3Lugrp0N5UiBHLPiWw)6y1ivhJgm)73NYJiMgyZNMhm)yOC9pjmDM5HVGQCs2)I3Ax4OrUgkesE3FHKPHcxJXHehcRBZjuAMlE(c0rX)Nqm5YJfaDSIgh)WPEJYo)cF10goo6OOLls6JzpxCenWqZh57TaxRnkAJVbADj(6Uono2CQiU25LxusabOJKb7Up3Nwe6tL0JWjCBGUcFRT8JCDwJ2QLDKk0Fy0mLPCST5szPwLtZnHSwsn5RkynZy0qh3M4fptOHkf0IKJqzwQ0qbOmK(rUWMiwvEzOV3dRJB9CtpZpzzzwTipTivl9qfUofxGNgXyb0AXMxWU)7LrOJbrEFtphW3di(qsR7eXsYC3ZlQBtPNJh9QsxNq3lgcqhrmaP76sqfcdjms1mHqRj6bJTMOf9btV5vegIvDsYG1zdW6I21WYKyCntpMzAKgdP0mlrlCcnEQV8dtK)96qonxHtLA2znhgnQUvMrALHY1MTUBMTBSJtujhwPZLCx7O16L8nVHAi3UkdzXbuGyL3sk5h2cduurr3nPUmVuP8oWqdtkuUyCnPXMP9cgkanYi(U2PKHS5wRDL5Q5l48UPufitsTLYGkjwvtm0tCOudpLQ8MSDt9GeQupTTShlAJQtsZQc2xrGbtEoVPdBggNi2MF4FtVr)WwvsObtCKb4VlslVq1527MZICXox6RrGcz6CTfWtptMlnJdxo0NL27vc8)ec1XwZkGjCXHMc3juUE617S7VrGLs(8WdSfqVFlV9eZREBzvcqmToBVIHohgfdD(otXqNYumyczRMx3XYG6uhfdoMvmuO7wQsXGX(L57qfdo1HyOzUZPSYsz3ePwD02XMzjxdUg10sZZOCa9QYYJ0ak0qF1zJw0iTP4MAfnXcAMDmnweXEePiT6iFApKE39axIye299O6LCJ88qz1LVRYct2qzaihhFBzlNMfZq1NNG6GX04tQTrklDWhZmkL2vTunPrSl9OrskXPkwXFTS9iUUCkRYmp(ZRgAddXTef4yQsPfv(Rj2SHIaov2pxBHiGtn1XknGQebk7ua8DUiqhJIagxYVwIagk(CrDR)VhDNMX)S2s(1Hn57rnLAMxtk2k5L5m6)PRVXm()kZ28DO2LIEYLqNwrdzosTkHFfI5zeNu)359sgV3tXZ8beaMAdPoLLWBK1HmmiHJsZ0Y3MHDmVp7jEVhHXg23hxl1RCTLx2pEaenknTQVlxQWoU8k1tBfDhif1enEMYgW)qmza5htw(jyx4Gj8mEHxeksksH(CEZneWq(YyQ9rtwXC51yLdFG5l5TDpJ3lU0BFI3KUMxxxDEJmzn(csSkUU75noszDAkC4c5zD)21uwltBgNJgr8lmF3NWPtUD1UlibBF6VWO(Mdx4i38i3aQujrmFuEI(Af4sNCXzErJfD02ym)d05IoimAoUnGntThrLbb6B8ddh7Vev38wSICuhT)zrFeF2FqDTnMmf8yvtF1hMYCJAUZDZY5oBw7SOutIkQlwwLvZZwBI5pob8HMPnog0hommyzCRKvR60)IfJ01SwszWBU2qvGTHGFOWilbffn7IjSRXgHz26MMZtRKtjFgjCknAIkBUpEl8JDKNu)YKLpm87zcp5z0x0eoJboSSrC3n3FIs)9LWBzWw7L(zQ(BCvUFHtrn3xlFYY3AT)b8QupXl0gqAzoncBzMEudwZtIiqGVnmqQBkstO4hPUky9G)G6Vhnkorp3Ugisv2YCtej7TKnIAAAKkjdtvlLOImKvM(ZaFe)3AFknuyYsYoSLAvLtaTCmoVErgvuyRiqP1NQCEfPwIZEgCRG3wUBcAiGJQCDRc9LG2ZlG5sUAyaun1j6wPMgzc0t(B2Q30uzk2JQpLnk71dXpsgrJjJVMBohYCl2mkGGNVgZGWbqfGOq8FVc5Q02YYQAmdEZycRLpnqspV)iFxWDptDXTAjFPkGNMceYPUwGRd03yj3iWyoSKh67(Vjf3GwOiYQoMNSLjX0hybut)TFP1o7fXFw9eBPXJLhYP6jkRG(Us6716PSRsDv1q0AJuowQTZ9uV6w(zEO0wKVqlx))XBU)4n3vxq3Rmjv3q3L2wo)txSh1Ow65(Bodp4j8ttkfa14N5BUX4jIIhtAGin9)TpDl2YP03LIiw8s)e(Uj)tXbTTheISDbtPpVeEIumalgjEl0Qd(TxPe7X58dRau1yZavydQHvJ)6)zz6BMnF58YiFOLPEl0KD1SCzyf8NwLth4o)MpPgByFvsQzVU)UIQwxcNTaiUERjD26Ci1oTZ0PdK4Z5Q36WvU5qcfXPS28qj4DcwmxQI9KxsAGeoyGCX1OHdkJ2AoMdPWkoTSGsAs0NcE6k1AGLFgb(ZfHT0sEMopa5O8MESgybFJ(WXO5aBO0t0Ex5YJP00S4lk9qEuqA)zhdVtoYmXnWWHaLpQcnXrAte1S4IY4b(oDDjZ5xG8yay)PEWpSLeMQfFZARvXr7n7OYiI3N3o2GHn6BxFr5u5(tpLNFlAw8IIqL23)2oeX)SlMJtUvxrf4L9HdpTquZsHALwbST0N4U9yk8tzqnFmLtzAQLpBvYk0rUUrcIAwtlLfoyrQTK39w5zLzf1hKseQVlZtSswovXyJas1kyL5C7DQdRKmQ1rUvHe7xEb9Z)0miy1S)v50oxXXzl7k)AREuv8q6zLYWNLvL4YSuqIMwR6qHd8q644hIgtkhwqNLh0Xxyvl8ADcqPdtxm8EsKRZDD23gxSUa4VJvHu)i(G(c48vftrg3tQR4e9UgpXpD5iqdZn2NtPhWGQoWC6h2c6iviIr5QUD4NPJsYxZd7LdurvZImn0AGy61RRWbRZ8rAWYPL5wKFqutV7qIeSRJJmT3Ly03EqkkRmBkyg(daPkAzdJ3htJVOdxZo(S8FvuelKCVw(ZcK3CSGZ03C7HltscPVdFBZHXzBoBm)h4jVX6P(WMH3T(tfsMVDBTAacFTf)I9ZQnDmsVfEC(NobUUjPMZ2D8440m4W)QsL(DdXl5nPnmUi9aUtj280QuXXzKz)Z3wZt1Tr1us(miT5JigFJhDeqOMl3NIWGNFQVpBQ7i1ejIK6saKOhFRaiuEZDShn0)HyU0XEWtzzgyNo8vLSWY3eS)rXsbwfP1hvmi2sYNOXt(1weur(HMtl3PNGnqqA2aYtykpfaFw6ZEtn4KeCXC1f5Vky(vTxnzpXgTeShY9Qul)4uSt4YaZ8RPYbld5H(lZNAnYQ0F0CCpvxJTlt1tRRbafUPTckoiJH5lTbr9efF7RQ2I6Vfr3Wb9WVsHXPhQe6syjYBkLNs1dOOuqN8tYcqscJJdNN10rz1lt)RdNk(LqJG(IkrxjzT)lGPMERCJq7JXIdVd3AUWa)ByXVbvYsD5Y40MdYDzsO4i8W)qah3A9V839WksJ3zzFkmaMg6XVjDhpr(4T)g(Y18dt5gGbDCNNAwfKvQfVgGnwN(Ac3dhgVhGSZbdYN)Ad5Dy)B9VyGHnozZyyTGwA2S0qmlw0Q5so3CPoylyhvhIxydB1IVOa(Aj(JxB4FPz4NBJrdWftOrnH4oWwXH77mdx5EIrdSMAxMAc19g91c8vkiTU0RPIvxt4QveBniBPe3VMW(9MHTCpyObytTNrnHQw7MOtNn3mk1e27ig)H9UCNfiMvWoDHd9c5vt4TZCUwG7EH7YcS3BsZ)L9(UMfiU17AwG3EJc0P9EgH7yXPSThGwmzMwzoDEwTs5vxWPw1nnGAUKC1f0sfItdUgkrxDbQw81Aa2sPpkaClMg0YfLo1WCMQQlW3bPlBG8Gsm2f81IXgtjisd4LLdP6on7GFWwb5(WT9ow0RVFy70aE4cg)0OfZZ3(BmNk2gLplnSvjMUDDA3qnZgx31jf13ZZLXPkFLFOnw4ylfb7J9nhlXClLOwnaBifUVoa1syN7zPABtZoivBfK7dPAhlwQust8B0T(BijZ1fWfZESUIFRPxUWuyjkxTeP(gDFnmMM1CGBmbkIBzJ3SpYIYEMLB)ZXDyy4msxZUvp3mkBbDAItem)BGJq9T4(xldpZp1WghKQbPDFcsV)J2cqZp0YpxgMNpK9lW3bSgEwS4ZPAzyU6W2)tYoScOZoAz4E6a2NaEhWxSUuLHUINVhb7MJSvDFUAyIQXROAiWYK7uhHvldAFpb2iC1a02eynoK9lW3bSUmbvRdB)pj7WkWSqRHbSpb8oGVgfBl(89iy3CKTgI26tunELY9EjtvuHV1jg09yAmhuWFWa8Fs4DHq3T9TCPXXLb)F4hm1FUPpTB7xEPSN)d)qzWUB7MPlXTe52jCRkulJYwieQmXOQ3YmpgfoI9n4pya(pj8UAozNcmlgG)EJt2aSlJtUEi3oHBvHAzu2crQNP8PKRpAdQHkF0kCjLoLwVfQnpNLn86pPQFOQmptfgJc4lKS7mo)nHmw1OR)uwFYyLdV(tAfKrZJrb8fs5Q8UK(vxT59jdJQ(tH1B(AZZvzdxniSc1fuMUv5cZ2O2G5O(RSkhU6SAl(YTvN)Hg(1bYy7O3Yn45(Jxexg0TnU6UcQ78GMl6VfWV2XaxEq27JzWA6jSNFIQ3FRHZ17D4xhixV9v7JRURG6opBh)ZgKr1TK)zdMH6Y)uW1WJSgiHn)YE5f7ESvUlB2ezB(Jh3P1LV1Iib8udtiE973S51hxE4o22K1NXovoJDeZyk9)vKUD2RoD7SdaDlNLSKKS4)OrR78)SkJTnO0Xmu6ygkwA8G9yX(S2(bPLOxdY5LUFdbiV(GAqt9kZPUGA36HilngW2VGTaWTzbBbuB5cMQl4KqF)Wv0j61fetWd5gl)cmj7Zxd)qDWVf2Ptwz64OpvJt4F6KYh94X4Gh7M4o0nM9tR)f(xTKiVelfK0neJgzxkfPOi57wlr)QFkj2B9BITw1BF0UjVAnkV0jTsdKgUp01HP12zFNkFE5WE7l2Vn1G7oN2(tb73)T8RTwYDhqX9Fx(Ar0FxvvD4o3vDS0jk7Nwh9qFSESnbknjOgWnE36waWw0ALFL)Qb1I3fW1fKhmCDl0cydu63MWM5HZE8Mc(9bFSTZVc)i7QbtTBE3caZIUR0VGb6sdA3ZO6GZXQAMTUdan6yLieI90jNDZ5EShUuwCBItaDgynemz(qoGaVgGfJxm99masThFaX1dkWReS1p5u1kjy7(0uAoWSd(TljHhyWBhW7SVn1OzeSXMyCihqGxdWwQWyHhFaX1dkWReS1Vsd1syC3NMsfgTd(QLwQrfL23G3oG3zHXA0pfBGo7dkWRby3lviUgy9gT7DGbVDaFazo2leA7nmrLShvR)B)c8Aa2Qjj1OjpQbwVrMXpWG3oG3zEVdmH2ExMuj7r1692VaVgGTAssnehRbwVrkMoWG3oG3zEVdmHUqcb2jvthuGxdWwnjPgIJ1aR3ifthyWBhW7mV3bJqBmXmtWbS7PKjEuy0Ozysxnwaq9hx700SxH(()ZTvPWDNX61)YNP9keOFqT4N4gYd9G9PzHrp0RN38p9qpiWOjE(zFA8IBLD8kFB3Zs7PGtWpQIDfmmPTBXj0vjv3CoTITmZlVy4PIJpKXN9y(HZX4ZPJbJXNG1Nv(bEvCeqw)l1Fb7yCbBQhZYXGINxkJpZ4cw)C)y8jQl4QpZlR)L)l8lf7i6Zz5QzE0TPj)T5SylC9Is)wwMFdDEcDFgmHXVrmM7fSeVjdOVr2DY)DbG2iQkV)uojCr3ywI3eb1Td)N9z(XSUTBD5jz3PNDR(GxyQrK2T2v)hkb0DB3CtwVo786Tq75BQvV2tRxdGMwVat0DXjEOI(y6(hoBRFaTqwpy4Z0Nz4fa2JDMb)gesal(hsv6pjEpG)AShEX)pM)M0ZsNrPHJRC8dwm9jzghpOmBWp7YXHm5p8lP9yVjEi76XI7Wk870ANwx(utoB(u(h5D(D)koU8lmB8XsGkDLbte3gOPzjEg)stc)gkZn7b)IBSYOZNbVGrrm3yK0HgshZe)kmfFKAFf8ZXSyrLphts)Cm7kjYY)EohgL(VOMzb5WsLHtP5Ow)6ZLME70xq7Ejhaan9Uw7zFTXPDlCVbiPJzKS0tPGMUYAGKMUH53aKu6EYxGNT3Kx3z3E9o9zpnYF5yMPns9o2xBJXAp2VjiGJfeW4rgqJOVxqGuPoDnUoYAC7iPV9a1yPL1pUwsmTwZEAYtJA2JPL1AUwkrL2KBYVUYA306SfXViI6Fa2Pk(K0nejgm)h9VwwGa(DYW2xCd(g5wJ4(4JUP8OVA(UyNdsFbURXQt(oll1kFR2)ibR(KdD0S9hIxsOFhKgc4MGWoqbMUzW(gzbvGnXIbUCbmV0dWVd5yFl(XW7ArnP49rHZbdhOPmwm)c67Iy2i86nKnhVsl8(gtypnEfdmTTienatTePxYBqB401IoaEY8KhAZngqPj4DPmmb)CkojDRvWVQhFx6nHDm3k9q2upSv3Xf0qg)AhWfVunIRN9iLRXr3q2jIpNoDVa5sIyaFYEMk27RBoIb6MtXRpiHxvdfuMc)qMcQ287VWtWMKjR6fG3(g9jmgubYVZ673otg9620I)VHoc0JOT94TfnWmK1x0Rh87aIUeyGnJqQFJZpXBs3SGm1BXAZqiR)HLE3S)wJJpsPjlE5L0FxQXETOTq(BZpc7J0boyVqg2nkczmqykGh6csDb6CeFtM7jfD)(4ISVUdPlkmKLbVyTofzRJjNgbNiyps3gleht4cwaJZIHVhbHv0JV9lNE993C6196D61rHAumy5aZo8VWfcPgvYV7LlaYu2UUExOTCXlVu47axZxEbVn7BOCHIE15xQjnasLaMXq(kUR6Cjd8QtfeSZWa(vFe649QWi(TchNCG6iM7(K38LZrb4Kv0NAFU35sV9OX5xysr5czGsfVPGoecGFcLWytMq(cZsdEOLmfsv4q7(Dvx4qI(LU8)RhFC2JnFlAD6hAE9FnFqgUfdGrGX38FH3XdO0heOJqafeK4Md(SqsmwC7OmJ98BiEOhD9850DqcLw0sejcM5RvHSDM0pYtWx3QI7w4xoY4Aq5bf5JStRLUiDKKIn9XelvilV)GZ(lQnICMkX2cd6f2aZVJsY2b)qdXD8g80jEJ8sUUBNghrR)cx(BKT6LlesTZDZmQHxjm(m3X4E1m3flEwED)Vwc2FpbpXmHtMG3pJD7i)yrKaY)j9Byef)lJLhz0YGIdeTAH3VfJsaNxaARUO85vcH4eHASp(B3PMkV)FRh8BlqjsESE42C(16dkVrMaDfH6o1pCiYgtsQcdJ8xeE4KigYRFtUQyaXbmsJl6eLlIk(kYKiz(N9s5oboxHTs3pQ9zU8kjAIalOlbk1DnCMnFfsD17eSmPxDunWRHtbl21y6vACCAk5SDDJLZuRneDDXx19cE(qk9wJsF9OyZKWf5RrkAVEeLxD58EugmsnnQECi4UhasK87LgqEHsWskdIKg8SRkZPrESjCxLEI67vzZ(8j2SaXKHs4roNqJY5oKoveV8I5BjD9PxsVH0mQP9POAQcGrw186bFfVO2WBkB0GjO0ikCHNlLutIvhtKYs0kFU7LlaFkicfDRYaYjlqfo0nP9kp8c5Ia59fKOuV2IT5pWXfKjE75)OzPhvpSapdSzCGZOYVxJUNyUsVTWEnVl43e2PmVhZPoIBvofYL50zMkXNfmOE0e5oJMDeiA24yfxQUU7hE5fnNSAlthlCN8)9hPKZK9NbPS4THVz6PIOVQNBsK6BVHt(csDJNUmfrLU0FzAiptZH8773j(HRYUlzBvHsKJmicQ7jY5C18KwEmgbUwamk3XHS4G3KipV3DZjskvjJFyOX47IgV)0TBHDwdUbr2RUYWdYU9T3RMH5AyqCP87C78O(0wwV8sv3eEnnAWitA0590UaDHhw869KZFGxnRRcdss3rg5UOW2V0lzLuVnUhi8SWWNZ7R60oxir55C1j)oD)0EXxFlf9554p5oN9hzNbh6j4DaS(fr7PySjH(8FHctfen0wY49FRPL6X6oKErg7r(P)bKLlBBrC7T)JxyzfQhOEg7H(rSj)9vznB2ukNEsbRu3fPTnfi8cNsz4Ywzs6HWReq(wJ4sYdO5C3TgGxtEEt(jHgPmpeehmNtwNFfL7jgnUzrU4XJjhLPeU9qdjommOGYlLeJyAlnLikMnHE(875pjL8gcb(QUPR6lfVPHtBpce6z63lKn5Fq7lC)bAjmUcQz7qu6)Nqm8QXP5AqrgxCL8oHsZzVVUrY201xl8t1752U7ZR52tWzp9M5TRPlMxdgB2MPb2OR7GTj9yGNoJdfnKoXlEMqJsAakPX1SH8KP2deqPHghzEImvVSg51b9EpS2D1ZBh6sJuAgv4pfmH68Snmy)NWO7HPyiDdCpXikiF9vQVQfbTR5G4j0hMamjfyvgWKmsHB47nsKXUW0qoKZqodtoGQJrNiCzcCSc5RlsX1TM35TgvTw0jWu1aDA9(lLRxrb(2mRYDKhMjVkBOBL54ZtXgL2KcR6Kz0SzZIzb9DnmBTO20nN6q3CERJ5aVSt5CAvxcNgjU2y(51bZTgYyUzwfQV9fu3ZB5uZLK2AV2ROlSi)ihOQQWdpk9iry6HAHQFgFfklfnzOiTjPE(RicH6t3ZIcf4z72jZvi9E4RXrL7tD9wgof5d6cwdSUW2Ao1Mwxi1drpxPIoQCHwX2TNnCxr3leCJB6LnCo0j7sOeG6LoCXbOvroXeJLS6J0ibJ1OXU0A1I9ie4dLAbCbXaEHFhYWWSokFwIXkRHEJ4LWMZTy(TzyVv4ZEIN5qpWXmWEkeIUTiJlpgo0TYgwCm5D0A5Fi(lWkbDL7emvzOP(4fErycQfo4nNNDKawE3fNSI5YRpLY6Hxfw6TljTWNN7Pp3XOmMLZ1sySg5ApN9znOV15ZeR)bZ39jK8iNl37csWY3)fENztxKLNGPFkGckjI5Jocsv20LA)ZzErJfP7f(5YaQWjbHrZX9IS2Ta4Qo(g)WWX(lrFwEBHYHD2FqDna2qDyDxqD)aFOBuZDoNyN7SDjfJtEZOmKg(sd85cPaJmxaXRUacEngcfAyyWY4wjRw1P)flgLBqTqgbAkh7SPj9dnQQQLx9HxEP4CAnheWmAkXBN7yUMXo55)M37gusRZZ0wwuSOwAEohi908DeCyzJ4UBU)eLuGNWZQElT9KIPaVMzNSkAzfesW0svK6YaFdJUSYtFZxNfH59RhvcoEk(asXTHbYzHseI1hPSESEWFqFDC0On6jcmZTKnnZFsPKvk3FnLB1anAagtVb99zMonumSmhWLV8yZZVJ2n)QCPjeF0nG90ksUu3oxwE(kOCkBkMJktYb39bvUr10JO9mjCsOLVWl3mNOOT6vi9QvMrG)fbMgZHAv7LUQI7pY3fmqjQXEEcGKUmJZtcN6vNCwozvU5JZitVxSqljBOgLuLSLjdyjF6tZZfzUVfypHAsh3i(NIp8swJuQacerJf9Ar4YKy6OlGAHU9lT2ztlBz5wOnJnUWvz5GrR1wSuwfmVPMQQs5YVgfiTkpwIKTrTVBvfDukMBXuI8FACaLyrBFWbSz(cSLBzgkc3)0fR1fLlW7V5mSu58U6KCKC8ZCkDm2feCh0di)aGqM(0Ty9yOZhrelEPFY68VZM89OGqKhiGIFAINi0faTK2O1O8RaK5eWDLULPJxjlGcQNPKVAlCtrAWFB2MJCp9(JM0ytX(ybCNwUnSnBsQKCy29MdkfP6fUzK66nDPN3TnepexoUdxk2Hy4IZyBiFX4jVv0hYSN8ss9eZb9zvxQwVVt3a6Jjp1YCi7uBUX18hf01IzfxbXuY28RkIPHiBEDGtVO2bNncZ)T8Xb68EeJSUvNwQMHKEqAheN9NCAz2zu1lW9c5nUd6XPH2qMJBY7(AlNMh86AlyRZQbJOfYYAKarGe8IocktdxgnIvl(3CMQnS(CfzYim9NDXKgWvFhsMBvSmJnib1AgOi4kyZw5W2gxOVX3Y0mLUHR22Bno2OX3YdYOnS7kw8qSYcxA1Pg5zrufPY3C1762m)OFxEkiZN)YykUQBUM1sJK5DnQkO2oonBCK5BN8YtgLPTLJfRcJDh8rvjhK7YzwMSK8cvjNxk9v5cQ9iqxma8q4FWeyXgINFse286LZf1Z7gDmtu4V70UyxtGwgC(QgbG6GauX2MCxUVH3x88KGwO7vkK5QYkKTwbSP6hl8M7QUD4iujHSTzvpUkOz19tALElUXiYP7DiAdKFeVf5yciLygmjhlZvPnaygagocNGX7JjsYDc5DEwRFX)vr(lrkGYjsI)XQGoAgdxMKGK1nHa)DrNcSnWCt2yT3wa1SDMlQjNl(N3nZGz5nswkV)UUf0fL3IQCPvScGb8GYChpoonuo(jllTXM9sEd(hLcnXDkXVLMWs(mJCDF(2cmfvRbSGanyWrIKJigsU72be(tnefg88t99ztDh9myiW4WFx7gggSEkGQb(zvd9))U5QN3Kjgg8VLUGkQO27cWg0T3bM6a7ikLRQiHes8HuN43(BCsCItIJHRLsRqD7oUuNyhhh7h)8d4H(482aCdHBn)nWTrXPcUEMJFjoeF4EwcOuc4Jjj1d9GsFG3XiKVb7flMqy7)teEgBgxTXRtqhV23EOksnF282bTdyi2askFmXhdJnK5em)50XyX6d2HpzI6EqEmHYzqDy3KTcMI2ppg3mwhYUc(v((mqzoXxI9wtwLkJBd)cxbkga3JQ7x5oaJ81BBGZg8yaCiSGNxAe9H30ccHjSUt06D63mOsos)bvybdAos5XH9F4UoRHrkaljSj5w6ivJEO3oWXMTYZMI16I2byUf4zPC3cqCfyZkzB2r73couhehv0)S1Mg(a9wTgIZwFjEwU5GbNs2qUCYFpJOdoyHYASYxyC3j0tN(eurPx93y3I1rBvs0I3lB9sDOxMLnh2TEZEShSQlziW1B8WVB3xR956W0l)o1k4s)lnMmOAQV5AMBPn9poaucsiveyyHaSJ6buNWSu4yMHUmTlpY)hukHGLMaEECK5p93h2f4(TJGt4UVykqve8rhEmSyW5GuyYknHoFRk15BvvFrSQYzqVFmRQ6cwv5IG0cTI5L1swvQmRQcmFrrRkgw04kzvPKMqgh6tE3NjeWli4DZawnVpEKYImy2b(VJWzZ4t0LTC4Z8ZrRRr7TKwzF)PhTfBWWLdJJOvFmWwY8S2gA2a3Mruify5dds4eCMfExg97iAomgYJdfXnvpw35oA6fdXp3T12n6Nv6mfrr21wifIaz0WKYXOdjPF1dLKn6vcAN(uXRpvc0MYzRpvYUrcVtqFYtVAxz9zDQ(KrKVQ6ZBHDKCcMNzRUm6T)C7dVf25Xjyxy92VW(Tz71)n7))]] )