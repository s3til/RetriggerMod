--- STEAMODDED HEADER
--- MOD_NAME: s3tillection
--- MOD_ID: s3tillection
--- MOD_AUTHOR: [s3til]
--- MOD_DESCRIPTION: my general joker adding mod

----------------------------------------------
------------MOD CODE -------------------------

local config = {
    j_lucky_seven = true,
    j_forgotten = true
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
            SMODS.findModByID("s3tillection").path,
            joker.slug .. ".png",
            71,
            95,
            "asset_atli"
        )
        sprite:register()
    end
end


function SMODS.INIT.s3tillection()
    init_localization()

    
    if config.j_forgotten then
        local j_forgotten = {
            loc = {
                name = "Forgotten",
                text = {
                    "+1 {C:attention}Joker Slot{}"
                }
            },
            ability_name = "Forgotten",
            slug = "forgotten",
            ability = {
                extra = {
                    j_slots = 1
                }
            },
            rarity = 2,
            cost = 8,
            unlocked = true,
            discovered = true,
            blueprint_compat = false,
            eternal_compat = true,
        }
        -- Initialize Joker
        init_joker(j_forgotten)
         -- Set local variables
    function SMODS.Jokers.j_forgotten.loc_def(card)
        return { card.ability.extra.j_slots}
    end
end


local add_to_deckref = Card.add_to_deck
function Card:add_to_deck(from_debuff)
    if not self.added_to_deck then
        if self.ability.name == "Forgotten" then
            -- Add Joker slot
            G.jokers.config.card_limit = G.jokers.config.card_limit + self.ability.extra.j_slots
        end
        add_to_deckref(self, from_debuff)
    end
end

local remove_from_deckref = Card.remove_from_deck
function Card:remove_from_deck(from_debuff)
    if self.added_to_deck then
        if self.ability.name == "Forgotten" then
            -- Remove Joker slot
            G.jokers.config.card_limit = G.jokers.config.card_limit - self.ability.extra.j_slots
        end    
        remove_from_deckref(self, from_debuff)
    end
end

if config.j_lucky_seven then
    local j_lucky_seven = {
        loc = {
            name = "Lucky Seven",
            text = {
                "Scored sevens have a",
                "{C:green}#1# in #2#{} chance to give",
                "{C:mult}+28{} Mult and {C:attention}$7{}"
            }
        },
        ability_name = "Lucky Seven",
        slug = "lucky_seven",
        ability = {
            extra = {
                odds = 7,
                mult = 28,
                cash = 7
            }
        },
        rarity = 1,
        cost = 7,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true,
    }
    -- Initialize Joker
    init_joker(j_lucky_seven)
     -- Set local variables
function SMODS.Jokers.j_lucky_seven.loc_def(card)
    return { G.GAME.probabilities.normal, card.ability.extra.odds, card.ability.extra.mult, card.ability.extra.cash}
end
-- Calculate
SMODS.Jokers.j_lucky_seven.calculate = function(self, context)
    if context.individual and context.cardarea == G.play and context.other_card:get_id() == 7 then
        if pseudorandom("lucky_seven") < G.GAME.probabilities.normal / self.ability.extra.odds then
            
            return {
                message = localize{type='variable', key='a_mult', vars={self.ability.extra.mult}},
                mult = self.ability.extra.mult,
                delay = 0.2,
                dollars = 7,
                card = self,
            }
        end
    end
end


end

end