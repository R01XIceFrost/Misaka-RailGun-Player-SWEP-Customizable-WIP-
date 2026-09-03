
AddCSLuaFile()

CreateConVar("d_misakarailgun_timetofullycharge", "2", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "[Misaka RailGun]: How long in Seconds should the Player hold Left-Click to fully charge the RailGun Bar." )

CreateConVar("d_misakarailgun_maximumblastdurationinseconds", "3", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "[Misaka RailGun]: The maximum amount of time in Seconds that the Blast should last for based on how much charge the player had before casting it" )

CreateConVar("d_misakarailgun_timeforbeamtofullyextend", "0.35", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "[Misaka RailGun]: How long it takes in Seconds for the Beam to Fully reach it's Full size once blasted ( Affects It's Hitbox )" )


CreateConVar("d_misakarailgun_maximumbeamdistance", "5000", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "[Misaka RailGun]: How far Should the beam Reach in Hammer Units( Affects It's Hitbox )", 0, 14500 )

CreateConVar("d_misakarailgun_beam_width_min", "10", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "[Misaka RailGun]: The Minimum Width possible of the Beam ( Affects It's Hitbox )", 5, 200 )

CreateConVar("d_misakarailgun_beam_width_max", "40", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "[Misaka RailGun]: The Maximum Width Possible of the Beam ( Affects It's Hitbox )", 5, 200 )

--Beam Visuals

CreateConVar("d_misakarailgun_visuals_beam_texture", "", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "[Misaka RailGun]: Which Texture should the Beam use. ( Leave this as \"\" to use the Default Beam Texture. )" )

CreateConVar("d_misakarailgun_visuals_beam_color_r", "255", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "[Misaka RailGun]: Defines the RGB Red value of the Beam's Color", 0, 255 )
CreateConVar("d_misakarailgun_visuals_beam_color_g", "255", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "[Misaka RailGun]: Defines the RGB Green value of the Beam's Color", 0, 255 )
CreateConVar("d_misakarailgun_visuals_beam_color_b", "255", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "[Misaka RailGun]: Defines the RGB Blue value of the Beam's Color", 0, 255 )

--O Ring effect visuals

CreateConVar("d_misakarailgun_visuals_ring_texture", "", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "[Misaka RailGun]: Which Texture should the Rings use. ( Leave this as \"\" to use the Default Ring Texture. )" )


CreateConVar("d_misakarailgun_visuals_ring_color_r", "0", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "[Misaka RailGun]: Defines the RGB Red value of the Ring Effect's Color", 0, 255 )
CreateConVar("d_misakarailgun_visuals_ring_color_g", "161", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "[Misaka RailGun]: Defines the RGB Green value of the Ring Effect's Color", 0, 255 )
CreateConVar("d_misakarailgun_visuals_ring_color_b", "255", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "[Misaka RailGun]: Defines the RGB Blue value of the Ring Effect's Color", 0, 255 )


--Thunder Visuals

CreateConVar("d_misakarailgun_visuals_thunderbeams_maxthickness", "15", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "[Misaka RailGun]: The Target Width for the Thunder Beams Visuals", 5, 200 )

CreateConVar("d_misakarailgun_visuals_thunderbeams_timetoreachfullthickness", "0.015", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "[Misaka RailGun]: How long it takes for the Shock Beam effects to fully reach their Maximum Thickness in Seconds", 0, 10 )

CreateConVar("d_misakarailgun_visuals_thunderbeams_color_r", "255", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "[Misaka RailGun]: Defines the Red Value of the RGB Color of the Thunder Beams", 0, 255 )

CreateConVar("d_misakarailgun_visuals_thunderbeams_color_g", "255", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "[Misaka RailGun]: Defines the Green Value of the RGB Color of the Thunder Beams", 0, 255 )

CreateConVar("d_misakarailgun_visuals_thunderbeams_color_b", "255", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "[Misaka RailGun]: Defines the Blue Value of the RGB Color of the Thunder Beams", 0, 255 )

CreateConVar("d_misakarailgun_visuals_thunderbeams_fade_in_time", "0.1", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "[Misaka RailGun]: Defines how long in Seconds the Thunder Shock visuals should take to fully fade in", 0, 20 )

CreateConVar("d_misakarailgun_visuals_thunderbeams_fade_out_time", "0.1", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "[Misaka RailGun]: Defines how long in Seconds the Thunder Shock visuals should take to fully fade out", 0, 20 )

CreateConVar("d_misakarailgun_visuals_thunderbeams_texture", "", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "[Misaka RailGun]: Defines the Custom Shock Beams texture (Leave this as \"\" to use the Default Texture.)" )


--Select icon
if CLIENT then
    SWEP.WepSelectionIcon = surface.GetTextureID( 'd_misakarailgun_mats/finger_bar' )

    --killicon.Add( "weapon_dgoldencrowbar", "d_golden_crowbar/d_goldcrowbar_killicon", color_white )

    local wep_icon = Material( "d_misakarailgun_mats/finger_bar" )
    local icon_size = 96
    local icon_width = 180

    function SWEP:DrawWeaponSelection( x, y, w, h, a )
        surface.SetDrawColor( 5, 5, 255, a )
        surface.SetMaterial( wep_icon )

        --centralize the spot
        surface.DrawTexturedRect( x + ( ( w - icon_width ) / 2 ), y + ( ( h - icon_size ) / 2.5 ), icon_width, icon_size )

    end


