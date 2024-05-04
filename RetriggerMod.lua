--- STEAMODDED HEADER
--- MOD_NAME: RetriggerMod
--- MOD_ID: RetriggerMod
--- MOD_AUTHOR: [s3til]
--- MOD_DESCRIPTION: Adds four retrigger jokers, oen for each suit.

----------------------------------------------
------------MOD CODE -------------------------

local config = {
        j_the_mark = true,
        j_the_disc = true,
        j_the_star = true,
        j_the_crescent = true,
    }


    local function init_joker(joker, no_sprite)
        no_sprite = no_sprite or false
    
        local joker = SMODS.Joker:new(
            joker.ability_name,
            joker.slug,
            joker.ability,
            { x = 0, y = 0 },
            joker.loc,
            joker.rarity,
            joker.cost,
            joker.unlocked,
            joker.discovered,
            joker.blueprint_compat,
            joker.eternal_compat,
            joker.effect,
            joker.atlas,
            joker.soul_pos
        )
        joker:register()
        if not no_sprite then
            local sprite = SMODS.Sprite:new(
                joker.slug,
                SMODS.findModByID("RetriggerMod").path,
                joker.slug .. ".png",
                71,
                95,
                "asset_atli"
            )
            sprite:register()
        end
    end

    function SMODS.INIT.RetriggerMod()
        init_localization()

        if config.j_the_mark then
            local the_mark = {
                loc = {
                    name = "The Mark",
                    text = {
                        "{C:attention}Retrigger{} all",
                        "played {C:attention}spades{}"
                    }
                },
                ability_name = "The Mark",
                slug = "the_mark",
                ability = {
                    extra = {
                        loop_amount = 1,
                    }
                },
                rarity = 3,
                cost = 10,
                unlocked = true,
                discovered = true,
                blueprint_compat = true,
                eternal_compat = true,
            }
            -- Initialize Joker
            init_joker (the_mark)
             -- Set local variables
        function SMODS.Jokers.j_the_mark.loc_def(card)
            return { card.ability.extra.loop_amount }
        end
        -- Calculate
        SMODS.Jokers.j_the_mark.calculate = function(self, context)
            if context.repetition and context.cardarea == G.play then
                if context.other_card:is_suit("Spades") and not context.other_card.debuff then
                    return {
                        message = localize('k_again_ex'),
                        repetitions = 1,
                        card = self
                    }
                end
            end
        end
    end
    if config.j_the_disc then
        local the_disc = {
            loc = {
                name = "The Disc",
                text = {
                    "{C:attention}Retrigger{} all",
                    "played {C:attention}hearts{}"
                }
            },
            ability_name = "The Disc",
            slug = "the_disc",
            ability = {
                extra = {
                    loop_amount = 1,
                }
            },
            rarity = 3,
            cost = 10,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true,
        }
        -- Initialize Joker
        init_joker (the_disc)
         -- Set local variables
    function SMODS.Jokers.j_the_disc.loc_def(card)
        return { card.ability.extra.loop_amount }
    end
    -- Calculate
    SMODS.Jokers.j_the_disc.calculate = function(self, context)
        if context.repetition and context.cardarea == G.play then
            if context.other_card:is_suit("Hearts") and not context.other_card.debuff then
                return {
                    message = localize('k_again_ex'),
                    repetitions = 1,
                    card = self
                }
            end
        end
    end
end
    if config.j_the_star then
        local the_star = {
            loc = {
                name = "The Star",
                text = {
                    "{C:attention}Retrigger{} all",
                    "played {C:attention}diamonds{}"
                }
            },
            ability_name = "The Star",
            slug = "the_star",
            ability = {
                extra = {
                    loop_amount = 1,
                }
            },
            rarity = 3,
            cost = 10,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true,
        }
        -- Initialize Joker
        init_joker (the_star)
         -- Set local variables
    function SMODS.Jokers.j_the_star.loc_def(card)
        return { card.ability.extra.loop_amount }
    end
    -- Calculate
    SMODS.Jokers.j_the_star.calculate = function(self, context)
        if context.repetition and context.cardarea == G.play then
            if context.other_card:is_suit("Diamonds") and not context.other_card.debuff then
                return {
                    message = localize('k_again_ex'),
                    repetitions = 1,
                    card = self
                }
            end
        end
    end
end
            if config.j_the_crescent then
            local the_crescent = {
                loc = {
                    name = "The Crescent",
                    text = {
                        "{C:attention}Retrigger{} all",
                        "played {C:attention}clubs{}"
                    }
                },
                ability_name = "The Crescent",
                slug = "the_crescent",
                ability = {
                    extra = {
                        loop_amount = 1,
                    }
                },
                rarity = 3,
                cost = 10,
                unlocked = true,
                discovered = true,
                blueprint_compat = true,
                eternal_compat = true,
            }
            -- Initialize Joker
            init_joker (the_crescent)
             -- Set local variables
        function SMODS.Jokers.j_the_crescent.loc_def(card)
            return { card.ability.extra.loop_amount }
        end
        -- Calculate
        SMODS.Jokers.j_the_crescent.calculate = function(self, context)
            if context.repetition and context.cardarea == G.play then
                if context.other_card:is_suit("Clubs") and not context.other_card.debuff then
                    return {
                        message = localize('k_again_ex'),
                        repetitions = 1,
                        card = self
                    }
                end
            end
        end
    end
end