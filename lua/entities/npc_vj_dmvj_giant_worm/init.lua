AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/VJ_DARKMESSIAH/giantworm.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 8000
ENT.HullType = HULL_LARGE
ENT.VJ_IsHugeMonster = true -- Is this a huge monster?
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_DARK_MESSIAH"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasBloodPool = false -- Does it have a blood pool?
ENT.Immune_AcidPoisonRadiation = true -- Makes the SNPC not get damage from Acid, poison, radiation
ENT.Immune_Physics = true -- If set to true, the SNPC won't take damage from props

ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_RELOAD} -- Melee Attack Animations
ENT.MeleeAttackDistance = 800 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 1100 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 2.1 -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDamage = 90
ENT.HasMeleeAttackKnockBack = true -- If true, it will cause a knockback to its enemy
ENT.MeleeAttackKnockBack_Forward1 = 700 -- How far it will push you forward | First in math.random
ENT.MeleeAttackKnockBack_Forward2 = 730 -- How far it will push you forward | Second in math.random
ENT.MeleeAttackKnockBack_Up1 = 500 -- How far it will push you up | First in math.random
ENT.MeleeAttackKnockBack_Up2 = 530 -- How far it will push you up | Second in math.random
ENT.MeleeAttackWorldShakeOnMiss = true -- Should it shake the world when it misses during melee attack?

ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.AnimTbl_RangeAttack = {ACT_COWER} -- Range Attack Animations
ENT.RangeAttackEntityToSpawn = "obj_dm_toxicgas" -- The entity that is spawned when range attacking
ENT.RangeDistance = 10000 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 1000 -- How close does it have to be until it uses melee?
ENT.RangeUseAttachmentForPos = true -- Should the projectile spawn on a attachment?
ENT.RangeUseAttachmentForPosID = "poison" -- The attachment used on the range attack if RangeUseAttachmentForPos is set to true
ENT.NextRangeAttackTime = 0 -- How much time until it can use a range attack?
ENT.TimeUntilRangeAttackProjectileRelease = 1.8 -- How much time until the projectile code is ran?

ENT.HasDeathRagdoll = false -- If set to false, it will not spawn the regular ragdoll of the SNPC
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.AnimTbl_Death = {"worm_die"} -- Death Animations
ENT.DeathAnimationTime = false -- Time until the SNPC spawns its corpse and gets removed
ENT.HasSoundTrack = true -- Does the SNPC have a sound track?
	-- ====== Flinching Code ====== --
ENT.CanFlinch = 2 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchChance = 7 -- Chance of it flinching from 1 to x | 1 will make it always flinch
ENT.AnimTbl_Flinch = {"worm_hit_back", "worm_hit_front"} -- If it uses normal based animation, use this
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_Breath = {"vj_dm_giantworm/worm_idleloop.wav"}
ENT.SoundTbl_Idle = {"vj_dm_giantworm/worm_strafe0.wav","vj_dm_giantworm/worm_strafe1.wav","vj_dm_giantworm/worm_strafe2.wav","vj_dm_giantworm/worm_strafe3.wav","vj_dm_giantworm/worm_idle0.wav","vj_dm_giantworm/worm_idle1.wav","vj_dm_giantworm/worm_idle2.wav","vj_dm_giantworm/worm_idlegrowl0.wav","vj_dm_giantworm/worm_idlegrowl1.wav"}
ENT.SoundTbl_Alert = {"vj_dm_giantworm/worm_in_quick.wav","vj_dm_giantworm/worm_idlegrowl2.wav","vj_dm_giantworm/worm_idlegrowl3.wav"}
ENT.SoundTbl_MeleeAttack = {"vj_dm_giantworm/worm_striking0.wav","vj_dm_giantworm/worm_striking1.wav","vj_dm_giantworm/worm_striking2.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_dm_giantworm/worm_whoosh0.wav","vj_dm_giantworm/worm_whoosh1.wav","vj_dm_giantworm/worm_whoosh2.wav"}
ENT.SoundTbl_RangeAttack = {"vj_dm_giantworm/worm_strikingpoison0.wav","vj_dm_giantworm/worm_strikingpoison1.wav","vj_dm_giantworm/worm_strikingpoison2.wav"}
ENT.SoundTbl_Pain = {"vj_dm_giantworm/worm_ouch0.wav","vj_dm_giantworm/worm_ouch1.wav","vj_dm_giantworm/worm_ouch2.wav","vj_dm_giantworm/worm_ouch3.wav"}
ENT.SoundTbl_Death = {"vj_dm_giantworm/worm_dying.wav"}
ENT.SoundTbl_SoundTrack = {"vj_dm_giantworm/Dark Messiah - The Worm From The Deep.mp3"}

ENT.AlertSoundLevel = 100
ENT.IdleSoundLevel = 100
ENT.MeleeAttackSoundLevel = 100
ENT.ExtraMeleeAttackSoundLevel = 100
ENT.MeleeAttackMissSoundLevel = 100
ENT.PainSoundLevel = 100
ENT.DeathSoundLevel = 100
ENT.RangeAttackSoundLevel = 100

-- Custom
ENT.Worm_IdleSwitched = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(185, 185, 2000), Vector(-185, -185, 0))
	PrintMessage(HUD_PRINTCENTER, "A Giant Worm Has Been Summoned!")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GetSightDirection()
	return self:GetAttachment(self:LookupAttachment("eyes")).Ang:Forward()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	if GetConVar("vj_npc_noidleparticle"):GetInt() == 0 then
		ParticleEffectAttach("antlion_gib_02_gas", PATTACH_POINT_FOLLOW, self, 2)
	end
	
	if IsValid(self:GetEnemy()) then
		if !self.Worm_IdleSwitched then
			self.Worm_IdleSwitched = true
			self.AnimTbl_IdleStand = {self:GetSequenceActivity(self:LookupSequence("combatidle"))}
		end
	elseif self.Worm_IdleSwitched then
		self.Worm_IdleSwitched = false
		self.AnimTbl_IdleStand = {ACT_IDLE}
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local alertAnims = {"vjseq_worm_taunt_01", "vjseq_worm_taunt_02", "vjseq_worm_grunt"}
--
function ENT:CustomOnAlert()
	if self.VJ_IsBeingControlled == true then return end
	self:VJ_ACT_PLAYACTIVITY(VJ_PICK(alertAnims), true, false, true)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackCode_GetShootPos(TheProjectile)
	return (self:GetEnemy():GetPos() - self:GetAttachment(self:LookupAttachment("poison")).Pos) + self:GetUp()*350
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPriorToKilled(dmginfo, hitgroup)
	PrintMessage(HUD_PRINTCENTER, "A Giant Worm Has Been Defeated!")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomDeathAnimationCode(dmginfo, hitgroup)
	util.ScreenShake(self:GetPos(), 100, 200, 5.5, 3000)
	timer.Simple(2.5, function()
		if IsValid(self) then
			local effectDust = EffectData()
			effectDust:SetOrigin(self:GetPos())
			util.Effect("VJ_Medium_Dust1", effectDust)
			if self.HasSounds == true && self.HasDeathSounds == true then VJ_EmitSound(self, "building_rubble5.wav", 100) end
		end
	end)
end