--August 17, 2026 |R-0-1-X|Ice Frost STEAM_0:0:48074921
local storyboard = Ponder.API.NewStoryboard("Misaka", "Memory-Aid", "Commands")
storyboard:WithMenuName("Commands")
storyboard:WithPlaybackName("LVL5 Railgun")
storyboard:WithModelIcon("models/props_combine/combine_intmonitor003.mdl")
storyboard:WithDescription("Copy & paste directly from the console — no explanation, only default ConVars.")
storyboard:SetPrimaryLanguage("en")
storyboard:WithBaseEntity(nil)  -- No grid model

-- Chapter 1: Introduction
local chapter1 = storyboard:Chapter("Intro (Random Music)")

chapter1:AddInstruction("PlayRandomSound", {
    Sounds = {
        "intros/1.mp3",
        "intros/2.mp3",
        "intros/3.mp3",
        "intros/4.mp3",
        "intros/5.mp3",
        "intros/6.mp3",
        "intros/7.mp3",
        "intros/8.mp3",
        "intros/9.mp3"
    },
    Volume = 1, --off this when debugging/working tutroial on this which it can get annoying 
    Pitch = 100,
    Length = 20
})

chapter1:AddInstruction("ConsolePrint", {
    Length = 0,
    Text = [[
=== Primary ===
1. d_misakarailgun_timetofullycharge
2. d_misakarailgun_maximumblastdurationinseconds
3. d_misakarailgun_timeforbeamtofullyextend
4. d_misakarailgun_maximumbeamdistance
5. d_misakarailgun_beam_width_min
6. d_misakarailgun_beam_width_max
============

=== Beams ===
1. d_misakarailgun_visuals_beam_texture
2. d_misakarailgun_visuals_beam_color_r
3. d_misakarailgun_visuals_beam_color_b
4. d_misakarailgun_visuals_beam_color_g
============

=== O Ring Effect Visuals ===
1. d_misakarailgun_visuals_ring_texture 
2. d_misakarailgun_visuals_ring_color_r
3. d_misakarailgun_visuals_ring_color_g
4. d_misakarailgun_visuals_ring_color_b
============

=== Thunde Visuals ===
1. d_misakarailgun_visuals_thunderbeams_maxthickness
2. d_misakarailgun_visuals_thunderbeams_timetoreachfullthickness
3. d_misakarailgun_visuals_thunderbeams_color_r
4. d_misakarailgun_visuals_thunderbeams_color_g
5. d_misakarailgun_visuals_thunderbeams_color_b
6. d_misakarailgun_visuals_thunderbeams_fade_in_time
7. d_misakarailgun_visuals_thunderbeams_fade_out_time
8. d_misakarailgun_visuals_thunderbeams_texture
============

=== MISC ====
(Unlikely to be implemented into the main Misaka RailGun unless people request it in the comments)
Note: These miscellaneous commands will remain available on Misaka #10030 in case people prefer this version over the final product.

1. d_misakarailgun_damage_min
2. d_misakarailgun_damage_max
3. d_misakarailgun_damage_interval
4. d_misakarailgun_recharge_cooldown
5. d_misakarailgun_minimum_charge_to_fire
6. d_misakarailgun_impact_decal_interval
7. d_misakarailgun_impact_decal_spacing
8. d_misakarailgun_water_effects_enabled
9. d_misakarailgun_water_effect_interval
10. d_misakarailgun_water_effect_scale_min
11. d_misakarailgun_water_effect_scale_max

============

Kuroko! 
What are you doing here?!
]]

})

chapter1:AddInstruction("PlacePanel", {
    Name = "label1",
    Type = "DLabel",
    Time = 5,
    Length = 5,
    Calls = {
        {Method = "SetSize", Args = {600, 20}},
        {Method = "SetText", Args = {"Reference Sheet will show here shortly..."}},
        {Method = "SetFont", Args = {"Trebuchet24"}},
        {Method = "SetTextColor", Args = {Color(255,255,0)}},
        {Method = "CenterHorizontal", Args = {0.56}},
        {Method = "CenterVertical", Args = {0.23}},
    },

})

