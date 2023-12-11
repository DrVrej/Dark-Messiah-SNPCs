/*--------------------------------------------------
	=============== Autorun File ===============
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
------------------ Addon Information ------------------
local PublicAddonName = "Dark Messiah SNPCs"
local AddonName = "Dark Messiah"
local AddonType = "SNPC"
local AutorunFile = "autorun/vj_dms_autorun.lua"
-------------------------------------------------------
local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua","GAME")
if VJExists == true then
	include('autorun/vj_controls.lua')

	local vCat = "Dark Messiah"

	VJ.AddNPC("Spider Queen","npc_vj_dmvj_spider_queen",vCat)
	VJ.AddNPC("Spider","npc_vj_dmvj_spider",vCat)
	VJ.AddNPC("Giant Worm","npc_vj_dmvj_giant_worm",vCat)
	VJ.AddNPC("FaceHugger","npc_vj_dmvj_facehugger",vCat)
	
	-- Menu --
	VJ.AddConVar("vj_dm_nobabyspawn", 1, {FCVAR_ARCHIVE})
	VJ.AddConVar("vj_dm_nextbaby", 40, {FCVAR_ARCHIVE})
	VJ.AddConVar("vj_dm_babyspawnlimit", 9, {FCVAR_ARCHIVE})

	if CLIENT then
		hook.Add("PopulateToolMenu", "VJ_ADDTOMENU_DM", function()
			spawnmenu.AddToolMenuOption("DrVrej", "SNPC Configures", "Dark Messiah", "Dark Messiah", "", "", function(Panel)
				if !game.SinglePlayer() && !LocalPlayer():IsAdmin() then
					Panel:AddControl("Label", {Text = "#vjbase.menu.general.admin.not"})
					Panel:AddControl( "Label", {Text = "#vjbase.menu.general.admin.only"})
					return
				end
				Panel:AddControl( "Label", {Text = "#vjbase.menu.general.admin.only"})
				Panel:AddControl("Button",{Text = "#vjbase.menu.general.reset.everything", Command = "vj_dm_nobabyspawn 1\n vj_dm_nextbaby 40\n vj_dm_babyspawnlimit 9"})
				Panel:AddControl("Checkbox", {Label = "Spider Queen Spawns Baby Spiders", Command = "vj_dm_nobabyspawn"})
				Panel:AddControl("Slider",{Label = "Baby Spider Limit",min = 3,max = 99,Command = "vj_dm_babyspawnlimit"})
				Panel:ControlHelp("How many baby spiders are allowed per queen")
				Panel:ControlHelp("Rounded to the nearest OR lowest multiple of 3!")
				Panel:AddControl("Slider",{Label = "Next Baby Spider Spawn",min = 0,max = 300,Command = "vj_dm_nextbaby"})
				Panel:ControlHelp("How much time until Spider Queen can spawn Spiders again?")
				Panel:ControlHelp("Total of 300 seconds (5 Minutes)")
			end)
		end)
	end
-- !!!!!! DON'T TOUCH ANYTHING BELOW THIS !!!!!! -------------------------------------------------------------------------------------------------------------------------
	AddCSLuaFile(AutorunFile)
	VJ.AddAddonProperty(AddonName,AddonType)
else
	if (CLIENT) then
		chat.AddText(Color(0,200,200),PublicAddonName,
		Color(0,255,0)," was unable to install, you are missing ",
		Color(255,100,0),"VJ Base!")
	end
	timer.Simple(1,function()
		if not VJF then
			if (CLIENT) then
				VJF = vgui.Create("DFrame")
				VJF:SetTitle("ERROR!")
				VJF:SetSize(790,560)
				VJF:SetPos((ScrW()-VJF:GetWide())/2,(ScrH()-VJF:GetTall())/2)
				VJF:MakePopup()
				VJF.Paint = function()
					draw.RoundedBox(8,0,0,VJF:GetWide(),VJF:GetTall(),Color(200,0,0,150))
				end
				
				local VJURL = vgui.Create("DHTML",VJF)
				VJURL:SetPos(VJF:GetWide()*0.005, VJF:GetTall()*0.03)
				VJURL:Dock(FILL)
				VJURL:SetAllowLua(true)
				VJURL:OpenURL("https://sites.google.com/site/vrejgaming/vjbasemissing")
			elseif (SERVER) then
				timer.Create("VJBASEMissing",5,0,function() print("VJ Base is Missing! Download it from the workshop!") end)
			end
		end
	end)
end