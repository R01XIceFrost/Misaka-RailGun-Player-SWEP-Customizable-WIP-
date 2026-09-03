AddCSLuaFile()

SWEP.Base = "weapon_base"
SWEP.PrintName = "Misaka RailGun"
SWEP.Author = "Dragonred (Main Programmer),|R-0-1-X|Ice Frost (Commissioner), KuroSun (Weapon Model Animation Gen 1), Westen (Backup Programmer #1), Mr.Sandbox (Backup Programmer #2)"
SWEP.Purpose = "Blast your enemies away!"
SWEP.Instructions = "Hold primary fire to charge. Release primary fire to discharge the stored energy as a rail beam."
SWEP.Category = "Other"

SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Slot = 0
SWEP.SlotPos = 2
SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.ViewModel = "models/weapons/c_coin.mdl"
SWEP.WorldModel = "models/weapons/w_coin.mdl"
SWEP.UseHands = true
SWEP.ViewModelFOV = 58
SWEP.HoldType = "pistol"

SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true

SWEP.Primary = SWEP.Primary or {}
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Primary.Coin = Sound("weapons/coin/tales_of_berseri_eizen_flip_coin.mp3")

SWEP.Secondary = SWEP.Secondary or {}
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

local CVAR_FLAGS = {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}

local FULL_CHARGE_SOUND_NET = "DMisakaRailGun_FullChargeSound"
local COIN_FLIP_SOUND_NET = "DMisakaRailGun_CoinFlipSound"

util.PrecacheSound("weapons/coin/tales_of_berseri_eizen_flip_coin.mp3")

if SERVER then
    util.AddNetworkString(FULL_CHARGE_SOUND_NET)
    util.AddNetworkString(COIN_FLIP_SOUND_NET)
else
    net.Receive(FULL_CHARGE_SOUND_NET, function()
        local owner = LocalPlayer()
        if not IsValid(owner) then return end

        -- Play this explicitly on the wielder's client. The authoritative SWEP
        -- sound is deliberately filtered away from the owner below so the
        -- full-charge cue cannot be lost to first-person weapon prediction or
        -- doubled when the server transmission also arrives.
        owner:EmitSound("items/battery_pickup.wav", 75, 125, 0.8, CHAN_AUTO)
    end)

    net.Receive(COIN_FLIP_SOUND_NET, function()
        local owner = LocalPlayer()
        if not IsValid(owner) then return end

        -- The original coin toss is an important first-person timing cue.
        -- Play an explicit client-local copy for the wielder so the server-side
        -- weapon sound cannot be swallowed by prediction/first-person audio.
        owner:EmitSound("weapons/coin/tales_of_berseri_eizen_flip_coin.mp3", 75, 100, 1, CHAN_AUTO)
    end)
end

local function EnsureConVar(name, default, help, minValue, maxValue)
    if ConVarExists(name) then return GetConVar(name) end
    return CreateConVar(name, default, CVAR_FLAGS, help, minValue, maxValue)
end

EnsureConVar("d_misakarailgun_timetofullycharge", "2", "[Misaka RailGun] Seconds required to fully charge.", 0.05, 60)
EnsureConVar("d_misakarailgun_maximumblastdurationinseconds", "3", "[Misaka RailGun] Maximum beam duration at full charge.", 0.05, 30)
EnsureConVar("d_misakarailgun_timeforbeamtofullyextend", "0.35", "[Misaka RailGun] Seconds required for the beam hitbox to reach maximum range.", 0.01, 10)
EnsureConVar("d_misakarailgun_maximumbeamdistance", "5000", "[Misaka RailGun] Maximum beam distance in Hammer units.", 0, 14500)
EnsureConVar("d_misakarailgun_beam_width_min", "10", "[Misaka RailGun] Minimum beam width.", 1, 200)
EnsureConVar("d_misakarailgun_beam_width_max", "40", "[Misaka RailGun] Maximum beam width.", 1, 200)
EnsureConVar("d_misakarailgun_damage_min", "20", "[Misaka RailGun] Damage per beam pulse at minimum charge.", 0, 10000)
EnsureConVar("d_misakarailgun_damage_max", "60", "[Misaka RailGun] Damage per beam pulse at full charge.", 0, 10000)
EnsureConVar("d_misakarailgun_damage_interval", "0.05", "[Misaka RailGun] Seconds between server-authoritative beam damage pulses.", 0.02, 1)
EnsureConVar("d_misakarailgun_recharge_cooldown", "0.85", "[Misaka RailGun] Delay after a beam ends before charging may begin again.", 0, 10)
EnsureConVar("d_misakarailgun_minimum_charge_to_fire", "10", "[Misaka RailGun] Minimum charge percentage required before release will fire.", 0, 100)
EnsureConVar("d_misakarailgun_impact_decal_interval", "0.08", "[Misaka RailGun] Minimum seconds between Dark burn decals while the beam contact point moves.", 0.03, 1)
EnsureConVar("d_misakarailgun_impact_decal_spacing", "2", "[Misaka RailGun] Minimum Hammer-unit movement before another Dark burn decal is placed. Set 0 to allow repeated stamps at the same point.", 0, 64)
EnsureConVar("d_misakarailgun_water_effects_enabled", "1", "[Misaka RailGun] Enables water-surface splash/ripple effects when the active beam crosses water.", 0, 1)
EnsureConVar("d_misakarailgun_water_effect_interval", "0.10", "[Misaka RailGun] Minimum seconds between water-surface effects while the beam remains in contact with water.", 0.03, 1)
EnsureConVar("d_misakarailgun_water_effect_scale_min", "1.5", "[Misaka RailGun] Water splash scale at minimum charge.", 0.1, 20)
EnsureConVar("d_misakarailgun_water_effect_scale_max", "4.0", "[Misaka RailGun] Water splash scale at full charge.", 0.1, 20)