chapter1:AddInstruction("RemovePanel", {Name = "label1", Time = 5, Length = 5,})

chapter1:AddInstruction("PlacePanel", {
    Name = "misaka",
    Type = "DImage",
    Time = 0,
    Length = 5,
    Calls = {
        {Method = "SetSize", Args = {960, 540}},
        {Method = "SetImage", Args = {"materials/wallpapers/background1.jpg"}}, -- example material
        {Method = "CenterHorizontal", Args = {0.5}},
        {Method = "CenterVertical", Args = {0.5}},
    },

})

chapter1:AddInstruction("RemovePanel", {Name = "misaka", Time = 5, Length = 5,})


chapter1:AddDelay(10)
chapter1:AddInstruction("Caption", {
    Text = "Commands will automatically be printed in your console - \neach time you play this tutorial!\nAny numbers/strings shown are the default values for the ConVars.",
    Time = 0,
    TextLength = 4,
    Length = 10,
})

chapter1:AddInstruction("Showtexts", {
    Time = 6,
    Length = 7,
    Delay = 0.5,
    Sequential = true,
    InstantHide = true,
    Texts = {
        {Name = "Primary", Text = "*Primary*\n1. d_misakarailgun_timetofullycharge 2\n2. d_misakarailgun_maximumblastdurationinseconds 3\n3. d_misakarailgun_timeforbeamtofullyextend 0.35\n4. d_misakarailgun_maximumbeamdistance 5000\n5. d_misakarailgun_beam_width_min 10\n6. d_misakarailgun_beam_width_max 40",  Dimension = "3D", Position = Vector(200, 0, 80),},
        {Name = "Beam_Visuals", Text = "*Beam Visuals*\n1. d_misakarailgun_visuals_beam_texture \"\" \n2. d_misakarailgun_visuals_beam_color_r 255\n3. d_misakarailgun_visuals_beam_color_g 255\n4. d_misakarailgun_visuals_beam_color_b 255", Dimension = "3D", Position = Vector(200, 0, -5)},
        {Name = "O_Rings", Text = "*O-Ring Effect Visuals*\n1. d_misakarailgun_visuals_ring_texture \"\"\n2. d_misakarailgun_visuals_ring_color_r 0\n3. d_misakarailgun_visuals_ring_color_g 161\n4. d_misakarailgun_visuals_ring_color_b 255", Dimension = "3D", Position = Vector(-200, 0, 50)},
        {Name = "Thunders", Text = "*Thunder Visuals*\n1. d_misakarailgun_visuals_thunderbeams_maxthickness 15\n2. d_misakarailgun_visuals_thunderbeams_timetoreachfullthickness 0.015\n3. d_misakarailgun_visuals_thunderbeams_color_r 255\n4. d_misakarailgun_visuals_thunderbeams_color_g 255\n5. d_misakarailgun_visuals_thunderbeams_color_b 255\n6. d_misakarailgun_visuals_thunderbeams_fade_in_time 0.1\n7. d_misakarailgun_visuals_thunderbeams_fade_out_time 0.1\n8. d_misakarailgun_visuals_thunderbeams_texture \"\"", Dimension = "2D", Position = Vector(0.5, 0.6,0)},
    }
})



chapter1:AddInstruction("MoveCameraLookAt", {
    Target = Vector(0, 0, 0), -- Show camera from the origin 0,0,0
    Distance = 3000, 
    Angle = 35,
    Height = 200,
    Length = 0
})


-- Before Ch2 starts
chapter1:AddDelay(3)

local chapter2 = storyboard:Chapter("Fun Fact About ConVars")

chapter2:AddInstruction("Caption", {
    Text = "Fun fact: Typing just the name of a ConVar in the console -\ne.g d_misakarailgun_timetofullycharge\nshows its description and default value.",
    Time = 0,
    TextLength = 5,
    Length = 10,
})


