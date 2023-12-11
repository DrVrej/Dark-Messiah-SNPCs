ENT.Base 			= "npc_vj_creature_base"
ENT.Type 			= "ai"
ENT.PrintName 		= "Giant Worm"
ENT.Author 			= "DrVrej"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose 		= "Have Worm Sex."
ENT.Instructions 	= "Click on it to spawn it."
ENT.Category		= "Dark Messiah"

if (CLIENT) then
local Name = "Giant Worm"
local LangName = "npc_vj_dmvj_giant_worm"
language.Add(LangName, Name)
killicon.Add(LangName,"HUD/killicons/default",Color(255,80,0,255))
language.Add("#"..LangName, Name)
killicon.Add("#"..LangName,"HUD/killicons/default",Color(255,80,0,255))
end