EnsureConVar("d_misakarailgun_visuals_beam_texture", "", "[Misaka RailGun] Main beam texture. Empty uses the stock physbeam material.")
EnsureConVar("d_misakarailgun_visuals_beam_color_r", "255", "[Misaka RailGun] Beam red channel.", 0, 255)
EnsureConVar("d_misakarailgun_visuals_beam_color_g", "255", "[Misaka RailGun] Beam green channel.", 0, 255)
EnsureConVar("d_misakarailgun_visuals_beam_color_b", "255", "[Misaka RailGun] Beam blue channel.", 0, 255)
EnsureConVar("d_misakarailgun_visuals_ring_texture", "", "[Misaka RailGun] Ring texture. Empty uses the supplied default material.")
EnsureConVar("d_misakarailgun_visuals_ring_color_r", "0", "[Misaka RailGun] Ring red channel.", 0, 255)
EnsureConVar("d_misakarailgun_visuals_ring_color_g", "161", "[Misaka RailGun] Ring green channel.", 0, 255)
EnsureConVar("d_misakarailgun_visuals_ring_color_b", "255", "[Misaka RailGun] Ring blue channel.", 0, 255)
EnsureConVar("d_misakarailgun_visuals_thunderbeams_maxthickness", "15", "[Misaka RailGun] Maximum electrical arc thickness.", 1, 200)
EnsureConVar("d_misakarailgun_visuals_thunderbeams_timetoreachfullthickness", "0.015", "[Misaka RailGun] Electrical arc formation time.", 0.001, 10)
EnsureConVar("d_misakarailgun_visuals_thunderbeams_color_r", "255", "[Misaka RailGun] Electrical arc red channel.", 0, 255)
EnsureConVar("d_misakarailgun_visuals_thunderbeams_color_g", "255", "[Misaka RailGun] Electrical arc green channel.", 0, 255)
EnsureConVar("d_misakarailgun_visuals_thunderbeams_color_b", "255", "[Misaka RailGun] Electrical arc blue channel.", 0, 255)
EnsureConVar("d_misakarailgun_visuals_thunderbeams_fade_in_time", "0.1", "[Misaka RailGun] Electrical arc fade-in time.", 0.001, 20)
EnsureConVar("d_misakarailgun_visuals_thunderbeams_fade_out_time", "0.1", "[Misaka RailGun] Electrical arc fade-out time.", 0.001, 20)
EnsureConVar("d_misakarailgun_visuals_thunderbeams_texture", "", "[Misaka RailGun] Electrical arc texture. Empty uses the supplied default material.")

local function CVFloat(name, fallback)
    local cvar = GetConVar(name)
    if not cvar then return fallback end
    return cvar:GetFloat()
end

local function CVInt(name, fallback)
    local cvar = GetConVar(name)
    if not cvar then return fallback end
    return cvar:GetInt()
end

local function OrderedPair(a, b)
    if a <= b then return a, b end
    return b, a
end

local function ScaleRange(fraction, minimum, maximum)
    return minimum + (maximum - minimum) * math.Clamp(fraction, 0, 1)
end

function SWEP:SetupDataTables()
    self:NetworkVar("Float", 0, "RailGunCharge")
    self:NetworkVar("Float", 1, "BeamDistance")
    self:NetworkVar("Bool", 0, "EmittingBeam")
    self:NetworkVar("Bool", 1, "PendingDischarge")
end

function SWEP:Initialize()
    self:SetHoldType(self.HoldType)

    if SERVER then
        self:SetRailGunCharge(0)
        self:SetBeamDistance(0)
        self:SetEmittingBeam(false)
        self:SetPendingDischarge(false)
    end

    self._RailLastThink = CurTime()
    self._RailWasAttackDown = false
    self._RailNextChargeAllowed = 0
    self._RailNextDamage = 0
    self._RailBeamStartedAt = 0
    self._RailFullChargeNotified = false
    self._RailCharging = false
    self._RailChargeStartedAt = 0
    self._RailPendingBeamAt = 0
    self._RailLastImpactDecalPos = nil
    self._RailNextImpactDecal = 0
    self._RailNextWaterEffect = 0
    self._RailViewAnimSerial = 0
end

function SWEP:InvalidateViewModelAnimation()
    self._RailViewAnimSerial = (self._RailViewAnimSerial or 0) + 1
end

function SWEP:ScheduleViewModelIdle(delay, expectedOwner)
    if CLIENT then return end

    self._RailViewAnimSerial = (self._RailViewAnimSerial or 0) + 1
    local serial = self._RailViewAnimSerial
    local owner = expectedOwner or self:GetOwner()

    timer.Simple(math.max(delay or 0, 0), function()
        if not IsValid(self) or self._RailViewAnimSerial ~= serial then return end

        local currentOwner = self:GetOwner()
        if not IsValid(currentOwner) or currentOwner ~= owner then return end
        if currentOwner:GetActiveWeapon() ~= self then return end

        self:SendWeaponAnim(ACT_VM_IDLE)
    end)
end

function SWEP:Deploy()
    self:SetHoldType(self.HoldType)
    self:InvalidateViewModelAnimation()

    if SERVER then
        self:ResetRailGunState(false)
    end

    self:SendWeaponAnim(ACT_VM_DRAW)

    if SERVER then
        local duration = math.max(self:SequenceDuration() - 0.05, 0.05)
        self:ScheduleViewModelIdle(duration, self:GetOwner())
    end

    return true
end

function SWEP:PrimaryAttack()
    self:SetNextPrimaryFire(CurTime() + 0.1)

    if CLIENT then return end
    if self:GetEmittingBeam() or self:GetPendingDischarge() or self._RailCharging then return end
    if CurTime() < (self._RailNextChargeAllowed or 0) then return end

    local owner = self:GetOwner()
    if not IsValid(owner) or not owner:IsPlayer() or not owner:Alive() then return end

    self:StartCharging()
end

function SWEP:SecondaryAttack()
    self:SetNextSecondaryFire(CurTime() + 0.2)
end

function SWEP:Reload()
end

function SWEP:EnsureRailSounds()
    if CLIENT then return end

    if not self._RailChargeSound then
        self._RailChargeSound = CreateSound(self, "weapons/physcannon/hold_loop.wav")
    end

    if not self._RailBlastSound then
        self._RailBlastSound = CreateSound(self, "npc/stalker/laser_burn.wav")
    end
end

function SWEP:StopRailSounds(fadeBlast)
    if self._RailChargeSound then
        self._RailChargeSound:Stop()
    end

    if self._RailBlastSound then
        if fadeBlast then
            self._RailBlastSound:FadeOut(0.2)
        else
            self._RailBlastSound:Stop()
        end
    end
