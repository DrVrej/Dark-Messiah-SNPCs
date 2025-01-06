AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2025 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/VJ_DARKMESSIAH/giantworm.mdl" -- Model(s) to spawn with | Picks a random one if it's a table
ENT.StartHealth = 8000
ENT.HullType = HULL_LARGE
ENT.VJ_ID_Boss = true
ENT.MovementType = VJ_MOVETYPE_STATIONARY -- How the NPC moves around
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_DARK_MESSIAH"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = VJ.BLOOD_COLOR_RED -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasBloodPool = false -- Does it have a blood pool?
ENT.Immune_AcidPoisonRadiation = true -- Makes the SNPC not get damage from Acid, poison, radiation

ENT.HasMeleeAttack = true -- Can this NPC melee attack?
ENT.AnimTbl_MeleeAttack = ACT_RELOAD
ENT.MeleeAttackDistance = 950 -- How close an enemy has to be to trigger a melee attack | false = Let the base auto calculate on initialize based on the NPC's collision bounds
ENT.MeleeAttackDamageDistance = 1100 -- How far does the damage go | false = Let the base auto calculate on initialize based on the NPC's collision bounds
ENT.TimeUntilMeleeAttackDamage = 2.1 -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDamage = 90
ENT.HasMeleeAttackKnockBack = true -- If true, it will cause a knockback to its enemy

ENT.HasRangeAttack = true -- Can this NPC range attack?
ENT.AnimTbl_RangeAttack = ACT_COWER
ENT.RangeAttackEntityToSpawn = "obj_vj_dm_gas" -- The entity that is spawned when range attacking
ENT.RangeDistance = 10000 -- How far can it range attack?
ENT.RangeToMeleeDistance = 1000 -- How close does it have to be until it uses melee?
ENT.NextRangeAttackTime = 0 -- How much time until it can use a range attack?
ENT.TimeUntilRangeAttackProjectileRelease = 1.8 -- How much time until the projectile code is ran?

ENT.HasDeathCorpse = false -- Should a corpse spawn when it's killed?
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.AnimTbl_Death = "worm_die"
ENT.DeathAnimationTime = false -- How long should the death animation play?
ENT.HasSoundTrack = true -- Does the NPC have a sound track?
	-- ====== Flinching Code ====== --
ENT.CanFlinch = 2 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchChance = 7 -- Chance of it flinching from 1 to x | 1 will make it always flinch
ENT.AnimTbl_Flinch = {"worm_hit_back", "worm_hit_front"} -- The regular flinch animations to play
	-- ====== Sound Paths ====== --
ENT.SoundTbl_Breath = {"vj_darkmessiah/giantworm/worm_idleloop.wav"}
ENT.SoundTbl_Idle = {"vj_darkmessiah/giantworm/worm_strafe0.wav","vj_darkmessiah/giantworm/worm_strafe1.wav","vj_darkmessiah/giantworm/worm_strafe2.wav","vj_darkmessiah/giantworm/worm_strafe3.wav","vj_darkmessiah/giantworm/worm_idle0.wav","vj_darkmessiah/giantworm/worm_idle1.wav","vj_darkmessiah/giantworm/worm_idle2.wav","vj_darkmessiah/giantworm/worm_idlegrowl0.wav","vj_darkmessiah/giantworm/worm_idlegrowl1.wav"}
ENT.SoundTbl_Alert = {"vj_darkmessiah/giantworm/worm_in_quick.wav","vj_darkmessiah/giantworm/worm_idlegrowl2.wav","vj_darkmessiah/giantworm/worm_idlegrowl3.wav"}
ENT.SoundTbl_MeleeAttack = {"vj_darkmessiah/giantworm/worm_striking0.wav","vj_darkmessiah/giantworm/worm_striking1.wav","vj_darkmessiah/giantworm/worm_striking2.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_darkmessiah/giantworm/worm_whoosh0.wav","vj_darkmessiah/giantworm/worm_whoosh1.wav","vj_darkmessiah/giantworm/worm_whoosh2.wav"}
ENT.SoundTbl_RangeAttack = {"vj_darkmessiah/giantworm/worm_strikingpoison0.wav","vj_darkmessiah/giantworm/worm_strikingpoison1.wav","vj_darkmessiah/giantworm/worm_strikingpoison2.wav"}
ENT.SoundTbl_Pain = {"vj_darkmessiah/giantworm/worm_ouch0.wav","vj_darkmessiah/giantworm/worm_ouch1.wav","vj_darkmessiah/giantworm/worm_ouch2.wav","vj_darkmessiah/giantworm/worm_ouch3.wav"}
ENT.SoundTbl_Death = {"vj_darkmessiah/giantworm/worm_dying.wav"}
ENT.SoundTbl_SoundTrack = {"vj_darkmessiah/giantworm/Dark Messiah - The Worm From The Deep.mp3"}

