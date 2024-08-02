AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2024 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/VJ_DARKMESSIAH/facehugger.mdl" -- Model(s) to spawn with | Picks a random one if it's a table
ENT.StartHealth = 100
ENT.HullType = HULL_TINY
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_DARK_MESSIAH"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)

ENT.HasMeleeAttack = true -- Can this NPC melee attack?
ENT.MeleeAttackDistance = 35 -- How close an enemy has to be to trigger a melee attack | false = Let the base auto calculate on initialize based on the NPC's collision bounds
ENT.MeleeAttackDamageDistance = 70 -- How far does the damage go | false = Let the base auto calculate on initialize based on the NPC's collision bounds

ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.DeathAnimationChance = 5 -- Put 1 if you want it to play the animation all the time
ENT.AnimTbl_Death = "die_1" -- Death Animations
	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchChance = 8 -- Chance of it flinching from 1 to x | 1 will make it always flinch
ENT.AnimTbl_Flinch = {ACT_BIG_FLINCH, "hit_back_long", "hit_back_medium", "hit_left_long", "hit_left_medium", "hit_right_long", "hit_right_medium"} -- If it uses normal based animation, use this
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_Idle = {"vj_darkmessiah/facehugger/facehugger_misc0.wav","vj_darkmessiah/facehugger/facehugger_misc1.wav","vj_darkmessiah/facehugger/facehugger_misc2.wav"}
ENT.SoundTbl_Alert = {"vj_darkmessiah/facehugger/facehugger_threat0.wav","vj_darkmessiah/facehugger/facehugger_threat1.wav","vj_darkmessiah/facehugger/facehugger_threat2.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"vj_darkmessiah/facehugger/facehugger_striking0.wav","vj_darkmessiah/facehugger/facehugger_striking1.wav","vj_darkmessiah/facehugger/facehugger_striking2.wav"}
ENT.SoundTbl_Pain = {"vj_darkmessiah/facehugger/facehugger_ouch0.wav","vj_darkmessiah/facehugger/facehugger_ouch1.wav","vj_darkmessiah/facehugger/facehugger_ouch2.wav","vj_darkmessiah/facehugger/facehugger_hail0.wav","vj_darkmessiah/facehugger/facehugger_hail1.wav","vj_darkmessiah/facehugger/facehugger_hail2.wav"}
ENT.SoundTbl_Death = {"vj_darkmessiah/facehugger/facehugger_dying0.wav","vj_darkmessiah/facehugger/facehugger_dying1.wav","vj_darkmessiah/facehugger/facehugger_dying2.wav"}

-- Custom
ENT.FaceH_IdleAnims = {ACT_IDLE}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(13, 13, 40), Vector(-13, -13, 0))
	self:SetSurroundingBounds(Vector(50, 50, 100), Vector(-50, -50, 0))
	self:CapabilitiesAdd(bit.bor(CAP_MOVE_JUMP, CAP_MOVE_CLIMB))
	self:SetStepHeight(50)
	self.FaceH_IdleAnims = {ACT_IDLE, self:GetSequenceActivity(self:LookupSequence("search_1"))}
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:TranslateActivity(act)
	if act == ACT_IDLE or act == ACT_JUMP or act == ACT_GLIDE then
		return self:ResolveAnimation(self.FaceH_IdleAnims)
	elseif act == ACT_CLIMB_UP or act == ACT_CLIMB_DOWN then
		return ACT_RUN
	end
	return self.BaseClass.TranslateActivity(self, act)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GetSightDirection()
	return self:GetAttachment(self:LookupAttachment("eyes")).Ang:Forward()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	local randAttack = math.random(1, 4)
	if randAttack == 1 then
		self.AnimTbl_MeleeAttack = "vjseq_attack_side_right"
		self.TimeUntilMeleeAttackDamage = 0.85
		self.MeleeAttackAnimationDecreaseLengthAmount = 0.8
		self.MeleeAttackDamage = 25
	elseif randAttack == 2 then
		self.AnimTbl_MeleeAttack = "vjseq_attack_side_left"
		self.TimeUntilMeleeAttackDamage = 0.85
		self.MeleeAttackAnimationDecreaseLengthAmount = 0.2
		self.MeleeAttackDamage = 25
	elseif randAttack == 3 then
		self.AnimTbl_MeleeAttack = "vjseq_attack_forward_1"
		self.TimeUntilMeleeAttackDamage = 0.8
		self.MeleeAttackAnimationDecreaseLengthAmount = 0
		self.MeleeAttackDamage = 30
	elseif randAttack == 4 then
		self.AnimTbl_MeleeAttack = "vjseq_attack_forward_4"
		self.TimeUntilMeleeAttackDamage = 1
		self.MeleeAttackAnimationDecreaseLengthAmount = 0
		self.MeleeAttackDamage = 38
	end
end