end

function SWEP:ResetRailGunState(applyCooldown)
    if SERVER then
        self:SetRailGunCharge(0)
        self:SetBeamDistance(0)
        self:SetEmittingBeam(false)
        self:SetPendingDischarge(false)
    end

    self._RailWasAttackDown = false
    self._RailCharging = false
    self._RailChargeStartedAt = 0
    self._RailPendingBeamAt = 0
    self._RailFullChargeNotified = false
    self._RailBeamStartedAt = 0
    self._RailNextDamage = 0
    self._RailLastImpactDecalPos = nil
    self._RailNextImpactDecal = 0
    self._RailNextWaterEffect = 0
    self._RailLastThink = CurTime()

    if applyCooldown then
        self._RailNextChargeAllowed = CurTime() + math.max(CVFloat("d_misakarailgun_recharge_cooldown", 0.85), 0)
    else
        self._RailNextChargeAllowed = CurTime()
    end

    self:StopRailSounds(false)
end

function SWEP:Holster()
    self:InvalidateViewModelAnimation()

    if SERVER then
        self:ResetRailGunState(false)
    else
        self:StopRailSounds(false)
    end

    return true
end

function SWEP:OnDrop()
    self:InvalidateViewModelAnimation()

    if SERVER then
        self:ResetRailGunState(false)
    else
        self:StopRailSounds(false)
    end
end

function SWEP:OnRemove()
    self:InvalidateViewModelAnimation()
    self:StopRailSounds(false)
end

function SWEP:GetChargeFraction()
    return math.Clamp(self:GetRailGunCharge() / 100, 0, 1)
end

function SWEP:GetCurrentBeamWidth()
    local minimum = CVFloat("d_misakarailgun_beam_width_min", 10)
    local maximum = CVFloat("d_misakarailgun_beam_width_max", 40)
    minimum, maximum = OrderedPair(minimum, maximum)
    return ScaleRange(self:GetChargeFraction(), minimum, maximum)
end

local function IsSaneBeamOrigin(owner, pos)
    if not IsValid(owner) or not isvector(pos) then return false end

    -- Bone matrices can briefly report an origin/default transform before they
    -- have been set up. Reject anything implausibly far from the shooter so a
    -- bad model state can never send the rail beam across the map.
    return pos:DistToSqr(owner:GetShootPos()) <= (256 * 256)
end

local function GetModelBoneOrigin(ent, owner, boneNames)
    if not IsValid(ent) then return nil end

    if ent.SetupBones then
        ent:SetupBones()
    end

    for _, boneName in ipairs(boneNames) do
        local bone = ent:LookupBone(boneName)
        if bone then
            local matrix = ent:GetBoneMatrix(bone)
            local pos = matrix and matrix:GetTranslation() or nil

            if not isvector(pos) then
                pos = select(1, ent:GetBonePosition(bone))
            end

            if IsSaneBeamOrigin(owner, pos) then
                return pos
            end
        end
    end

    return nil
end

function SWEP:GetBeamStartPos()
    local owner = self:GetOwner()
    if not IsValid(owner) then return nil end

    -- The original LEVEL5 models do not expose a muzzle attachment, but the
    -- first-person model has a dedicated `Coin` bone and the world model has
    -- the equivalent `coin` bone. Use those actual model transforms so the
    -- rail discharge visually originates from the coin itself.
    local coinPos

    if CLIENT and owner == LocalPlayer() and not owner:ShouldDrawLocalPlayer() then
        local vm = owner:GetViewModel()
        coinPos = GetModelBoneOrigin(vm, owner, {"Coin", "coin"})
    else
        -- In third person the weapon entity is rendering w_coin.mdl. On the
        -- server this is also the best model-space source when its bones are
        -- available.
        coinPos = GetModelBoneOrigin(self, owner, {"coin", "Coin"})

        -- Some server builds do not maintain weapon world-model bones while
        -- equipped. Try the owner's viewmodel before falling back to the hand.
        if not coinPos then
            local vm = owner:GetViewModel()
            coinPos = GetModelBoneOrigin(vm, owner, {"Coin", "coin"})
        end
    end

    if coinPos then
        return coinPos
    end

    local attachmentID = owner:LookupAttachment("anim_attachment_rh")
    if attachmentID and attachmentID > 0 then
        local attachment = owner:GetAttachment(attachmentID)
        if attachment and IsSaneBeamOrigin(owner, attachment.Pos) then
            return attachment.Pos
        end
    end

    return owner:GetShootPos()
end

function SWEP:GetRailTrace(distance)
    local owner = self:GetOwner()
    if not IsValid(owner) then return nil end

    local maxDistance = math.max(distance or self:GetBeamDistance(), 0)
    local aimStart = owner:GetShootPos()
    local aim = owner:GetAimVector()

    local aimTrace = util.TraceLine({
        start = aimStart,
        endpos = aimStart + aim * maxDistance,
        mask = MASK_SOLID_BRUSHONLY,
        filter = owner
    })

    local startPos = self:GetBeamStartPos() or aimStart
    local targetPos = aimTrace.HitPos
    local beamDir = targetPos - startPos

    if beamDir:LengthSqr() <= 0 then
        beamDir = aim
    else
        beamDir:Normalize()
    end

    local trace = util.TraceLine({
        start = startPos,
        endpos = startPos + beamDir * maxDistance,
        mask = MASK_SOLID_BRUSHONLY,
        filter = owner
    })

    trace.BeamStartPos = startPos
    trace.BeamDirection = beamDir
    trace.AimHitPos = targetPos

    return trace
end

function SWEP:StartCharging()
    if CLIENT or self._RailCharging or self:GetPendingDischarge() or self:GetEmittingBeam() then return end

    self:EnsureRailSounds()
    self._RailCharging = true
    self._RailChargeStartedAt = CurTime()
    self._RailFullChargeNotified = false
    self:SetRailGunCharge(0)

    if self._RailChargeSound then
        self._RailChargeSound:PlayEx(0.75, 100)
    end
end

