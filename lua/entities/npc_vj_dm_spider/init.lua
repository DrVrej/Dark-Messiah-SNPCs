AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2024 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/VJ_DARKMESSIAH/spider_regular.mdl" -- Model(s) to spawn with | Picks a random one if it's a table
ENT.StartHealth = 200
ENT.HullType = HULL_TINY
ENT.EntitiesToNoCollide = {"npc_vj_dm_spider_queen"}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_DARK_MESSIAH"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.Immune_AcidPoisonRadiation = true -- Immune to Acid, Poison and Radiation

ENT.HasMeleeAttack = true -- Can this NPC melee attack?
ENT.MeleeAttackDamage = 25
ENT.AnimTbl_MeleeAttack = ACT_MELEE_ATTACK1
ENT.MeleeAttackDistance = 45 -- How close an enemy has to be to trigger a melee attack | false = Let the base auto calculate on initialize based on the NPC's collision bounds
ENT.MeleeAttackDamageDistance = 70 -- How far does the damage go | false = Let the base auto calculate on initialize based on the NPC's collision bounds
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something

ENT.HasRangeAttack = true -- Can this NPC range attack?
ENT.AnimTbl_RangeAttack = ACT_RANGE_ATTACK1
ENT.RangeAttackEntityToSpawn = "obj_vj_dm_gas" -- The entity that is spawned when range attacking
ENT.RangeDistance = 800 -- How far can it range attack?
ENT.RangeToMeleeDistance = 300 -- How close does it have to be until it uses melee?
ENT.TimeUntilRangeAttackProjectileRelease = false -- How much time until the projectile code is ran?
ENT.NextRangeAttackTime = 4 -- How much time until it can use a range attack?

ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.AnimTbl_Death = ACT_DIESIMPLE
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchChance = 8 -- Chance of it flinching from 1 to x | 1 will make it always flinch
ENT.AnimTbl_Flinch = ACT_BIG_FLINCH -- The regular flinch animations to play
ENT.HitGroupFlinching_Values = {
	{HitGroup={103}, Animation={ACT_SMALL_FLINCH}},
	{HitGroup={106}, Animation={ACT_FLINCH_LEFTLEG}},
	{HitGroup={107}, Animation={ACT_FLINCH_RIGHTLEG}}
}
	-- ====== Sound Paths ====== --
ENT.SoundTbl_Idle = {"vj_darkmessiah/spider/spider_misc0.wav","vj_darkmessiah/spider/spider_misc2.wav","vj_darkmessiah/spider/spider_misc3.wav","vj_darkmessiah/spider/spider_hail0.wav","vj_darkmessiah/spider/spider_hail1.wav","vj_darkmessiah/spider/spider_hail2.wav"}
ENT.SoundTbl_Alert = {"vj_darkmessiah/spider/spider_misc1.wav","vj_darkmessiah/spider/spider_threat0.wav","vj_darkmessiah/spider/spider_threat1.wav","vj_darkmessiah/spider/spider_threat2.wav","vj_darkmessiah/spider/spider_guardmode0.wav","vj_darkmessiah/spider/spider_guardmode1.wav","vj_darkmessiah/spider/spider_guardmode2.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"npc/zombie/claw_miss1.wav","npc/zombie/claw_miss2.wav"}
ENT.SoundTbl_RangeAttack = {"vj_darkmessiah/spider/spider_threat3.wav","vj_darkmessiah/spider/spider_threat4.wav"}
ENT.SoundTbl_Pain = {"vj_darkmessiah/spider/spider_ouch_strong0.wav","vj_darkmessiah/spider/spider_ouch_strong1.wav","vj_darkmessiah/spider/spider_ouch_strong2.wav","vj_darkmessiah/spider/spider_ouch0.wav","vj_darkmessiah/spider/spider_ouch1.wav","vj_darkmessiah/spider/spider_ouch2.wav"}
ENT.SoundTbl_Death = {"vj_darkmessiah/spider/spider_dying0.wav","vj_darkmessiah/spider/spider_dying1.wav","vj_darkmessiah/spider/spider_dying2.wav"}

local sdStrike = {"vj_darkmessiah/spider/spider_striking0.wav","vj_darkmessiah/spider/spider_striking1.wav","vj_darkmessiah/spider/spider_striking2.wav","vj_darkmessiah/spider/spider_striking3.wav"}

-- Custom
ENT.Spider_AlwaysBurrow = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Init()
	self:SetCollisionBounds(Vector(25, 25, 25), Vector(-25, -25, 0))
	self:SetSurroundingBounds(Vector(70, 70, 80), Vector(-70, -70, 0))
	
	-- Burrow out animation
	if VJ_CVAR_AI_ENABLED && (math.random(1, 2) == 1 or self.Spider_AlwaysBurrow) then
		self:SetNoDraw(true)
		self:SetState(VJ_STATE_FREEZE)
		timer.Simple(0.05, function()
			if IsValid(self) then
				self:VJ_ACT_PLAYACTIVITY(ACT_ARM, true, false)
				timer.Simple(0.3, function()
					if IsValid(self) then
						self:SetNoDraw(false)
						self:SetState()
					end
				end)
			end
		end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInput(key, activator, caller, data) 
	//print(key)
	if key == "event_mattack a" or key == "event_mattack b" or key == "event_mattack c" or key == "event_mattack d" or key == "event_mattack e" then
		self:MeleeAttackCode()
	elseif key == "event_rattack web" then
		self:RangeAttackCode()
	elseif key == "event_play Striking" then
		self:PlaySoundSystem("BeforeMeleeAttack", sdStrike)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GetSightDirection()
	return self:GetAttachment(self:LookupAttachment("eyes")).Ang:Forward()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomRangeAttackCode_BeforeProjectileSpawn(projectile)
	-- Lower the damage and its radius for the regular spider
	projectile.RadiusDamageRadius = 100
	projectile.RadiusDamage = 20
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackProjSpawnPos(projectile)
	return self:GetAttachment(self:LookupAttachment("attack_head")).Pos
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackProjVelocity(projectile)
	return VJ.CalculateTrajectory(self, self:GetEnemy(), "Curve", projectile:GetPos(), 1, 1)
end