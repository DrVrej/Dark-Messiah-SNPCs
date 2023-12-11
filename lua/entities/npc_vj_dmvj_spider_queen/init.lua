AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/VJ_DARKMESSIAH/spider_queen.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 10000
ENT.HullType = HULL_LARGE
ENT.VJ_IsHugeMonster = true -- Is this a huge monster?
ENT.EntitiesToNoCollide = {"npc_vj_dmvj_spider"}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_DARK_MESSIAH"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.Immune_AcidPoisonRadiation = true -- Makes the SNPC not get damage from Acid, poison, radiation
ENT.Immune_Physics = true -- If set to true, the SNPC won't take damage from props

ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.MeleeAttackAnimationFaceEnemy = false -- Should it face the enemy while playing the melee attack animation?
ENT.MeleeAttackDistance = 85 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 360 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.HasMeleeAttackKnockBack = true -- If true, it will cause a knockback to its enemy
ENT.MeleeAttackKnockBack_Forward1 = 700 -- How far it will push you forward | First in math.random
ENT.MeleeAttackKnockBack_Forward2 = 730 -- How far it will push you forward | Second in math.random
ENT.MeleeAttackKnockBack_Up1 = 500 -- How far it will push you up | First in math.random
ENT.MeleeAttackKnockBack_Up2 = 530 -- How far it will push you up | Second in math.random

ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.AnimTbl_RangeAttack = {"vjseq_attack_poison"} -- Range Attack Animations
ENT.RangeAttackEntityToSpawn = "obj_dm_toxicgas" -- The entity that is spawned when range attacking
ENT.RangeDistance = 9000 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 800 -- How close does it have to be until it uses melee?
ENT.TimeUntilRangeAttackProjectileRelease = false -- How much time until the projectile code is ran?
ENT.NextRangeAttackTime = 4 -- How much time until it can use a range attack?

ENT.CanFlinch = 2 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchChance = 7 -- Chance of it flinching from 1 to x | 1 will make it always flinch
ENT.AnimTbl_Flinch = {ACT_BIG_FLINCH} -- If it uses normal based animation, use this

ENT.HasSoundTrack = true -- Does the SNPC have a sound track?
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.AnimTbl_Death = {"vjseq_die_1", "vjseq_die_impaled"} -- Death Animations
ENT.DisableFootStepSoundTimer = true -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events
ENT.HasWorldShakeOnMove = true -- Should the world shake when it's moving?
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"vj_dm_spidermonster/hit1.wav","vj_dm_spidermonster/hit2.wav","vj_dm_spidermonster/hit3.wav"}
ENT.SoundTbl_Idle = {"vj_dm_spidermonster/spidermonster_misc0.wav","vj_dm_spidermonster/spidermonster_misc1.wav","vj_dm_spidermonster/spidermonster_misc2.wav"}
ENT.SoundTbl_Alert = {"vj_dm_spidermonster/spidermonster_entrance_end.wav","vj_dm_spidermonster/spidermonster_threat0.wav","vj_dm_spidermonster/spidermonster_threat1.wav","vj_dm_spidermonster/spidermonster_threat2.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_dm_spidermonster/spidermonster_foothit0.wav","vj_dm_spidermonster/spidermonster_foothit1.wav","vj_dm_spidermonster/spidermonster_foothit2.wav","vj_dm_spidermonster/spidermonster_foothit3.wav"}
ENT.SoundTbl_RangeAttack = {"vj_dm_spidermonster/spidermonster_hail0.wav","vj_dm_spidermonster/spidermonster_hail1.wav","vj_dm_spidermonster/spidermonster_hail2.wav"}
ENT.SoundTbl_Pain = {"vj_dm_spidermonster/spidermonster_ouch_strong0.wav","vj_dm_spidermonster/spidermonster_ouch_strong1.wav","vj_dm_spidermonster/spidermonster_ouch_strong2.wav","vj_dm_spidermonster/spidermonster_ouch0.wav","vj_dm_spidermonster/spidermonster_ouch1.wav","vj_dm_spidermonster/spidermonster_ouch2.wav"}
ENT.SoundTbl_Death = {"vj_dm_spidermonster/spidermonster_dying0.wav","vj_dm_spidermonster/spidermonster_dying1.wav","vj_dm_spidermonster/spidermonster_dying2.wav"}
ENT.SoundTbl_SoundTrack = {"vj_dm_spidermonster/Dark Messiah - Avatar of the Spider Goddess.wav"}