function SWEP:GetDischargeAnimationDuration()
    local duration = self:SequenceDuration() or 0
    local owner = self:GetOwner()

    if IsValid(owner) then
        local vm = owner:GetViewModel()
        if IsValid(vm) then
            local vmDuration = vm:SequenceDuration() or 0
            if vmDuration > 0 then
                duration = vmDuration
            end
        end
    end

    -- The beam is intentionally delayed until the coin-flip/fire sequence has
    -- actually finished. This keeps the rail discharge synchronized to the model.
    return math.max(duration, 0.05)
end

function SWEP:ReleaseCharge()
    if CLIENT or not self._RailCharging or self:GetPendingDischarge() or self:GetEmittingBeam() then return end

    local charge = self:GetRailGunCharge()
    local minimumCharge = math.Clamp(CVFloat("d_misakarailgun_minimum_charge_to_fire", 10), 0, 100)

    self._RailCharging = false
    self._RailChargeStartedAt = 0

    if charge >= minimumCharge then
        self:BeginDischarge()
        return
    end

    self:SetRailGunCharge(0)
    self._RailFullChargeNotified = false
    self:StopRailSounds(false)
end

function SWEP:BeginDischarge()
    if CLIENT or self:GetPendingDischarge() or self:GetEmittingBeam() then return end

    local owner = self:GetOwner()
    if not IsValid(owner) then return end

    local minimumCharge = math.Clamp(CVFloat("d_misakarailgun_minimum_charge_to_fire", 10), 0, 100)
    if self:GetRailGunCharge() < minimumCharge then return end

    self:EnsureRailSounds()
    if self._RailChargeSound then self._RailChargeSound:Stop() end

    self._RailCharging = false
    self._RailChargeStartedAt = 0
    self:SetBeamDistance(0)
    self:SetPendingDischarge(true)
    self._RailFullChargeNotified = false

    self:InvalidateViewModelAnimation()
    self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    self._RailPendingBeamAt = CurTime() + self:GetDischargeAnimationDuration()

    -- Use the original Workshop coin sound at the start of the flip. Remote
    -- players receive the normal positional SWEP sound, while the wielder gets
    -- an explicit client-local copy so first-person prediction cannot swallow it.
    local recipients = RecipientFilter()
    recipients:AddAllPlayers()
    recipients:RemovePlayer(owner)
    self:EmitSound(self.Primary.Coin, 75, 100, 1, CHAN_AUTO, 0, 0, recipients)

    net.Start(COIN_FLIP_SOUND_NET)
    net.Send(owner)
end

function SWEP:StartBeam()
    if CLIENT or self:GetEmittingBeam() then return end

    local owner = self:GetOwner()
    if not IsValid(owner) then return end

    local minimumCharge = math.Clamp(CVFloat("d_misakarailgun_minimum_charge_to_fire", 10), 0, 100)
    if self:GetRailGunCharge() < minimumCharge then
        self:ResetRailGunState(false)
        return
    end

    self:EnsureRailSounds()
    if self._RailChargeSound then self._RailChargeSound:Stop() end

    self._RailCharging = false
    self._RailChargeStartedAt = 0
    self:SetPendingDischarge(false)
    self._RailPendingBeamAt = 0
    self:SetEmittingBeam(true)
    self:SetBeamDistance(0)
    self._RailBeamStartedAt = CurTime()
    self._RailNextDamage = CurTime()
    self._RailLastImpactDecalPos = nil
    self._RailNextImpactDecal = 0
    self._RailNextWaterEffect = 0
    self._RailFullChargeNotified = false

    -- The beam begins only after the coin-flip animation completes. Return the
    -- coin viewmodel to a stable idle pose at exactly that transition.
    self:SendWeaponAnim(ACT_VM_IDLE)
    owner:SetAnimation(PLAYER_ATTACK1)
    owner:EmitSound("npc/scanner/cbot_energyexplosion1.wav", 80, 120, 0.9, CHAN_AUTO)

    if self._RailBlastSound then
        self._RailBlastSound:PlayEx(0.75, 100)
    end
end

function SWEP:EndBeam()
    if CLIENT then return end

    self:SetEmittingBeam(false)
    self:SetPendingDischarge(false)
    self._RailCharging = false
    self._RailChargeStartedAt = 0
    self._RailPendingBeamAt = 0
    self:SetRailGunCharge(0)
    self:SetBeamDistance(0)
    self._RailBeamStartedAt = 0
    self._RailNextDamage = 0
    self._RailLastImpactDecalPos = nil
    self._RailNextImpactDecal = 0
    self._RailNextWaterEffect = 0
    self._RailFullChargeNotified = false
    self._RailNextChargeAllowed = CurTime() + math.max(CVFloat("d_misakarailgun_recharge_cooldown", 0.85), 0)

    if self._RailBlastSound then
        self._RailBlastSound:FadeOut(0.2)
    end

end

function SWEP:DoImpactDecal(trace)
    if CLIENT or not trace or not trace.Hit or trace.HitSky then return end

    local now = CurTime()
    if now < (self._RailNextImpactDecal or 0) then return end

    local hitPos = trace.HitPos
    local lastPos = self._RailLastImpactDecalPos
    local spacing = math.max(CVFloat("d_misakarailgun_impact_decal_spacing", 2), 0)

    -- The author's WIP repeatedly used the Source "Dark" decal at beam
    -- contact. Small changes in the impact point naturally layer those marks
    -- into the broad, irregular black burn shown in the reference video.
    -- Keep that look, but rate-limit it instead of stamping once per Think.
    if lastPos and spacing > 0 and lastPos:DistToSqr(hitPos) < (spacing * spacing) then return end

    local normal = trace.HitNormal
    if normal:LengthSqr() <= 0 then return end

    util.Decal("Dark", hitPos + normal, hitPos - normal)
    self._RailLastImpactDecalPos = Vector(hitPos.x, hitPos.y, hitPos.z)
    self._RailNextImpactDecal = now + math.max(CVFloat("d_misakarailgun_impact_decal_interval", 0.08), 0.03)
end

local WATER_TRACE_MASK = MASK_WATER or bit.bor(CONTENTS_WATER, CONTENTS_SLIME)

