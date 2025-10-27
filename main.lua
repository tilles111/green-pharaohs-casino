--- STEAMODDED HEADER
--- MOD_NAME: Green Pharaoh's Casino
--- MOD_ID: GREEN_PHARHAOHS_CASINO
--- MOD_AUTHOR: [Tilles]
--- MOD_DESCRIPTION: Honestly IDK.
--- PREFIX: greenpharaoh
----------------------------------------------
------------MOD CODE -------------------------

SMODS.Atlas{
    key = 'jokers', --atlas key
    path = 'jokers.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}
SMODS.ObjectType{
	object_type = "ObjectType",
	key = "GreenPharaohCasino",
    cards = {
        ["whitepharaoh"] = true
    }
}
SMODS.ObjectType{
	object_type = "ObjectType",
	key = "Emotiguy",
    cards = {
        ["emotiguy"] = true
    }
}
SMODS.ObjectType{
	object_type = "ObjectType",
	key = "CasinoWheel",
    cards = {
        ["casinowheel"] = true
    }
}
SMODS.ObjectType{
	object_type = "ObjectType",
	key = "Worldshaper",
    cards = {
        ["worldshaper"] = true
    }
}

SMODS.Joker{
    key = 'whitepharaoh',
    loc_txt = {
        name = 'White Pharaoh',
        text = {
            '{X:mult,C:white}+5-10{} Mult',
            'Gain or lose {C:money}$0-3{} at end of round'
        }
    },
    atlas = 'jokers',
    pos = {x = 0, y = 0},
    rarity = 1,
    cost = 2,
    pools = { ["GreenPharaohCasino"] = true },
    unlocked = true,  
    
    blueprint_compat = true, 
    config = { 
      extra = {
        mult = 0 
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.mult}}
    end,
    calculate = function(self,card,context)
        card.ability.extra.mult = math.random(5, 10)
        if context.joker_main then
            return {
                card = card,
                mult_mod = card.ability.extra.mult,
                message = '+' .. card.ability.extra.mult,
                colour = G.C.MULT
            }
        end
    end,
    calc_dollar_bonus = function(self,card)
        return math.random(-3, 3)
    end
}

SMODS.Joker{
    key = 'greenpharaoh',
    loc_txt = {
        name = 'Green Pharaoh',
        text = {
            '{X:mult,C:white}X1-3{} Mult',
            'Gain or lose {C:money}$0-5{} at end of round'
        }
    },
    atlas = 'jokers',
    pos = {x = 1, y = 0},
    rarity = 2,
    cost = 2,
    pools = { ["GreenPharaohCasino"] = true },
    unlocked = true,  
    blueprint_compat = true, 
    config = { 
      extra = {
        Xmult = 0 
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult}}
    end,
    calculate = function(self,card,context)
        card.ability.extra.Xmult = math.random(1, 3)
        if context.joker_main then
            return {
                card = card,
                Xmult_mod = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult,
                colour = G.C.MULT
            }
        end
    end,
    calc_dollar_bonus = function(self,card)
        return math.random(-5, 5)
    end
}

SMODS.Joker{
    key = 'skamtebord',
    loc_txt = {
        name = 'Skamtebord',
        text = {
            "{C:yellow}Emotiguy{} Jokers",
            "each give {X:chips,C:white}X#1# {} Chips"
        }
    },
    atlas = 'jokers',
    pos = {x = 3, y = 0},
    rarity = 2,
    cost = 8,
    pools = { ["GreenPharaohCasino"] = true, ["Emotiguy"] = true },
    unlocked = true,  
    blueprint_compat = true, 
    config = { extra = {xchips = 1.5} },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xchips } }
    end,
    calculate = function(self, card, context)
        if context.other_joker then
            if (context.other_joker.config.center.pools or {})["Emotiguy"] then
                return {
                    xchips = card.ability.extra.xchips
                }
            end
        end
    end
}

SMODS.Joker{
    key = 'emotiguy',
    loc_txt = {
        name = 'Emotiguy',
        text = {
            '{X:chips,C:white}+#1#{} Chips'
        }
    },
    atlas = 'jokers',
    pos = {x = 0, y = 1},
    rarity = 1,
    cost = 3,
    pools = { ["GreenPharaohCasino"] = true, ["Emotiguy"] = true },
    unlocked = true,
    blueprint_compat = true, 
    config = { 
      extra = {
        chips = 50 
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.chips}} --#1# is replaced with card.ability.extra.chips
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return {
                card = card,
                chips = card.ability.extra.chips,
                colour = G.C.CHIPS
            }
        end
    end
}