ENT.AlertSoundLevel = 100
ENT.IdleSoundLevel = 100
ENT.MeleeAttackSoundLevel = 100
ENT.ExtraMeleeAttackSoundLevel = 100
ENT.MeleeAttackMissSoundLevel = 100
ENT.PainSoundLevel = 100
ENT.DeathSoundLevel = 100
ENT.RangeAttackSoundLevel = 100

-- Custom
ENT.Worm_IdleAngryAnim = ACT_IDLE
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Init()
	self:SetPhysicsDamageScale(0)
	self:SetCollisionBounds(Vector(185, 185, 1900), Vector(-185, -185, 0))
	self:SetSurroundingBounds(Vector(600, 600, 2200), Vector(-600, -600, 0))
	self.Worm_IdleAngryAnim = self:GetSequenceActivity(self:LookupSequence("combatidle"))
	self.Worm_CreateMouthEffect = GetConVar("vj_npc_noidleparticle"):GetInt() == 0
	PrintMessage(HUD_PRINTCENTER, "A Giant Worm Has Been Summoned!")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:TranslateActivity(act)
	if act == ACT_IDLE && IsValid(self:GetEnemy()) then
		return self.Worm_IdleAngryAnim
	end
	return self.BaseClass.TranslateActivity(self, act)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnThink()
	if self.Worm_CreateMouthEffect then
		ParticleEffectAttach("vj_acid_impact3_gas", PATTACH_POINT_FOLLOW, self, 2)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local alertAnims = {"vjseq_worm_taunt_01", "vjseq_worm_taunt_02", "vjseq_worm_grunt"}
--
function ENT:OnAlert(ent)
	if self.VJ_IsBeingControlled then return end
	self:PlayAnim(alertAnims, true, false, true)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MeleeAttackKnockbackVelocity(hitEnt)
	return self:GetForward() * math.random(700, 730) + self:GetUp() * math.random(500, 530)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_Miss()
	util.ScreenShake(self:GetPos(), 16, 100, 1, 2500)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackProjSpawnPos(projectile)
	return self:GetAttachment(self:LookupAttachment("poison")).Pos
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackProjVelocity(projectile)
	return VJ.CalculateTrajectory(self, self:GetEnemy(), "Curve", projectile:GetPos(), 1, 10)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnDeath(dmginfo, hitgroup, status)
	if status == "Initial" then
		PrintMessage(HUD_PRINTCENTER, "A Giant Worm Has Been Defeated!")
	elseif status == "DeathAnim" then
		util.ScreenShake(self:GetPos(), 100, 200, 5.5, 3000)
		timer.Simple(2.5, function()
			if IsValid(self) then
				local effectDust = EffectData()
				effectDust:SetOrigin(self:GetPos())
				util.Effect("VJ_Medium_Dust1", effectDust)
				if self.HasSounds == true && self.HasDeathSounds == true then VJ.EmitSound(self, "vj_darkmessiah/building_rubble5.wav", 100) end
			end
		end)
	end
end