function SWEP:GetWaterContactTrace(beamTrace)
    if not beamTrace then return nil end

    local owner = self:GetOwner()
    if not IsValid(owner) then return nil end

    local startPos = beamTrace.BeamStartPos or self:GetBeamStartPos() or owner:GetShootPos()
    local endPos = beamTrace.HitPos
    if not endPos or startPos:DistToSqr(endPos) <= 1 then return nil end

    local waterTrace = util.TraceLine({
        start = startPos,
        endpos = endPos,
        mask = WATER_TRACE_MASK,
        filter = owner
    })

    -- From air, a MASK_WATER trace gives us the entry surface directly.
    if waterTrace.Hit and not waterTrace.StartSolid then
        return waterTrace
    end

    -- If the beam starts underwater and exits into air, trace backwards from
    -- the beam endpoint so we can still recover the surface-crossing point.
    if waterTrace.StartSolid then
        local reverseTrace = util.TraceLine({
            start = endPos,
            endpos = startPos,
            mask = WATER_TRACE_MASK,
            filter = owner
        })

        if reverseTrace.Hit and not reverseTrace.StartSolid then
            return reverseTrace
        end
    end

    return nil
end

function SWEP:DoWaterImpact(beamTrace)
    if CLIENT or CVInt("d_misakarailgun_water_effects_enabled", 1) <= 0 then return end

    local now = CurTime()
    if now < (self._RailNextWaterEffect or 0) then return end

    local waterTrace = self:GetWaterContactTrace(beamTrace)
    if not waterTrace then return end

    local hitPos = waterTrace.HitPos
    if not hitPos then return end

    local normal = waterTrace.HitNormal
    if not normal or normal:LengthSqr() <= 0.001 then
        normal = vector_up
    end

    local minimum = math.max(CVFloat("d_misakarailgun_water_effect_scale_min", 1.5), 0.1)
    local maximum = math.max(CVFloat("d_misakarailgun_water_effect_scale_max", 4.0), 0.1)
    minimum, maximum = OrderedPair(minimum, maximum)
    local scale = ScaleRange(self:GetChargeFraction(), minimum, maximum)

    -- WaterSplash is the same built-in Source effect family used for ordinary
    -- water displacement. Scale it with rail charge so a full discharge has
    -- substantially more surface kick than a weak partial shot.
    local splash = EffectData()
    splash:SetOrigin(hitPos + normal * 0.5)
    splash:SetNormal(normal)
    splash:SetScale(scale)
    splash:SetFlags(0)
    util.Effect("WaterSplash", splash, true, true)

    -- Layer the stock ripple at the same surface point. This stays cosmetic;
    -- water does not alter the beam's damage or world-stop trace semantics.
    local ripple = EffectData()
    ripple:SetOrigin(hitPos + normal * 0.25)
    ripple:SetNormal(normal)
    ripple:SetScale(scale)
    util.Effect("waterripple", ripple, true, true)

    self._RailNextWaterEffect = now + math.max(CVFloat("d_misakarailgun_water_effect_interval", 0.10), 0.03)
end

function SWEP:DoBeamDamage()
    if CLIENT or not self:GetEmittingBeam() then return end

    local owner = self:GetOwner()
    if not IsValid(owner) then return end

    local distance = self:GetBeamDistance()
    if distance <= 0 then return end

    local trace = self:GetRailTrace(distance)
    if not trace then return end

    self:DoImpactDecal(trace)
    self:DoWaterImpact(trace)

    local fraction = self:GetChargeFraction()
    local damageMin = math.max(CVFloat("d_misakarailgun_damage_min", 20), 0)
    local damageMax = math.max(CVFloat("d_misakarailgun_damage_max", 60), 0)
    damageMin, damageMax = OrderedPair(damageMin, damageMax)

    local damage = ScaleRange(fraction, damageMin, damageMax)
    local width = math.max(self:GetCurrentBeamWidth(), 1)
    local radius = width * 0.5
    local extents = Vector(radius, radius, radius)
    local beamStart = trace.BeamStartPos or self:GetBeamStartPos() or owner:GetShootPos()
    local aim = trace.BeamDirection or owner:GetAimVector()

    for _, ent in ipairs(ents.FindAlongRay(beamStart, trace.HitPos, -extents, extents)) do
        if IsValid(ent) and ent ~= self and ent ~= owner then
            local phys = ent:GetPhysicsObject()
            local damageable = ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot() or IsValid(phys)

            if damageable then
                local info = DamageInfo()
                info:SetDamage(damage)
                info:SetDamageType(bit.bor(DMG_DISSOLVE, DMG_SHOCK))
                info:SetDamageForce(aim * (damage * 2.5))
                info:SetDamagePosition(ent:WorldSpaceCenter())
                info:SetAttacker(owner)
                info:SetInflictor(self)
                ent:TakeDamageInfo(info)

                if IsValid(phys) and not ent:IsPlayer() and not ent:IsNPC() and not ent:IsNextBot() then
                    phys:ApplyForceCenter(aim * phys:GetMass() * (damage * 2.5))
                end
            end
        end
    end
end