end

SWEP.PrintName = "Misaka RailGun"
SWEP.Author = "Dragonred"
SWEP.Purpose = "Blast your enemies away"

SWEP.Instructions = "Hold [Left-Click] to charge the Rail Bar, Then Release to cast a powerful Beam."

SWEP.Slot = 0
SWEP.SlotPos = 2

SWEP.Category = "Other"

SWEP.Spawnable = true

SWEP.ViewModel = Model( "models/weapons/c_arms.mdl" )
SWEP.WorldModel = ""
SWEP.UseHands = true
SWEP.ViewModelFOV = 58

SWEP.HoldType = "pistol"

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false

SWEP.DrawAmmo = false


---== Math Methods ==---

--Mathematical method to calculate the paths for the jagged 3D Circle

--center: Where the circle starts, Centralized from there
--radius: How big should the circle be
--Segments: Maximum amount of vectorial points to form the circle, more segments means smoother but bigger performance impact.
--Jagginess: How much noise/jagging should the segments have

local function generate_jagged_circle_pathways(center, radius, segments, jagginess, angle)

    local segments_result = {}
    local tan_au = math.pi * 2


    local pitch = math.rad(angle.p)
    local yaw = math.rad(angle.y + 90)

    --matrix calculation
    local cp, sp = math.cos(pitch), math.sin(pitch)
    local cy, sy = math.cos(yaw), math.sin(yaw)

    local forward = Vector(-sy * cp, cy * cp, sp)
    local right = Vector( -cy,-sy,0 )
    local up = Vector(-sy * sp, cy * sp, -cp )
    

    for i = 0, segments - 1 do
        local theta = (i / segments) * tan_au
        
        local jagged_radius = radius + math.random(-jagginess, jagginess)
        local depth_offset = math.random(-jagginess * 0.5, jagginess * 0.5)
        
        local cx_offset = jagged_radius * math.cos(theta)
        local cy_offset = jagged_radius * math.sin(theta)
        
        local x = center.x + (right.x * cx_offset) + (up.x * cy_offset) + (forward.x * depth_offset)
        local y = center.y + (right.y * cx_offset) + (up.y * cy_offset) + (forward.y * depth_offset)
        local z = center.z + (right.z * cx_offset) + (up.z * cy_offset) + (forward.z * depth_offset)
        
        segments_result[#segments_result + 1] = Vector(x,y,z)
    end
    
    return segments_result
end

--Simple math to calculate the next step to approach a value to another
local function approach_value_in_seconds( target, start, tick_rate, desired_time )
    return ((target - start) * tick_rate) / math.max(desired_time, 0.01)
end

--Frame independent step increment (testing math, don't mind this, just checking if i'm doing the calculations right for this with math.exp)
local function frameind_approach( start_value, target_value, desired_time, tick_rate )
    local rate = 1.0 / math.max( desired_time, 0.01 ) -- never divide by 0
    local next_value = (target_value - start_value) * (1.0 - math.exp(-rate * tick_rate))
    return next_value
end


--Normalize the multiplication, 0-1 min max
local function scale_multiplication(mul,min,max)

    return mul * (max - min) + min

end

local function get_right_vector(vec)

    local right_dir = Vector(0,0,1):Cross(vec):GetNormalized()

    return right_dir

end

local function get_vector_up(vec)

    local right_dir = get_right_vector(vec)

    local up_pend = right_dir:Cross(vec):GetNormalized()

    return -up_pend

end


local function generate_thunder_paths(start_pos, end_pos, curves, curve_jag)
    local paths = { start_pos }
    
    for i = 1, curves - 1 do
        
        local next_path = Vector(
            start_pos.x + (end_pos.x - start_pos.x) * (i / curves),
            start_pos.y + (end_pos.y - start_pos.y) * (i / curves),
            start_pos.z + (end_pos.z - start_pos.z) * (i / curves)
        )
        
        next_path.x = next_path.x + (math.random() - 0.5) * curve_jag
        next_path.y = next_path.y + (math.random() - 0.5) * curve_jag
        next_path.z = next_path.z + (math.random() - 0.5) * curve_jag
        
        paths[#paths + 1] = next_path
    end
    
    paths[#paths + 1] = end_pos
    return paths
end



function SWEP:SetupDataTables()

    self:NetworkVar( "Float", 0, "RailGunCharge")
    self:NetworkVar( "Bool", 0, "EmittingBeam")

    if ( SERVER ) then

        --The current charge value, Defines the Intensity and Power of the beam ( Networked Variable )
        self:SetRailGunCharge(0)
        self:SetEmittingBeam(false)

    end

end

function SWEP:Initialize()

    self:SetHoldType(self.HoldType)

end

function SWEP:PrimaryAttack()

end

function SWEP:SecondaryAttack()

end

function SWEP:Reload()

end

--Just a wrapper function
local function play_sound( condition, csound, volume, pitch )

    if ( csound != nil && condition ) then
        csound:PlayEx(volume,pitch)
    end

end

local function stop_sound( condition, csound, optional_fade )

    if ( csound != nil && condition ) then

        if ( optional_fade != nil ) then
            csound:FadeOut(optional_fade)
            return
        end

        csound:Stop()
    end

end

function SWEP:Holster()

    self:SetRailGunCharge(0)
    stop_sound(true, self.Beam_Charging_Sound)
    stop_sound(true, self.Beam_Blasting_Sound)

    return true

end

function SWEP:PlayerTrace(max_dist)

    local tr = util.TraceLine({
        start = self.Owner:GetShootPos(),
        endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * max_dist,
        filter = function(ent) if ( ent:IsWorld() == false ) then return false end return true end,
    })

    return tr

end

function SWEP:RayCast_RailDamage(dmg_amount, beam_width, trace)

    if ( self.BeamDamage_CD >= CurTime() ) then
        return
    end

    local vec = Vector( beam_width/2, beam_width/2, beam_width/2)
    --Uses built-in spatial hashing/partitioning, so it will not be super heavy on the server runner's CPU
    local objs = ents.FindAlongRay( self.Owner:GetShootPos(), trace.HitPos, -vec, vec )


    for _, ent in ipairs(objs) do

        if ( ent == self or ent == self.Owner ) then
            continue
        end

        local p = ent:GetPhysicsObject()
        if ( !ent:IsNPC() && !ent:IsPlayer() && !ent:IsNextBot() && !IsValid(p) ) then
            continue
        end

        local d = DamageInfo()

        d:SetDamage(dmg_amount)
        d:SetDamageType(DMG_DISSOLVE)
        d:SetDamageForce(self.Owner:GetAimVector() * ( dmg_amount * 2.5 ))
        d:SetAttacker(self.Owner)
        d:SetInflictor(self)

        ent:TakeDamageInfo(d)

        if ( IsValid(p) ) then

            p:ApplyForceCenter( p:GetMass() * self.Owner:GetAimVector() * (dmg_amount * 2.5) )

        end

    end

    --wait 2 general gmod ticks (0.014)
    self.BeamDamage_CD = CurTime() + 0.025

end


SWEP.RailGunBlast_Cooldown = 0
SWEP.RailGun_RingEmited = false
SWEP.Emmiting_Beam = false
SWEP.ThunderJaggLinesCD = 0

SWEP.Beam_Charging_Sound = nil
SWEP.Beam_Blasting_Sound = nil

SWEP.Current_Beam_Dist = 9000

SWEP.BeamDamage_CD = 0


--||| Main Attack Method |||---

function SWEP:ProcessBeam()

    --Start CSound Entities
    self.Beam_Charging_Sound = ( self.Beam_Charging_Sound == nil ) && CreateSound( self, "weapons/physcannon/hold_loop.wav", filter ) or self.Beam_Charging_Sound
    self.Beam_Blasting_Sound = ( self.Beam_Blasting_Sound == nil ) && CreateSound( self, "npc/stalker/laser_burn.wav", filter ) or self.Beam_Blasting_Sound

    local charge_snd = self.Beam_Charging_Sound
    local beam_snd = self.Beam_Blasting_Sound

    local keep_blasting = (self.Owner:KeyDown(IN_ATTACK) == false)
    keep_blasting = (self:GetEmittingBeam()) && self:GetEmittingBeam() or keep_blasting

    local charging_playing = charge_snd:IsPlaying()

    if ( self:GetRailGunCharge() >= 100 && charging_playing ) then

        self.Beam_Charging_Sound:Stop()
        self:EmitSound("items/battery_pickup.wav", 75, 75, 1)

    end

    --emit blast
    if ( self:GetRailGunCharge() > 0 && keep_blasting ) then

        local time_to_reach_fullbeamdist = GetConVar("d_misakarailgun_timeforbeamtofullyextend"):GetFloat()
        local max_beam_dist = GetConVar("d_misakarailgun_maximumbeamdistance"):GetFloat()

        local next_approach_distance = math.abs(frameind_approach( 0, max_beam_dist, time_to_reach_fullbeamdist, FrameTime() ))

        self.Current_Beam_Dist = math.Clamp(self.Current_Beam_Dist + math.abs(next_approach_distance), 0, max_beam_dist )
        
        local mul_ = math.Clamp( (self:GetRailGunCharge()/100),0, 1)
        local d_pos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 120 
        local d_pos_Seconds = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 170
        local max_dmg = scale_multiplication(mul_, 20, 60 )

        local max_ring_width = scale_multiplication( mul_,1.5, 8 )
        
        
        local min_width = GetConVar("d_misakarailgun_beam_width_min"):GetFloat()
        local max_width = GetConVar("d_misakarailgun_beam_width_max"):GetFloat()
        local beam_width = scale_multiplication(mul_, min_width, max_width )
        local ply_trace = self:PlayerTrace(self.Current_Beam_Dist)
        
        self:RayCast_RailDamage(math.Round(max_dmg), beam_width, ply_trace)
        local world_pos1 = ply_trace.HitPos + ply_trace.HitNormal
        local world_pos2 = ply_trace.HitPos - ply_trace.HitNormal
        util.Decal( "Dark", world_pos1, world_pos2 )

        if ( self.RailGun_RingEmited == false ) then

            self.Owner:EmitSound("npc/scanner/cbot_energyexplosion1.wav",75, 120)

            local max_ring_radius = scale_multiplication(mul_,35,60)
            local max_jag = scale_multiplication(mul_,3,8)

            local ring_r = GetConVar("d_misakarailgun_visuals_ring_color_r"):GetInt()
            local ring_g = GetConVar("d_misakarailgun_visuals_ring_color_g"):GetInt()
            local ring_b = GetConVar("d_misakarailgun_visuals_ring_color_b"):GetInt()
            local ring_color =  Color(ring_r,ring_g,ring_b,255)
         
            D_MisakaGun_AddRing_Sv( d_pos, self.Owner:EyeAngles(), "d_misakarailgun_mats/beam_material", max_ring_width, max_ring_radius, 32, max_jag, ring_color, 1.1, 95, 1.2 )
            D_MisakaGun_AddRing_Sv( d_pos_Seconds, self.Owner:EyeAngles(), "d_misakarailgun_mats/beam_material", max_ring_width, max_ring_radius, 32, max_jag, ring_color, 1.1, 95, 1.2 )
            
            self.RailGun_RingEmited = true
        end

        --In case we wanna have a ring being emited from the player while plasting
        --D_MisakaGun_AddRing_Sv( d_pos, self.Owner:EyeAngles(), "d_misakarailgun_mats/beam_material", 3, 40, 32, 2, Color(215,5,25,255), 0.1, 50, 0.2 )

        local up_beam = get_vector_up(self.Owner:GetAimVector())
        local right_beam = get_right_vector(self.Owner:GetAimVector())
        local beam_start = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 20 + up_beam * -10 + right_beam * -8

        local beam_string = GetConVarString("d_misakarailgun_visuals_beam_texture")
        local beam_texture = (beam_string != nil && beam_string != "") && beam_string or "cable/physbeam"

        local beam_r = GetConVar("d_misakarailgun_visuals_beam_color_r"):GetInt()
        local beam_g = GetConVar("d_misakarailgun_visuals_beam_color_g"):GetInt()
        local beam_b = GetConVar("d_misakarailgun_visuals_beam_color_b"):GetInt()
        local beam_color = Color(beam_r,beam_g,beam_b,255)

        D_MisakaGun_AddBeam_SV(beam_texture,beam_start,ply_trace.HitPos,beam_width, beam_color )

        --Jagged lines 
        if ( self.ThunderJaggLinesCD < CurTime() ) then

            for i = 1, 3 do
                local dist_len = (ply_trace.HitPos - ply_trace.StartPos):Length()
                local max_curves = dist_len / 250
                max_curves = math.ceil(max_curves)

                local diff_max_spread = math.Clamp( (dist_len - 800 ) / ( 5000 - 800 ),0, 1 )
                local spread_r = scale_multiplication( diff_max_spread, 30, 60 )

                local ply_ang_dir_r = self.Owner:GetAimVector():Angle():Right()
                local ply_ang_dir_u = self.Owner:GetAimVector():Angle():Up()
                
                local max_right = 0
                local max_up = 0

                if ( diff_max_spread > 0 ) then
                    max_right = math.random(-spread_r,spread_r) 
                    max_right = ( max_right ) && math.min(max_right,-30) or math.max(max_right,30)

                    max_up = math.random(-spread_r,spread_r)
                    max_up = ( max_up < 0 ) && math.min(max_up,-20) or math.max(max_up,30)
                end

                local start_pos = beam_start + ply_ang_dir_r * math.random(-2,2)
                local final_pos = ply_trace.HitPos 
                
                local jagg_beam_width = GetConVar("d_misakarailgun_visuals_thunderbeams_maxthickness"):GetFloat()
                local thunder_r = GetConVar("d_misakarailgun_visuals_thunderbeams_color_r"):GetInt()
                local thunder_g = GetConVar("d_misakarailgun_visuals_thunderbeams_color_g"):GetInt()
                local thunder_b = GetConVar("d_misakarailgun_visuals_thunderbeams_color_b"):GetInt()
                local thunder_col = Color(thunder_r,thunder_g,thunder_b,255)

                local thunder_fadein = GetConVar("d_misakarailgun_visuals_thunderbeams_fade_in_time"):GetFloat()
                local thunder_fadeout = GetConVar("d_misakarailgun_visuals_thunderbeams_fade_out_time"):GetFloat()

                local jag_shock = math.random(30,65)

                local string_shock = GetConVarString("d_misakarailgun_visuals_thunderbeams_texture")
                local texture_shock = ( string_shock != nil && string_shock != "" ) && string_shock or ""

                local time_to_reach_fullthick = GetConVar("d_misakarailgun_visuals_thunderbeams_timetoreachfullthickness"):GetFloat()

                D_MisakaGun_AddJaggedBeam_SV( texture_shock, start_pos, final_pos, jagg_beam_width, max_curves, jag_shock, thunder_fadein, thunder_fadeout, thunder_col, time_to_reach_fullthick )
                --D_MisakaGun_AddJaggedBeam_SV( texture, startpos, endpos, width, curves, jagg_amount, fade_in_time, fade_out_time, color, desired_formation_time )
                self.ThunderJaggLinesCD = CurTime() + 0.06
            end

        end

        if ( self:GetEmittingBeam() == false ) then
            self:SetEmittingBeam(true)
        end

        stop_sound( charge_snd:IsPlaying(), charge_snd )

        local beam_snd = self.Beam_Blasting_Sound
        play_sound( !beam_snd:IsPlaying() && self:GetRailGunCharge() > 0, beam_snd, 1, 70 )

        local duration = GetConVar("d_misakarailgun_maximumblastdurationinseconds"):GetFloat()
        local next_step = frameind_approach( 100, 0, duration, FrameTime() )
        local val = self:GetRailGunCharge() - math.abs(next_step)
        local new_bar_val = math.Clamp( val,0, 100 )
        
        self:SetRailGunCharge(new_bar_val)

    end

    self.RailGunBlast_Cooldown = ( self:GetEmittingBeam()) && (CurTime() + 0.85) or self.RailGunBlast_Cooldown

    local desired_beam_value = (self:GetEmittingBeam() && self:GetRailGunCharge() > 0) && true or false

    if ( self:GetEmittingBeam() != desired_beam_value ) then
        self:SetEmittingBeam(desired_beam_value)
    end

    stop_sound( beam_snd:IsPlaying() && self:GetRailGunCharge() <= 0, beam_snd, 0.2 )

    if ( self.RailGunBlast_Cooldown < CurTime() && self:GetRailGunCharge() < 100 && self.Owner:KeyDown(IN_ATTACK) && self:GetEmittingBeam() == false ) then

        self.Current_Beam_Dist = 0

        local time_to_charge = GetConVar("d_misakarailgun_timetofullycharge"):GetFloat()
        local next_step = frameind_approach( 0, 100, time_to_charge, FrameTime() )
        local val = self:GetRailGunCharge() + math.abs(next_step)
        local new_bar_val = math.Clamp( val, 0, 100 )
        
        self:SetRailGunCharge(new_bar_val)

        self.RailGun_RingEmited = false

        play_sound( !charging_playing, charge_snd, 1, 80 )

        if ( charging_playing == false && self:GetRailGunCharge() < 100 ) then
            self.Beam_Charging_Sound:PlayEx(1,80)
        end

        if ( self:GetRailGunCharge() >= 100 && charging_playing ) then

            self.Beam_Charging_Sound:Stop()
            self:EmitSound("items/battery_pickup.wav", 75, 75, 1)

        end

        return
    end


end


function SWEP:Think()

    if ( SERVER ) then
        self:ProcessBeam()
    end


end


local bar_texture = Material("d_misakarailgun_mats/finger_bar")

function SWEP:DrawHUD()

    local bar_x = ScrW() * 1550/1920
    local bar_y = ScrH() * 965/1080
    
    local bar_w = ScrW() * 350/1920
    local bar_h = ScrH() * 110/1080

    draw.RoundedBox( 8, bar_x, bar_y, bar_w, bar_h, Color( 10, 10, 10, 110 ) )

    local finger_bar_x = ScrW() * 1551/1920
    local finger_bar_y = ScrH() * 968/1080

    local finger_bar_w = ScrW() * 300/1920
    local finger_bar_h = ScrH() * 105/1080

    --Back part
    surface.SetDrawColor( 25, 15, 125, 155 ) 
	surface.SetMaterial( bar_texture )
	surface.DrawTexturedRect( finger_bar_x, finger_bar_y, finger_bar_w, finger_bar_h) 

    local bar_perc = math.Clamp( self:GetRailGunCharge()/100, 0, 1)

    --Front part
    surface.SetDrawColor( 220, 15, 245, 255 ) 
	surface.SetMaterial( bar_texture )
	surface.DrawTexturedRectUV( finger_bar_x, finger_bar_y, finger_bar_w * bar_perc, finger_bar_h, 0, 0, bar_perc, 1 ) 

    draw.DrawText( math.Round( 100 * bar_perc ).."%", "TargetID", (bar_x + bar_w) - 25, (bar_y + 70), percentage_text_col, TEXT_ALIGN_CENTER )

end



----=== Rendering Systems ===----

local pre_stored_mats = {
    ["trails/plasma"] = Material("trails/plasma"),
    ["trails/electric"] = Material("trails/electric"),
    ["trails/tube"] = Material("trails/tube"),
    ["trails/physbeam"] = Material("trails/physbeam"),
    ["trails/laser"] = Material("trails/laser"),
    ["d_misakarailgun_mats/beam_material"] = Material("d_misakarailgun_mats/beam_material"),
    ["d_misakarailgun_mats/shock_material"] = Material("d_misakarailgun_mats/shock_material"),
}


--- ====|| Ring Rendering ||==== ----

if (SERVER) then
    util.AddNetworkString("D_MisakaGun_AddRingEffectSV")

    --Instead of a Class-like hashtable to pass as parameter, i'll make a function with multiple Variables, so it's easier for the Commissioner (Ice Frost) to tinker with

    --ring_fade_time = How long in seconds for the Ring to fully fade away ( starts fading slowly )
    --ring_expansion_size = how big should the Ring get after the initial radius creation
    --ring_expansion_duration = how long in seconds to reach that expansion size
    function D_MisakaGun_AddRing_Sv( ring_center_pos, ring_eulerangle, ring_line_texture, ring_line_width, ring_radius, ring_segments, ring_jagg, ring_color, ring_fade_time, ring_expansion_size, ring_expansion_duration )

        --Small hashtable, so no need to use compression
        local ring_data = { Center = ring_center_pos, Ang = ring_eulerangle, Texture = ring_line_texture, Width = ring_line_width, Mat_ = nil, Radius = ring_radius, Start_Radius = ring_radius, Segments = ring_segments, Jagg = ring_jagg, Col = ring_color, Fade_In_Seconds = ring_fade_time, Starting_Alpha = ring_color.a, time_started = CurTime(), Stored_A_Float = ring_color.a, Max_Expansion = ring_expansion_size, Expansion_Time = ring_expansion_duration }

        net.Start("D_MisakaGun_AddRingEffectSV")
        net.WriteTable(ring_data)
        net.Broadcast()

    end

end

if (CLIENT) then

    D_MisakaRailGun_Render_Rings = D_MisakaRailGun_Render_Rings or {}

    net.Receive("D_MisakaGun_AddRingEffectSV", function()
    
        local ring_data = net.ReadTable()

        if ( ring_data == nil ) then return end

        D_MisakaGun_AddRing_CL(ring_data)
    
    end)

    function D_MisakaGun_AddRing_CL(ring_data)

        ring_data.time_started = CurTime()

        D_MisakaRailGun_Render_Rings[#D_MisakaRailGun_Render_Rings + 1] = ring_data

    end

    --Actual Rendering

    local default_ring_mat = Material("d_misakarailgun_mats/beam_material")

    local cur_ring_text = nil
    local cur_ring_mat = nil

    local stored_ring_mats = {}
    local ring_mats_stored = 1

    hook.Add("PreDrawEffects", "D_MisakaGun_RingRenderingDelegate", function(bdepth, bskybox, threedskybox )
    
        if ( bskybox ) then return end

        --While loop so we don't have any ghost-frames with the rendering when removing a ring
        local i = 1
        
        while( i <= #D_MisakaRailGun_Render_Rings) do

            local v = D_MisakaRailGun_Render_Rings[i]

            local rslt_mat = default_beam_texture
            local defined_by_precache = false

            if ( pre_stored_mats[v.Texture] != nil ) then
                rslt_mat = pre_stored_mats[v.Texture]
                defined_by_precache = true
            end

            if ( defined_by_precache == false && cur_ring_text != v.Texture && stored_ring_mats[v.Texture] != nil ) then
                cur_ring_mat = stored_ring_mats[v.Texture]
                cur_ring_text = v.Texture
            end

            local valid_c_text = ( v.Texture != nil && v.Texture != "")

            --if it's a new texture and we haven't cached it yet, create the new material and cache it.
            local mat_index = ring_mats_stored
            local mat_holder = (valid_c_text && !defined_by_precache && cur_ring_text != v.Texture) && Material(v.Texture) or nil
            local new_mat = (valid_c_text && !defined_by_precache && cur_ring_text != v.Texture && mat_holder != nil) && Material(v.Texture) or nil

            cur_ring_mat = (valid_c_text && !defined_by_precache && cur_ring_text != v.Texture && new_mat != nil && mat_holder != nil) && new_mat or cur_ring_mat
            cur_ring_text = (valid_c_text && !defined_by_precache && cur_ring_text != v.Texture && new_mat != nil && mat_holder != nil) && v.Texture or cur_ring_text

            if ( !defined_by_precache && stored_ring_mats[v.Texture] == nil ) then
                stored_ring_mats[v.Texture] = new_mat
                ring_mats_stored = ring_mats_stored + 1
            end

            rslt_mat = ( valid_c_text && cur_ring_mat != nil && !defined_by_precache ) && cur_ring_mat or rslt_mat

            if ( v.Col.a <= 0 ) then
                --print("time stayed:", CurTime() - v.time_started)
                table.remove(D_MisakaRailGun_Render_Rings,i)
                continue
            end

            local generated_paths = generate_jagged_circle_pathways(v.Center, v.Radius, v.Segments, v.Jagg,v.Ang)

            --draw paths
            for j = 1, #generated_paths do

                local line_pos = generated_paths[j]
                local next_pos = generated_paths[j+1]

                if ( j >= #generated_paths ) then
                    next_pos = generated_paths[1]
                end

                render.SetMaterial(rslt_mat)
                render.DrawBeam( line_pos, next_pos, v.Width, 0, 1, v.Col )

            end

            local mul = math.min((CurTime() - v.time_started )/v.Fade_In_Seconds, 1 )
            local new_alpha = v.Stored_A_Float - (v.Starting_Alpha*mul)

            local c_col = v.Col
            c_col.a = math.ceil(new_alpha)

            v.Col = c_col

            --apply expansion increase

            if ( v.Max_Expansion > 0 ) then
                local expand_mul = math.min((CurTime() - v.time_started)/v.Expansion_Time, 1 )

                local new_expansion = v.Start_Radius + (v.Max_Expansion * expand_mul)

                v.Radius = new_expansion
            end

            i = i + 1

        end
    
    end)

end


--- ====|| Beam Rendering ||==== ----

if ( SERVER ) then
    util.AddNetworkString("D_MisakaRailGun_AddBeamSV")

    function D_MisakaGun_AddBeam_SV(beam_texture,beam_start,beam_end,beam_width, beam_color)

        local tbl = { Texture = beam_texture, Mat_ = nil, Start = beam_start, EndPos = beam_end, Width = beam_width, Col = beam_color}

        net.Start("D_MisakaRailGun_AddBeamSV")
        net.WriteTable(tbl)
        net.Broadcast()

    end

end

if ( CLIENT ) then

    D_MisakaGun_BeamRenders = D_MisakaGun_BeamRenders or {}

    net.Receive("D_MisakaRailGun_AddBeamSV", function()
    
        local beam_data = net.ReadTable()

        if ( beam_data == nil ) then
            return
        end

        D_MisakaGun_AddBeam_CL(beam_data)

    
    end)

    function D_MisakaGun_AddBeam_CL(beam_data)

        D_MisakaGun_BeamRenders[#D_MisakaGun_BeamRenders + 1] = beam_data

    end

    local default_beam_texture = Material("cable/physbeam")

    local c_beam_mat = nil
    local c_beam_text = nil

    local stored_beam_renders = {}
    local stored_beams_amount = 1

    hook.Add("PreDrawEffects", "D_MisakaGun_BeamRendersDelegate", function()

        local i = 1

        while( #D_MisakaGun_BeamRenders > 0 ) do

            local v = D_MisakaGun_BeamRenders[i]

            local rslt_mat = default_beam_texture
            local defined_by_precache = false

            if ( pre_stored_mats[v.Texture] != nil ) then
                rslt_mat = pre_stored_mats[v.Texture]
                defined_by_precache = true
            end

            if ( defined_by_precache == false && c_beam_text != v.Texture && stored_beam_renders[v.Texture] != nil ) then
                c_beam_mat = stored_beam_renders[v.Texture]
                c_beam_text = v.Texture
            end

            local valid_c_text = ( v.Texture != nil && v.Texture != "")

            --if it's a new texture and we haven't cached it yet, create the new material and cache it.
            local mat_index = stored_beams_amount
            local mat_holder = (valid_c_text && !defined_by_precache && c_beam_text != v.Texture) && Material(v.Texture) or nil
            local new_mat = (valid_c_text && !defined_by_precache && c_beam_text != v.Texture && mat_holder != nil) && Material(v.Texture) or nil

            c_beam_mat = (valid_c_text && !defined_by_precache && c_beam_text != v.Texture && new_mat != nil && mat_holder != nil) && new_mat or c_beam_mat
            c_beam_text = (valid_c_text && !defined_by_precache && c_beam_text != v.Texture && new_mat != nil && mat_holder != nil) && v.Texture or c_beam_text

            if ( !defined_by_precache && stored_beam_renders[v.Texture] == nil ) then
                stored_beam_renders[v.Texture] = new_mat
                stored_beams_amount = stored_beams_amount + 1
            end

            rslt_mat = ( valid_c_text && c_beam_mat != nil && !defined_by_precache ) && c_beam_mat or rslt_mat

            local beam_texture_start = math.Clamp( (CurTime()% -0.25)/-0.25,0,1)

            render.SetMaterial(rslt_mat)
            render.DrawBeam( v.Start, v.EndPos, v.Width, beam_texture_start, 1, v.Col )

            table.remove(D_MisakaGun_BeamRenders,i)

        end

    end)


end


--- ====|| Jagged Beam Lines Rendering ||==== ----

if ( SERVER ) then

    util.AddNetworkString("D_MisakaGun_AddJaggedLineSV")

    function D_MisakaGun_AddJaggedBeam_SV( texture, startpos, endpos, width, curves, jagg_amount, fade_in_time, fade_out_time, color, desired_formation_time )

        local tbl = { Start = startpos, HitPos = endpos, Curves = curves, Width = width, Jagginess = jagg_amount, Fade_In_Time = fade_in_time, Fade_Out_Time = ( fade_in_time + fade_out_time) , time_started = CurTime(), Has_Faded_In = false, Color = color, Float_Alpha = color.a, Starting_Alpha = color.a, Texture = texture, Mat_ = nil, thunder_paths = nil, current_max_thunder = 1, Thunder_Formation_Time = desired_formation_time }

        net.Start("D_MisakaGun_AddJaggedLineSV")
        net.WriteTable(tbl)
        net.Broadcast()

    end

end

if ( CLIENT ) then

    D_MisakaGun_JaggedBeams = D_MisakaGun_JaggedBeams or {}

    net.Receive("D_MisakaGun_AddJaggedLineSV", function()
    
        local beam_jag_data = net.ReadTable()
        if ( beam_jag_data == nil ) then return end

        D_MisakaGun_AddJaggedBeam_CL(beam_jag_data)

    
    end)

    function D_MisakaGun_AddJaggedBeam_CL(beam_data)

        D_MisakaGun_JaggedBeams[#D_MisakaGun_JaggedBeams + 1] = beam_data

    end

    local default_jag_mat = Material("d_misakarailgun_mats/shock_material")

    local c_jag_mat = nil
    local c_jag_tex = nil

    local stored_jag_mats = {}
    local stored_mats_amount = 1

    hook.Add("PreDrawEffects", "D_MisakaGun_DrawJaggedLines", function()

        local i = 1

        while( i <= #D_MisakaGun_JaggedBeams ) do

            local v = D_MisakaGun_JaggedBeams[i]

            local rslt_mat = default_jag_mat
            local defined_by_precache = false

            if ( pre_stored_mats[v.Texture] != nil ) then
                rslt_mat = pre_stored_mats[v.Texture]
                defined_by_precache = true
            end

            if ( defined_by_precache == false && c_jag_tex != v.Texture && stored_jag_mats[v.Texture] != nil ) then
                c_jag_mat = stored_jag_mats[v.Texture]
                c_jag_tex = v.Texture
            end

            local valid_c_text = ( v.Texture != nil && v.Texture != "")

            --if it's a new texture and we haven't cached it yet, create the new material and cache it.
            local mat_index = stored_mats_amount
            local mat_holder = (valid_c_text && !defined_by_precache && c_jag_tex != v.Texture) && Material(v.Texture) or nil
            local new_mat = (valid_c_text && !defined_by_precache && c_jag_tex != v.Texture && mat_holder != nil) && Material(v.Texture) or nil

            c_jag_mat = (valid_c_text && !defined_by_precache && c_jag_tex != v.Texture && new_mat != nil && mat_holder != nil) && new_mat or c_jag_mat
            c_jag_tex = (valid_c_text && !defined_by_precache && c_jag_tex != v.Texture && new_mat != nil && mat_holder != nil) && v.Texture or c_jag_tex

            if ( !defined_by_precache && stored_jag_mats[v.Texture] == nil ) then
                stored_jag_mats[v.Texture] = new_mat
                stored_mats_amount = stored_mats_amount + 1
            end

            rslt_mat = ( valid_c_text && c_jag_mat != nil && !defined_by_precache ) && c_jag_mat or rslt_mat


            if ( v.Has_Faded_In == false ) then
                
                local fade_in_mul = (CurTime()-v.time_started)/v.Fade_In_Time
                fade_in_mul = math.Clamp(fade_in_mul, 0, 1)
                
                local alpha_rslt = scale_multiplication(fade_in_mul, 0, v.Starting_Alpha)
                v.Float_Alpha = alpha_rslt
                
                local c = v.Color
                c.a = math.Round(v.Float_Alpha)
                v.Color = c
                
                v.Has_Faded_In = ( fade_in_mul >= 1 )
                
            else
                
                local fade_in_mul = (CurTime()-v.time_started)/v.Fade_Out_Time
                fade_in_mul = math.Clamp(fade_in_mul, 0, 1)
                
                local alpha_rslt = scale_multiplication(fade_in_mul, v.Starting_Alpha, 0)
                v.Float_Alpha = alpha_rslt
                
                local c = v.Color
                c.a = math.Round(v.Float_Alpha)
                v.Color = c
                
            end
            
            if ( v.Has_Faded_In && v.Float_Alpha <= 0 ) then
                table.remove(D_MisakaGun_JaggedBeams,i)
                continue
            end
            
            v.thunder_paths = (v.thunder_paths == nil) && generate_thunder_paths(v.Start, v.HitPos, v.Curves, v.Jagginess) or v.thunder_paths

            for j = 1, v.current_max_thunder do

                local point = v.thunder_paths[j]
                local next_point = v.thunder_paths[math.min( j + 1, #v.thunder_paths)]

                local render_start = math.Clamp( (CurTime()%1.25)/1.25, 0, 1)

                render.SetMaterial(rslt_mat)
                render.DrawBeam( point, next_point, v.Width, -render_start, 1, v.Color)
            end

            local add_prog = math.min( (CurTime() - v.time_started)/ v.Thunder_Formation_Time, 1)
            local prog_lerp = v.current_max_thunder + (#v.thunder_paths - v.current_max_thunder) * add_prog
            local prog_round = math.Round(prog_lerp)

            v.current_max_thunder = prog_round

            i = i + 1


        end

    end)


end



