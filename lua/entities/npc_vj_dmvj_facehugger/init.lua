AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/VJ_DARKMESSIAH/facehugger.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 100
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_DARK_MESSIAH"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.BloodPoolSize = "Small" -- What's the size of the blood pool?

ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.MeleeAttackDistance = 20 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 70 -- How far does the damage go?

ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
//ENT.HasDeathAnimation = false -- Does it play an animation when it dies?
//ENT.AnimTbl_Death = {"die_1"} -- Death Animations
	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.AnimTbl_Flinch = {ACT_BIG_FLINCH} -- If it uses normal based animation, use this
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_Idle = {"vj_dm_facehugger/facehugger_misc0.wav","vj_dm_facehugger/facehugger_misc1.wav","vj_dm_facehugger/facehugger_misc2.wav"}
ENT.SoundTbl_Alert = {"vj_dm_facehugger/facehugger_threat0.wav","vj_dm_facehugger/facehugger_threat1.wav","vj_dm_facehugger/facehugger_threat2.wav"}
ENT.SoundTbl_MeleeAttack = {"vj_dm_facehugger/facehugger_striking0.wav","vj_dm_facehugger/facehugger_striking1.wav","vj_dm_facehugger/facehugger_striking2.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"npc/zombie/claw_miss1.wav","npc/zombie/claw_miss2.wav"}
ENT.SoundTbl_Pain = {"vj_dm_facehugger/facehugger_ouch0.wav","vj_dm_facehugger/facehugger_ouch1.wav","vj_dm_facehugger/facehugger_ouch2.wav","vj_dm_facehugger/facehugger_hail0.wav","vj_dm_facehugger/facehugger_hail1.wav","vj_dm_facehugger/facehugger_hail2.wav"}
ENT.SoundTbl_Death = {"vj_dm_facehugger/facehugger_dying0.wav","vj_dm_facehugger/facehugger_dying1.wav","vj_dm_facehugger/facehugger_dying2.wav"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(13, 13, 60), Vector(-13, -13, 0))
	self:CapabilitiesAdd(bit.bor(CAP_MOVE_JUMP))
	self:CapabilitiesAdd(bit.bor(CAP_MOVE_CLIMB))
	self.AnimTbl_IdleStand = {self, VJ_SequenceToActivity(self, "search_1")}
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GetSightDirection()
	return self:GetAttachment(self:LookupAttachment("eyes")).Ang:Forward()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	local randAttack = math.random(1, 4)
	if randAttack == 1 then
		self.AnimTbl_MeleeAttack = {"vjseq_attack_side_right"}
		self.TimeUntilMeleeAttackDamage = 0.97
		self.MeleeAttackAnimationDecreaseLengthAmount = 0.8
		self.MeleeAttackDamage = 25
	elseif randAttack == 2 then
		self.AnimTbl_MeleeAttack = {"vjseq_attack_side_left"}
		self.TimeUntilMeleeAttackDamage = 0.85
		self.MeleeAttackAnimationDecreaseLengthAmount = 0.2
		self.MeleeAttackDamage = 25
	elseif randAttack == 3 then
		self.AnimTbl_MeleeAttack = {"vjseq_attack_forward_1"}
		self.TimeUntilMeleeAttackDamage = 0.85
		self.MeleeAttackAnimationDecreaseLengthAmount = 0
		self.MeleeAttackDamage = 30
	elseif randAttack == 4 then
		self.AnimTbl_MeleeAttack = {"vjseq_attack_forward_4"}
		self.TimeUntilMeleeAttackDamage = 1.15
		self.MeleeAttackAnimationDecreaseLengthAmount = 0
		self.MeleeAttackDamage = 38
	end
end