function SWEP:ProcessRailGun()
    local owner = self:GetOwner()
    if not IsValid(owner) or not owner:IsPlayer() or not owner:Alive() then
        if self:GetEmittingBeam() or self:GetPendingDischarge() or self._RailCharging or self:GetRailGunCharge() > 0 then
            self:ResetRailGunState(false)
        end
        return
    end

    local now = CurTime()
    local lastThink = self._RailLastThink or now
    local delta = math.Clamp(now - lastThink, 0, 0.1)
    self._RailLastThink = now

    if self:GetPendingDischarge() then
        self:SetBeamDistance(0)

        if now >= (self._RailPendingBeamAt or math.huge) then
            self:StartBeam()
        end

        return
    end

    if self:GetEmittingBeam() then
        local maxDistance = math.Clamp(CVFloat("d_misakarailgun_maximumbeamdistance", 5000), 0, 14500)
        local extendTime = math.max(CVFloat("d_misakarailgun_timeforbeamtofullyextend", 0.35), 0.01)
        local extendFraction = math.Clamp((now - (self._RailBeamStartedAt or now)) / extendTime, 0, 1)
        self:SetBeamDistance(maxDistance * extendFraction)

        local duration = math.max(CVFloat("d_misakarailgun_maximumblastdurationinseconds", 3), 0.05)
        local drainPerSecond = 100 / duration
        self:SetRailGunCharge(math.max(self:GetRailGunCharge() - drainPerSecond * delta, 0))

        if now >= (self._RailNextDamage or 0) then
            self:DoBeamDamage()
            self._RailNextDamage = now + math.max(CVFloat("d_misakarailgun_damage_interval", 0.05), 0.02)
        end

        if self:GetRailGunCharge() <= 0 then
            self:EndBeam()
        end

        return
    end

    self:SetBeamDistance(0)

    if not self._RailCharging then
        return
    end

    local chargeTime = math.max(CVFloat("d_misakarailgun_timetofullycharge", 2), 0.05)
    local elapsed = math.max(now - (self._RailChargeStartedAt or now), 0)
    local charge = math.Clamp((elapsed / chargeTime) * 100, 0, 100)
    self:SetRailGunCharge(charge)

    -- Keep the charging loop alive for as long as the player continues to hold
    -- primary fire, including after reaching 100%. The one-shot full-charge
    -- notification is layered on top; ReleaseCharge/ResetRailGunState handle
    -- stopping the loop when charging actually ends.
    if self._RailChargeSound and not self._RailChargeSound:IsPlaying() then
        self._RailChargeSound:PlayEx(0.75, 100)
    end

    if charge >= 100 and not self._RailFullChargeNotified then
        self._RailFullChargeNotified = true

        -- Remote players keep the normal positional charge-complete cue. Do
        -- not include the wielder in this transmission; the owner receives an
        -- explicit client-local copy below so prediction cannot swallow it.
        local recipients = RecipientFilter()
        recipients:AddAllPlayers()
        recipients:RemovePlayer(owner)
        self:EmitSound("items/battery_pickup.wav", 75, 125, 0.8, CHAN_AUTO, 0, 0, recipients)

        net.Start(FULL_CHARGE_SOUND_NET)
        net.Send(owner)
    end
end

function SWEP:Think()
    if SERVER then
        self:ProcessRailGun()
    end
end

if SERVER then
    hook.Add("KeyRelease", "DMisakaRailGun_ReleaseCharge", function(ply, key)
        if key ~= IN_ATTACK or not IsValid(ply) then return end

        local wep = ply:GetActiveWeapon()
        if not IsValid(wep) or wep:GetClass() ~= "weapon_dmisakarailgun" then return end
        if not wep.ReleaseCharge then return end

        wep:ReleaseCharge()
    end)
end

