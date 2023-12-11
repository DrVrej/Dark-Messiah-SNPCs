ENT.Base 			= "npc_vj_creature_base"
ENT.Type 			= "ai"
ENT.PrintName 		= "Spider Queen"
ENT.Author 			= "DrVrej"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose 		= "She's your mother!"
ENT.Instructions 	= "Click to spawn it."
ENT.Category		= "Dark Messiah"

if (CLIENT) then
local Name = "Spider Queen"
local LangName = "npc_vj_dmvj_spider_queen"
language.Add(LangName, Name)
killicon.Add(LangName,"HUD/killicons/default",Color(255,80,0,255))
language.Add("#"..LangName, Name)
killicon.Add("#"..LangName,"HUD/killicons/default",Color(255,80,0,255))
end