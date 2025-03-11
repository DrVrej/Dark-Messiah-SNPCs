/*--------------------------------------------------
	*** Copyright (c) 2012-2025 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
VJ.AddPlugin("Dark Messiah SNPCs", "NPC")

local spawnCategory = "Dark Messiah"

VJ.AddNPC("Spider Queen", "npc_vj_dm_spider_queen", spawnCategory)
VJ.AddNPC("Spider", "npc_vj_dm_spider", spawnCategory)
VJ.AddNPC("Giant Worm", "npc_vj_dm_giant_worm", spawnCategory)
VJ.AddNPC("Facehugger", "npc_vj_dm_facehugger", spawnCategory)

-- ConVars --
VJ.AddConVar("vj_dm_nobabyspawn", 1, FCVAR_ARCHIVE)
VJ.AddConVar("vj_dm_nextbaby", 40, FCVAR_ARCHIVE)
VJ.AddConVar("vj_dm_babyspawnlimit", 9, FCVAR_ARCHIVE)

-- Menu --
if CLIENT then
	hook.Add("PopulateToolMenu", "VJ_ADDTOMENU_DM", function()
		spawnmenu.AddToolMenuOption("DrVrej", "SNPC Configures", "Dark Messiah", "Dark Messiah", "", "", function(Panel)
			if !game.SinglePlayer() && !LocalPlayer():IsAdmin() then
				Panel:AddControl("Label", {Text = "#vjbase.menu.general.admin.not"})
				Panel:AddControl( "Label", {Text = "#vjbase.menu.general.admin.only"})
				return
			end
			Panel:AddControl( "Label", {Text = "#vjbase.menu.general.admin.only"})
			Panel:AddControl("Button", {Text = "#vjbase.menu.general.reset.everything", Command = "vj_dm_nobabyspawn 1\n vj_dm_nextbaby 40\n vj_dm_babyspawnlimit 9"})
			Panel:AddControl("Checkbox", {Label = "Spider Queen Spawns Baby Spiders", Command = "vj_dm_nobabyspawn"})
			Panel:AddControl("Slider", {Label = "Baby Spider Limit", min = 3, max = 99, Command = "vj_dm_babyspawnlimit"})
			Panel:ControlHelp("How many baby spiders are allowed per queen")
			Panel:ControlHelp("Rounded to the nearest OR lowest multiple of 3!")
			Panel:AddControl("Slider", {Label = "Next Baby Spider Spawn", min = 0, max = 300, Command = "vj_dm_nextbaby"})
			Panel:ControlHelp("How much time until Spider Queen can spawn Spiders again?")
			Panel:ControlHelp("Total of 300 seconds (5 Minutes)")
		end)
	end)
end