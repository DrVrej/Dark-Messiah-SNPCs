/*--------------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "obj_vj_projectile_base"
ENT.PrintName		= "Toxic Gas"
ENT.Author 			= "DrVrej"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Information		= "Projectile, usually used for NPCs & Weapons"
ENT.Category		= "Projectiles"

ENT.PhysicsSolidMask = MASK_SHOT

if CLIENT then
	local Name = "Toxic Gas"
	local LangName = "obj_vj_dm_gas"
	language.Add(LangName, Name)
	killicon.Add(LangName,"HUD/killicons/default",Color(255,80,0,255))
	language.Add("#"..LangName, Name)
	killicon.Add("#"..LangName,"HUD/killicons/default",Color(255,80,0,255))
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if !SERVER then return end

ENT.Model = "models/spitball_medium.mdl" -- Model(s) to spawn with | Picks a random one if it's a table
ENT.ProjectileType = VJ.PROJ_TYPE_GRAVITY
ENT.DoesRadiusDamage = true -- Should it deal radius damage when it collides with something?
ENT.RadiusDamageRadius = 200
ENT.RadiusDamage = 30
ENT.RadiusDamageUseRealisticRadius = true -- Should the damage decrease the farther away the hit entity is from the radius origin?
ENT.RadiusDamageType = DMG_POISON
ENT.SoundTbl_Idle = "vj_base/ambience/acid_idle.wav"
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Init()
	self:SetNoDraw(true)
	ParticleEffectAttach("antlion_spit_trail", PATTACH_ABSORIGIN_FOLLOW, self, 0)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnThink()
	ParticleEffectAttach("antlion_gib_02_gas", PATTACH_ABSORIGIN_FOLLOW, self, 0)
end
---------------------------------------------------------------------------------------------------------------------------------------------
local defAng = Angle(0, 0, 0)
--
function ENT:OnDestroy(data, phys)
	ParticleEffect("antlion_gib_02_gas", data.HitPos, defAng)
	ParticleEffect("antlion_gib_02_gas", data.HitPos, defAng)
	ParticleEffect("antlion_gib_02_gas", data.HitPos, defAng)
end