local sdOnMelee = {"vj_dm_spidermonster/spidermonster_striking0.wav","vj_dm_spidermonster/spidermonster_striking1.wav","vj_dm_spidermonster/spidermonster_striking2.wav"}
local sdOnMeleeWind = {"vj_dm_spidermonster/spidermonster_whoosh0.wav","vj_dm_spidermonster/spidermonster_whoosh1.wav","vj_dm_spidermonster/spidermonster_whoosh2.wav","vj_dm_spidermonster/spidermonster_whoosh3.wav","vj_dm_spidermonster/spidermonster_whoosh4.wav"}
local sdMeleeMissGround = {"vj_dm_spidermonster/spidermonster_foothit0.wav","vj_dm_spidermonster/spidermonster_foothit1.wav","vj_dm_spidermonster/spidermonster_foothit2.wav","vj_dm_spidermonster/spidermonster_foothit3.wav"}

ENT.FootStepSoundLevel = 100
ENT.AlertSoundLevel = 100
ENT.IdleSoundLevel = 100
ENT.MeleeAttackSoundLevel = 100
ENT.RangeAttackSoundLevel = 100
ENT.MeleeAttackMissSoundLevel = 150
ENT.BeforeLeapAttackSoundLevel = 100
ENT.PainSoundLevel = 100
ENT.DeathSoundLevel = 100