if CLIENT then
    killicon.Add("weapon_dmisakarailgun", "vgui/entities/railkill", color_white)

    local selectionMaterial = Material("vgui/entities/weapon_dmisakarailgun")
    local hudBarBackMaterial = Material("d_misakarailgun_mats/finger_point_bar_back.png", "smooth")
    local hudBarFillMaterial = Material("d_misakarailgun_mats/finger_point_bar_front.png", "smooth")
    local defaultBeamMaterial = Material("cable/physbeam")
    local defaultRingMaterial = Material("d_misakarailgun_mats/beam_material")
    local defaultShockMaterial = Material("d_misakarailgun_mats/shock_material")
    local impactGlowMaterial = Material("sprites/light_glow02_add")

    SWEP.WepSelectIcon = surface.GetTextureID("vgui/entities/weapon_dmisakarailgun")

    function SWEP:DrawWeaponSelection(x, y, w, h, alpha)
        surface.SetDrawColor(255, 255, 255, alpha)
        surface.SetMaterial(selectionMaterial)

        local size = math.min(w, h) * 0.82
        surface.DrawTexturedRect(x + (w - size) * 0.5, y + (h - size) * 0.5, size, size)
    end

    local function DrawRailGunHUD(wep)
        if not IsValid(wep) then return end

        local fraction = wep:GetChargeFraction()
        local screenScale = math.Clamp(math.min(ScrW() / 1920, ScrH() / 1080), 0.65, 1.5)
        local barW = 360 * screenScale
        local barH = barW * (332 / 815)
        local margin = 34 * screenScale
        local x = ScrW() - barW - margin
        local y = ScrH() - barH - margin

        local backValid = hudBarBackMaterial and not hudBarBackMaterial:IsError()
        local fillValid = hudBarFillMaterial and not hudBarFillMaterial:IsError()

        if backValid then
            surface.SetMaterial(hudBarBackMaterial)
            surface.SetDrawColor(255, 255, 255, 235)
            surface.DrawTexturedRect(x, y, barW, barH)
        else
            draw.RoundedBox(8, x, y, barW, barH, Color(8, 8, 12, 220))
        end

        if fraction > 0 then
            if fillValid then
                surface.SetMaterial(hudBarFillMaterial)
                surface.SetDrawColor(255, 255, 255, 255)
                surface.DrawTexturedRectUV(x, y, barW * fraction, barH, 0, 0, fraction, 1)
            else
                draw.RoundedBox(8, x, y, barW * fraction, barH, Color(200, 0, 220, 235))
            end
        end

        surface.SetDrawColor(160, 90, 220, 180)
        surface.DrawOutlinedRect(x, y, barW, barH, math.max(1, math.floor(2 * screenScale)))

        local status
        if wep:GetEmittingBeam() then
            status = "DISCHARGING"
        elseif wep.GetPendingDischarge and wep:GetPendingDischarge() then
            status = "COIN FLIP"
        elseif fraction >= 1 then
            status = "FULL CHARGE"
        elseif fraction > 0 then
            status = "CHARGING"
        else
            status = "READY"
        end

        draw.SimpleTextOutlined(
            string.format("%d%%  %s", math.Round(fraction * 100), status),
            "TargetID",
            x + barW * 0.5,
            y + barH + 2 * screenScale,
            Color(235, 205, 255),
            TEXT_ALIGN_CENTER,
            TEXT_ALIGN_TOP,
            1,
            Color(0, 0, 0, 220)
        )
    end

    -- Some gamemodes/weapon bases do not reliably call SWEP:DrawHUD(). Draw from a
    -- namespaced HUDPaint hook instead, but only while this SWEP is the active weapon.
    function SWEP:DrawHUD()
    end

    hook.Add("HUDPaint", "DMisakaRailGun_ChargeHUD", function()
        local ply = LocalPlayer()
        if not IsValid(ply) then return end

        local wep = ply:GetActiveWeapon()
        if not IsValid(wep) or wep:GetClass() ~= "weapon_dmisakarailgun" then return end

        DrawRailGunHUD(wep)
    end)

    local materialCache = {}
    local warnedMaterialPaths = {}

    local function NormalizeMaterialPath(path)
        path = string.Trim(path or "")
        if path == "" then return "" end

        path = string.Replace(path, "\\", "/")
        path = string.gsub(path, "^materials/", "")
        path = string.gsub(path, "%.vmt$", "")
        path = string.gsub(path, "%.vtf$", "")

        return path
    end

    local function ResolveMaterial(path, fallback)
        local normalized = NormalizeMaterialPath(path)
        if normalized == "" then return fallback end

        local cached = materialCache[normalized]
        if cached then return cached end

        local mat = Material(normalized, "smooth")
        if not mat or mat:IsError() then
            if not warnedMaterialPaths[normalized] then
                warnedMaterialPaths[normalized] = true
                MsgC(Color(255, 180, 80), "[Misaka RailGun] Could not load material '", Color(255, 255, 255), normalized, Color(255, 180, 80), "'. Using fallback.\n")
            end
            return fallback
        end

        materialCache[normalized] = mat
        return mat
    end

    local function CVString(name)
        local cvar = GetConVar(name)
        return cvar and cvar:GetString() or ""
    end

    local function GetBeamColor(alpha)
        return Color(
            math.Clamp(CVInt("d_misakarailgun_visuals_beam_color_r", 255), 0, 255),
            math.Clamp(CVInt("d_misakarailgun_visuals_beam_color_g", 255), 0, 255),
            math.Clamp(CVInt("d_misakarailgun_visuals_beam_color_b", 255), 0, 255),
            alpha or 255
        )
    end

    local function GetRingColor(alpha)
        return Color(
            math.Clamp(CVInt("d_misakarailgun_visuals_ring_color_r", 0), 0, 255),
            math.Clamp(CVInt("d_misakarailgun_visuals_ring_color_g", 161), 0, 255),
            math.Clamp(CVInt("d_misakarailgun_visuals_ring_color_b", 255), 0, 255),
            alpha or 255
        )
    end

    local function GetShockColor(alpha)
        return Color(
            math.Clamp(CVInt("d_misakarailgun_visuals_thunderbeams_color_r", 255), 0, 255),
            math.Clamp(CVInt("d_misakarailgun_visuals_thunderbeams_color_g", 255), 0, 255),
            math.Clamp(CVInt("d_misakarailgun_visuals_thunderbeams_color_b", 255), 0, 255),
            alpha or 255
        )
    end

    local function GetVisualBeamData(wep)
        if not IsValid(wep) or not wep.GetEmittingBeam or not wep:GetEmittingBeam() then return nil end

        local owner = wep:GetOwner()
        if not IsValid(owner) then return nil end

        local distance = math.max(wep:GetBeamDistance(), 0)
        if distance <= 0 then return nil end

        local trace = wep:GetRailTrace(distance)
        if not trace then return nil end

        local startPos = trace.BeamStartPos or wep:GetBeamStartPos() or owner:GetShootPos()
        local aim = trace.BeamDirection or owner:GetAimVector()

        return startPos, trace.HitPos, aim, trace
    end

    local activeRings = {}
    local activeArcs = {}
    local weaponRenderState = setmetatable({}, {__mode = "k"})
    local cachedWeapons = {}
    local nextWeaponScan = 0

    local function RefreshWeaponCache()
        if CurTime() < nextWeaponScan then return end
        nextWeaponScan = CurTime() + 0.1
        cachedWeapons = ents.FindByClass("weapon_dmisakarailgun")
    end

    local function AddRing(center, aim, radius, width, jagginess, color, owner)
        local points = {}
        local segments = 32

        for index = 1, segments do
            points[index] = {
                theta = ((index - 1) / segments) * math.pi * 2,
                radialScale = 1 + math.Rand(-jagginess, jagginess) / math.max(radius, 1),
                depth = math.Rand(-jagginess * 0.5, jagginess * 0.5)
            }
        end

        activeRings[#activeRings + 1] = {
            center = center,
            aim = aim,
            radius = radius,
            width = width,
            color = color,
            owner = owner,
            born = CurTime(),
            life = 1.1,
            expansion = 95,
            points = points
        }
    end

    local function EmitStartRings(startPos, aim, fraction, owner)
        local radius = ScaleRange(fraction, 35, 60)
        local width = ScaleRange(fraction, 1.5, 8)
        local jagginess = ScaleRange(fraction, 3, 8)
        local color = GetRingColor(255)

        AddRing(startPos + aim * 100, aim, radius, width, jagginess, color, owner)
        AddRing(startPos + aim * 150, aim, radius, width, jagginess, color, owner)
    end

    local function AddArc(startPos, endPos, fraction)
        local distance = startPos:Distance(endPos)
        local curves = math.Clamp(math.ceil(distance / 250), 2, 24)
        local direction = (endPos - startPos):GetNormalized()
        local ang = direction:Angle()
        local right = ang:Right()
        local up = ang:Up()
        local distanceScale = math.Clamp((distance - 800) / 4200, 0, 1)
        local jagginess = ScaleRange(distanceScale, 20, 60)
        local points = {startPos}

        for index = 1, curves - 1 do
            local t = index / curves
            local base = LerpVector(t, startPos, endPos)
            local edgeFade = math.sin(math.pi * t)
            local offset = right * math.Rand(-jagginess, jagginess) * edgeFade + up * math.Rand(-jagginess, jagginess) * edgeFade
            points[#points + 1] = base + offset
        end

        points[#points + 1] = endPos

        local fadeIn = math.max(CVFloat("d_misakarailgun_visuals_thunderbeams_fade_in_time", 0.1), 0.001)
        local fadeOut = math.max(CVFloat("d_misakarailgun_visuals_thunderbeams_fade_out_time", 0.1), 0.001)

        activeArcs[#activeArcs + 1] = {
            points = points,
            born = CurTime(),
            fadeIn = fadeIn,
            fadeOut = fadeOut,
            width = math.max(CVFloat("d_misakarailgun_visuals_thunderbeams_maxthickness", 15) * ScaleRange(fraction, 0.35, 1), 1),
            color = GetShockColor(255)
        }
    end

    local function IsLocalFirstPersonRing(ring)
        local owner = ring.owner
        return IsValid(owner) and owner == LocalPlayer() and not owner:ShouldDrawLocalPlayer()
    end

    local function DrawRing(ring, ringMaterial)
        local age = CurTime() - ring.born
        local fraction = math.Clamp(age / ring.life, 0, 1)
        if fraction >= 1 then return false end

        local alpha = math.floor((1 - fraction) * ring.color.a)
        local color = Color(ring.color.r, ring.color.g, ring.color.b, alpha)
        local radius = ring.radius + ring.expansion * fraction
        local ang = ring.aim:Angle()
        local right = ang:Right()
        local up = ang:Up()
        local forward = ang:Forward()
        local worldPoints = {}

        for pointIndex, point in ipairs(ring.points) do
            local radial = radius * point.radialScale
            worldPoints[pointIndex] = ring.center
                + right * (math.cos(point.theta) * radial)
                + up * (math.sin(point.theta) * radial)
                + forward * point.depth
        end

        render.SetMaterial(ringMaterial)
        for pointIndex = 1, #worldPoints do
            local nextIndex = pointIndex == #worldPoints and 1 or pointIndex + 1
            render.DrawBeam(worldPoints[pointIndex], worldPoints[nextIndex], ring.width, 0, 1, color)
        end

        return true
    end

    local function DrawRings(firstPersonPass)
        local ringMaterial = ResolveMaterial(CVString("d_misakarailgun_visuals_ring_texture"), defaultRingMaterial)
        local index = 1

        while index <= #activeRings do
            local ring = activeRings[index]
            local localFirstPerson = IsLocalFirstPersonRing(ring)

            if CurTime() - ring.born >= ring.life then
                table.remove(activeRings, index)
            else
                if localFirstPerson == firstPersonPass then
                    DrawRing(ring, ringMaterial)
                end
                index = index + 1
            end
        end
    end

    local function DrawArcs()
        local shockMaterial = ResolveMaterial(CVString("d_misakarailgun_visuals_thunderbeams_texture"), defaultShockMaterial)
        local index = 1

        while index <= #activeArcs do
            local arc = activeArcs[index]
            local age = CurTime() - arc.born
            local totalLife = arc.fadeIn + arc.fadeOut

            if age >= totalLife then
                table.remove(activeArcs, index)
            else
                local alphaFraction
                if age < arc.fadeIn then
                    alphaFraction = math.Clamp(age / arc.fadeIn, 0, 1)
                else
                    alphaFraction = 1 - math.Clamp((age - arc.fadeIn) / arc.fadeOut, 0, 1)
                end

                local color = Color(arc.color.r, arc.color.g, arc.color.b, math.floor(arc.color.a * alphaFraction))
                render.SetMaterial(shockMaterial)

                for pointIndex = 1, #arc.points - 1 do
                    render.DrawBeam(arc.points[pointIndex], arc.points[pointIndex + 1], arc.width, 0, 1, color)
                end

                index = index + 1
            end
        end
    end

    hook.Add("PreDrawEffects", "D_MisakaRailGun_ImprovedRendering", function(_, drawingSkybox)
        if drawingSkybox then return end

        RefreshWeaponCache()

        local beamMaterial = ResolveMaterial(CVString("d_misakarailgun_visuals_beam_texture"), defaultBeamMaterial)

        for _, wep in ipairs(cachedWeapons) do
            if IsValid(wep) and wep.GetEmittingBeam then
                local emitting = wep:GetEmittingBeam()
                local state = weaponRenderState[wep]
                if not state then
                    state = {wasEmitting = false, ringsEmitted = false, nextArc = 0}
                    weaponRenderState[wep] = state
                end

                if emitting then
                    local startPos, endPos, aim, beamTrace = GetVisualBeamData(wep)
                    if startPos and endPos and aim then
                        local chargeFraction = math.Clamp(wep:GetRailGunCharge() / 100, 0, 1)

                        -- EmittingBeam can replicate one frame before BeamDistance becomes
                        -- non-zero. Do not consume the one-shot ring event until valid beam
                        -- geometry actually exists, otherwise the startup rings are skipped.
                        if not state.ringsEmitted then
                            EmitStartRings(startPos, aim, chargeFraction, wep:GetOwner())
                            state.ringsEmitted = true
                        end

                        local minWidth = CVFloat("d_misakarailgun_beam_width_min", 10)
                        local maxWidth = CVFloat("d_misakarailgun_beam_width_max", 40)
                        minWidth, maxWidth = OrderedPair(minWidth, maxWidth)
                        local width = ScaleRange(chargeFraction, minWidth, maxWidth)
                        local color = GetBeamColor(255)
                        local textureOffset = -CurTime() * 2
                        local textureEnd = textureOffset + startPos:Distance(endPos) / 256

                        render.SetMaterial(beamMaterial)
                        render.DrawBeam(startPos, endPos, width, textureOffset, textureEnd, color)

                        if beamTrace and beamTrace.Hit and not beamTrace.HitSky then
                            render.DrawSprite(endPos, width * 2.2, width * 2.2, color)

                            render.SetMaterial(impactGlowMaterial)
                            render.DrawSprite(endPos, width * 1.6, width * 1.6, Color(color.r, color.g, color.b, 220))
                        end

                        if CurTime() >= (state.nextArc or 0) then
                            AddArc(startPos, endPos, chargeFraction)
                            AddArc(startPos, endPos, chargeFraction)
                            AddArc(startPos, endPos, chargeFraction)
                            state.nextArc = CurTime() + 0.06
                        end
                    end
                end

                if not emitting then
                    state.ringsEmitted = false
                    state.nextArc = 0
                end

                state.wasEmitting = emitting
            end
        end

        -- PreDrawEffects runs after the viewmodel render pass. Draw both local
        -- first-person and remote/world rings here, matching the author's WIP
        -- rendering path and avoiding a second hook/state split.
        DrawRings(false)
        DrawRings(true)
        DrawArcs()
    end)
end