SMODS.Joker{
    key = 'wrathfulemotiguy',
    loc_txt = {
        name = 'Wrathful Emotiguy',
        text = {
            '{X:chips,C:white}X0.5{} Chips',
            '{X:mult,C:white}X1.5{} Mult'
        }
    },
    atlas = 'jokers',
    pos = {x = 1, y = 1},
    rarity = 2,
    cost = 5,
    pools = { ["GreenPharaohCasino"] = true, ["Emotiguy"] = true },
    unlocked = true,  
    blueprint_compat = true, 
    config = {
        extra = {
            xchips = 0.5,
            Xmult = 1.5
        }
    },

    loc_vars = function(self, info_queue, card)
        return {vars = {}}
    end,

    calculate = function(self, card, context)
        if context.joker_main then
                return {
                    x_chips = card.ability.extra.xchips,
                    extra = {
                        Xmult = card.ability.extra.Xmult
                        }
                }
        end
    end
}

SMODS.Joker{
    key = 'gcat',
    loc_txt = {
        name = 'JEO_Cat',
        text = {
            "When {C:attention}Blind{} is selected,",
            "create {C:attention}a Perishable {C:dark_edition}Negative",
            "{C:green}Green Pharaoh's Casino{C:attention} Joker"
        }
    },
    atlas = 'jokers',
    pos = {x = 2, y = 1},
    rarity = 4,
    cost = 20,
    pools = { ["GreenPharaohCasino"] = true },
    unlocked = true,    
    blueprint_compat = true, 
    calculate = function(self, card, context)
        if context.setting_blind then
            G.E_MANAGER:add_event(Event({
                func = (function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card({ set = 'GreenPharaohCasino', edition = "e_negative", stickers = { "perishable" } })
                            return true
                        end
                    }))
                    SMODS.calculate_effect({ message = "+1 Green Pharaoh's Casino Joker", colour = G.C.GREEN },
                        context.blueprint_card or card)
                    return true
                end)
            }))
            return nil, true -- This is for Joker retrigger purposes
        end
    end
}

SMODS.Joker{
    key = 'frogthejam',
    loc_txt = {
        name = 'Frog The Jam',
        text = {
            "{C:yellow}Emotiguy{} Jokers",
            "each give {X:mult,C:white} X#1# {} Mult"
        }
    },
    atlas = 'jokers',
    pos = {x = 3, y = 1},
    rarity = 4,
    cost = 20,
    pools = { ["GreenPharaohCasino"] = true },
    unlocked = true,  
    blueprint_compat = true, 
    config = { extra = {xmult = 1.5} },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.other_joker then
            if (context.other_joker.config.center.pools or {})["Emotiguy"] then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end
}

SMODS.Joker{
    key = 'deepacar',
    loc_txt = {
        name = 'Deepa Car',
        text = {
            "If you have between {C:attention}#1# and #2#{} Chips,",
            "create a {C:spectral}Worldshaper{} card",
            "Range changes every round"
        }
    },
    atlas = 'jokers',
    pos = {x = 0, y = 2},
    rarity = 4,
    cost = 20,
    pools = { ["GreenPharaohCasino"] = true },
    unlocked = true,  
    blueprint_compat = false, 
    config = {
        extra = {
            minchips = 50,
            maxchips = 100
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.minchips, card.ability.extra.maxchips } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if hand_chips >= card.ability.extra.minchips and hand_chips <= card.ability.extra.maxchips then
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card {set = 'Spectral', key = 'c_greenpharaoh_worldshaper'}
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                    return {
                        message = localize('k_plus_spectral'),
                        colour = G.C.SECONDARY_SET.Spectral,
                        remove = true
                    }
                end
            end
        end

        if context.ending_shop then
            card.ability.extra.minchips = math.random(50, 100)
            card.ability.extra.maxchips = card.ability.extra.minchips + math.random(10, 50)
        end
    end
}

SMODS.Joker{
    key = 'guyinasuit',
    loc_txt = {
        name = 'Guy in a Suit',
        text = {
            "{X:chips,C:white}+#1#{} Chips",
            "{X:mult,C:white}+#2#{} Mult",
            "{X:chips,C:white}X#3#{} Chips",
            "{X:mult,C:white}X#4#{} Mult"
        }
    },
    atlas = 'jokers',
    pos = {x = 1, y = 2},
    rarity = 3,
    cost = 10,
    pools = { ["GreenPharaohCasino"] = true },
    unlocked = true, 
    blueprint_compat = true, 
    config = {
        extra = {
            chips = 1,
            mult = 1,
            xchips = 1,
            Xmult = 1
        }
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.xchips, card.ability.extra.Xmult } }
    end,

    calculate = function(self, card, context)
        card.ability.extra.chips = math.random(0, 50)
        card.ability.extra.mult = math.random(0, 50)
        card.ability.extra.xchips = math.random(1, 5)
        card.ability.extra.Xmult = math.random(1, 5)
        if context.joker_main then
                return {
                    chips = card.ability.extra.chips,
                    mult = card.ability.extra.mult,
                    x_chips = card.ability.extra.xchips,
                    Xmult = card.ability.extra.Xmult
                }
        end
    end
}

