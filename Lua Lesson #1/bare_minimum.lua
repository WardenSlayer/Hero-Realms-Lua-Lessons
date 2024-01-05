--These "require" are imports to other HR code needed to run the game.
--You should be able to just reuse these same ones every time
require 'herorealms'
require 'decks'
require 'stdlib'
require 'timeoutai'
require 'hardai_2'
require 'aggressiveai'
--=======================================================================================================
-- This lua file file contains the minimum amount of parts to run a game with both options for player setup used.
-- You probably will only use one of the methods each script.
--Player 1 is using the data form the class/character they chose.
--Player 2 is using a custom defined character/class data
--This game will play out like a normal game.
--=======================================================================================================
function setupGame(g)
	registerCards(g, {
        --You only need to register new cards here (so nothing to see here for now)
	})

    standardSetup(g, {
        description = "Bare Minimum: Default Player Data<br>Created by WardenSlayer.",
        --This defines the play order, only 2 players is supported at this time
        playerOrder = { plid1, plid2 },
        --AI is optional but I always include it to have the option to test with an AI player
        --
        ai = ai.CreateKillSwitchAi(createAggressiveAI(),  createHardAi2()),
        timeoutAi = createTimeoutAi(),
        opponents = { { plid1, plid2 } },
        --This player object contains/creates all the information about each player.
        --In this example the data is imported from the player/character (ie the class, health, and starting cards)
        players = {
            {
                id = plid1,
                --Uncomment the line below to make this player an AI. One note about AI, it doesnt work in online games so make sure to comment it back out before uploading
                --isAi = true,
                --This sets how many cards a player has on thier first turn (player 1 normally has only 3)
                startDraw = 3,
				init = {
                    --This is the part where the character data is imported
                    fromEnv = plid1
                },
                cards = {
                    --Since the starting deck cards/skills are predetermined, only buffs need to be here
					buffs = {
                        --This sets how many cards a player draws at the end of the turn, normally 5
                        drawCardsCountAtTurnEndDef(5),
                        --This handles the case where a player needs to discard a card at the start of their turn (discard effects/skills)
                        discardCardsAtTurnStartDef(),
                        --This is used to track the turn counter so the "Enrage" syste, triggers to try and end the game after the set number of turns.
						fatigueCount(40, 1, "FatigueP1"),
					}
                }
            },
            --In this example the player/character data is defined manually (good for making fresh starts or custom classes)
            {
                id = plid2,
                --Uncomment the line below to make this player an AI. 
                isAi = true,
                --This sets how many cards a player has on thier first turn.
                startDraw = 5,
                --This populates the name of the character in the game
                name = "Custom Name 5000",
                --This changes the icon image for the player (normally it is based on your class/gender but can use anything from the LUA doc avatar list)
                avatar="assassin",
                --This sets the starting health and by extension the player's health cap
                health = 50,
                --You can use custom cards below but for this example I am starting with the easiest way to learn
                --by using already existing cards. You can find a list in the Lua doc.
                cards = {
                    --This defines the starting deck composition
                    deck = {
                        --2 daggers and 8 gold
                        { qty=2, card=dagger_carddef() },
                        { qty=8, card=gold_carddef() },
                    },
                    --This defines the skills/abilities/armor the player has
                    skills = {
                        --Skill: Lift
                        {qty = 1, card = thief_lift_carddef() },
                        --Ability: Devastating Blow
                        {qty = 1, card = fighter_devastating_blow_carddef()},
                        --This an armor card but it works here too (ranger cloak)
                        {qty = 1, card = ranger_hunters_cloak_carddef()},
                    },
                    buffs = {
                        --These are the same as above for player 1 with one exception, make sure player 2 has their
                        --own fatigue counter (ie "FatigueP2") or it will trigger early
                        drawCardsCountAtTurnEndDef(5),
                        discardCardsAtTurnStartDef(),
                        fatigueCount(40, 1, "FatigueP2")
                    }
                }
            },            
        }
    })
end

--=======================================================================================================
--This triggers when the game ends
function endGame(g)
end

--=======================================================================================================

function setupMeta(meta)
    meta.name = "bare_minimum"
    meta.minLevel = 0
    meta.maxLevel = 0
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = "C:/Users/xTheC/Desktop/Git Repositories/Hero-Realms-Lua-Lessons/Lua Lesson #1/bare_minimum.lua"
     meta.features = {
}

end