-- Custom
ENT.SpiderQ_PoisonAttack = false
ENT.SpiderQ_AllowSpawning = true
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	//self:SetCollisionBounds(Vector(100, 130, 210), Vector(-100, -130, 0))
	self:SetCollisionBounds(Vector(190, 190, 210), -Vector(190, 190, 0))
	PrintMessage(HUD_PRINTCENTER, "A Spider Queen Has Been Summoned!")
	if GetConVar("vj_dm_nobabyspawn"):GetInt() == 0 then self.SpiderQ_AllowSpawning = false end
	self.SpiderQ_NextBirthT = 0
	self.SpiderQ_NextBirthTime = GetConVar("vj_dm_nextbaby"):GetInt()
	self.SpiderQ_SpiderLimit = VJ_RoundToMultiple(GetConVar("vj_dm_babyspawnlimit"):GetInt(), 3)
	self.SpiderQ_BabySpidersTbl = {}
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_IntMsg(ply)
	ply:ChatPrint("JUMP: Spawn Baby Spiders")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	//print(key)
	if key == "event_emit Foot" then
		self:FootStepSoundCode()
	elseif key == "event_mattack lefta" or key == "event_mattack leftb" or key == "event_mattack righta" or key == "event_mattack rightb" or key == "event_mattack leftc" or key == "event_mattack rightc" or key == "event_mattack belly"	then
		self:MeleeAttackCode()
	elseif key == "event_rattack poisonstart" then
		self:RangeAttackCode()
	elseif key == "event_play Striking" then
		self:PlaySoundSystem("BeforeMeleeAttack", sdOnMelee)
	elseif key == "event_emit Whoosh" then
		self:PlaySoundSystem("MeleeAttackMiss", sdOnMeleeWind, VJ_EmitSound)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GetSightDirection()
	return self:GetAttachment(self:LookupAttachment("eyes")).Ang:Forward()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()
	if self.SpiderQ_AllowSpawning && IsValid(self:GetEnemy()) && CurTime() > self.SpiderQ_NextBirthT && ((self.VJ_IsBeingControlled == false) or (self.VJ_IsBeingControlled == true && self.VJ_TheController:KeyDown(IN_JUMP))) then
		local babyTbl = self.SpiderQ_BabySpidersTbl
		for k, v in pairs(babyTbl) do
			if !IsValid(v) then table.remove(babyTbl, k) continue end
		end
		babyTbl = self.SpiderQ_BabySpidersTbl
		if (#babyTbl % 3 == 0) && #babyTbl < self.SpiderQ_SpiderLimit then
			if self.VJ_IsBeingControlled == true then
				self.VJ_TheController:PrintMessage(HUD_PRINTCENTER,"Spawning Spiders! Cooldown: "..self.SpiderQ_NextBirthTime.." seconds!")
			end
			util.ScreenShake(self:GetPos(), 100, 200, 5, 3000)
			VJ_EmitSound(self, {"vj_dm_spider/spider_victory0.wav","vj_dm_spider/spider_victory1.wav"}, 100, math.random(80, 100))
			
			local effectDust = EffectData()
			effectDust:SetOrigin(self:GetPos())
			effectDust:SetScale(1000)
			util.Effect("ThumperDust", effectDust)
			
			for i = 1, 3 do
				local baby = ents.Create("npc_vj_dmvj_spider")
				baby:SetPos(self:GetPos() + self:GetRight()*(i == 3 and -120 or (i == 2 and 120 or 1)))
				baby:SetAngles(self:GetAngles())
				baby.Spider_AlwaysPlayDigOutAnim = true
				baby:Spawn()
				baby:Activate()
				baby:SetOwner(self)
				self.SpiderQ_BabySpidersTbl[#self.SpiderQ_BabySpidersTbl + 1] = baby
			end
			self.SpiderQ_NextBirthT = CurTime() + self.SpiderQ_NextBirthTime
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert()
	if self.VJ_IsBeingControlled then return end
	self:VJ_ACT_PLAYACTIVITY(ACT_IDLE_ANGRY, true, false, true)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	if math.random(1, 6) == 1 then
		self.AnimTbl_MeleeAttack = {"vjseq_Attack_belly"}
		self.MeleeAttackDamage = 96
		self.MeleeAttackDamageType = DMG_POISON
		self.SoundTbl_MeleeAttackMiss = sdOnMeleeWind
		self.SpiderQ_PoisonAttack = true
	else
		self.AnimTbl_MeleeAttack = {"vjseq_Attack_1", "vjseq_Attack_2", "vjseq_Attack_3", "vjseq_Attack_4", "vjseq_Attack_dual"}
		self.MeleeAttackDamage = 85
		self.MeleeAttackDamageType = DMG_SLASH
		self.SoundTbl_MeleeAttackMiss = sdMeleeMissGround
		self.SpiderQ_PoisonAttack = false
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_Miss()
	if self:IsOnGround() && !self.SpiderQ_PoisonAttack then
		util.ScreenShake(self:GetPos(), 16, 100, 1, 2000)
		for _ = 1, 3 do
			local effectDust = EffectData()
			effectDust:SetOrigin(self:GetPos() + self:GetForward()*200)
			effectDust:SetScale(1000)
			util.Effect("ThumperDust",effectDust)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomRangeAttackCode_BeforeProjectileSpawn(projectile)
	projectile.RadiusDamageRadius = 100
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackCode_GetShootPos(TheProjectile)
	return (self:GetEnemy():GetPos()-self:LocalToWorld(Vector(0,0,math.random(20,20))))*2 + self:GetUp()*250 + self:GetForward()*900
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPriorToKilled(dmginfo, hitgroup)
	PrintMessage(HUD_PRINTCENTER, "A Spider Queen Has Been Defeated!")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomDeathAnimationCode(dmginfo, hitgroup)
	util.ScreenShake(self:GetPos(), 100, 200, 5, 3000)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	if !self.Dead then
		for _, v in pairs(self.SpiderQ_BabySpidersTbl) do
			if IsValid(v) then
				v:Remove()
			end
		end
	end
end