SMODS.Joker{
    key = 'greate',
    loc_txt = {
        name = 'Greate',
        text = {
            '{X:chips,C:white}+#1#{} Chips',
            '{X:mult,C:white}+#2#{} Mult'
        }
    },
    atlas = 'jokers',
    pos = {x = 2, y = 2},
    rarity = 1,
    cost = 3,
    pools = { ["GreenPharaohCasino"] = true },
    unlocked = true,
    blueprint_compat = true, 
    config = { 
      extra = {
        chips = 30, 
        mult = 3 
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.chips, center.ability.extra.mult}} --#1# is replaced with card.ability.extra.chips
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult
            }
        end
    end
}

SMODS.Joker{
    key = 'purplepharaoh',
    loc_txt = {
        name = 'Purple Pharaoh',
        text = {
            '{X:chips,C:white}X1-3{} Chips',
            'Gain or lose {C:money}$0-5{} at end of round'
        }
    },
    atlas = 'jokers',
    pos = {x = 3, y = 2},
    rarity = 2,
    cost = 2,
    pools = { ["GreenPharaohCasino"] = true },
    unlocked = true,  
    blueprint_compat = true, 
    config = { 
      extra = {
        xchips = 0 
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.xchips}}
    end,
    calculate = function(self,card,context)
        card.ability.extra.xchips = math.random(1, 3)
        if context.joker_main then
            return {
                x_chips = card.ability.extra.xchips
            }
        end
    end,
    calc_dollar_bonus = function(self,card)
        return math.random(-5, 5)
    end
}

SMODS.Joker{
    key = 'emma',
    loc_txt = {
        name = 'emma',
        text = {
            'emma'
        }
    },
    atlas = 'jokers',
    pos = {x = 2, y = 3},
    rarity = 1,
    cost = 2,
    pools = { ["GreenPharaohCasino"] = true },
    unlocked = true,  
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
                randommessage = math.random(1, 3)
                if randommessage == 1 then
                    return {
                        message = "emma"
                    }
                elseif randommessage == 2 then
                    return {
                        message = "3-4"
                    }
                elseif randommessage == 3 then
                    return {
                        message = "Joker? I barely know her!"
                    }
                end
        end
    end
}

SMODS.Seal {
    key = 'Blobcat',
    loc_txt = {
        name = 'Blobcat Seal',
        text = {
            'Has the effects of all vanilla seals'
        }
    },
    atlas = 'jokers',
    pos = { x = 0, y = 3 },
    config = { extra = { retriggers = 1, money = 1 } },
    badge_colour = G.C.GOLD,
    get_p_dollars = function(self, card)
        return card.ability.seal.extra.money
    end,
    calculate = function(self, card, context)
        if context.repetition then
            return {
                repetitions = card.ability.seal.extra.retriggers,
            }
        elseif context.discard and context.other_card == card and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = function()
                    SMODS.add_card({ set = 'Tarot' })
                    G.GAME.consumeable_buffer = 0
                    return true
                end
            }))
            return { message = localize('k_plus_tarot'), colour = G.C.PURPLE }
        --elseif context.end_of_round and context.cardarea == G.hand and context.other_card == card and (#G.consumeables.cards + G.GAME.consumeable_buffer) < G.consumeables.config.card_limit then
        --    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
        --    G.E_MANAGER:add_event(Event({
        --        trigger = 'before',
        --        delay = 0.0,
        --        func = function()
        --            if G.GAME.last_hand_played then
        --                local _planet = nil
        --                for k, v in pairs(G.P_CENTER_POOLS.Planet) do
        --                    if v.config.hand_type == G.GAME.last_hand_played then
        --                        _planet = v.key
        --                    end
        --                end
        --                if _planet then
        --                    SMODS.add_card({ key = _planet })
        --                end
        --                G.GAME.consumeable_buffer = 0
        --            end
        --            return true
        --        end
        --    }))
        --    return { message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet }
        end
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.retriggers } }
    end
}

SMODS.Consumable {
    key = 'worldshaper',
    loc_txt = {
        name = "Worldshaper",
        text = {
            "Add a {C:gold}Blobcat Seal{}",
            "to {C:attention}1{} selected",
            "card in your hand",
        }
    },
    set = 'Spectral',
    atlas = 'jokers',
    pools = { ["Worldshaper"] = true },
    pos = { x = 1, y = 3 },
    config = { extra = { seal = 'greenpharaoh_Blobcat' }, max_highlighted = 1 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
        return { vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        local conv_card = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                conv_card:set_seal(card.ability.extra.seal, nil, true)
                return true
            end
        }))

        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
    end
}


SMODS.Consumable {
    key = 'casinowheel',
    loc_txt = {
        name = 'Casino Wheel',
        text = {
            "Creates a random Green Pharaoh's Casino joker."
        }
    },
    set = 'Tarot',
    atlas = 'jokers',
    name = "casinowheel",
    pools = { ["CasinoWheel"] = true },
    pos = { x = 2, y = 0 },
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                SMODS.add_card({ set = 'GreenPharaohCasino' })
                check_for_unlock { type = 'spawn_legendary' }
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return G.jokers and #G.jokers.cards < G.jokers.config.card_limit
    end
}

----------------------------------------------

------------MOD CODE END----------------------
