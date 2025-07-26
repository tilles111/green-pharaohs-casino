SMODS.Joker{ --New Joker
    name = "New Joker",
    key = "newjoker",
    config = {
        extra = {
            j_joker = 0
        }
    },
    loc_txt = {
        ['name'] = 'New Joker',
        ['text'] = {
            [1] = 'A {C:blue}custom{} joker with {C:red}unique{} effects.'
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'Joker',

    loc_vars = function(self, info_queue, card)
        return {vars = {}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
                local created_joker = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local joker_card = SMODS.add_card({ set = 'Joker' })
                            if joker_card then
                                joker_card:set_edition({ negative = true }, true)
                            end
                            return true
                        end
                    }))
                return {
                    message = created_joker and localize('k_plus_joker') or nil
                }
        end
    end
}