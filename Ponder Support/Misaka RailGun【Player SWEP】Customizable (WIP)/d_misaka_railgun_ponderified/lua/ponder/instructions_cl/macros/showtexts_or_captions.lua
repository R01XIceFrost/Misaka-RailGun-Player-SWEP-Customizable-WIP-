--[[

Aug 4, 2026

(Generated and debugged with ChatGPT's assistance)

** Take this plugin with a grain of salt until it's reviewed by an experienced GLua programmer.

Issue: Showtexts 3D positioning is off compared to the native ShowText instruction

]]

local Showtexts = Ponder.API.NewInstructionMacro("Showtexts")

function Showtexts:Run(chapter, parameters)

    local startTime = parameters.Time or 0
    local length = parameters.Length or 1

    local sequential = parameters.Sequential or false
    local delay = parameters.Delay or 1

    local tAdd = 0

    local TextNames = {}


    for i, data in ipairs(parameters.Texts) do

        local name = data.Name or ("Text_" .. tostring(i))

        table.insert(TextNames, name)

        local dimension = data.Dimension or "2D"


        local textDelay = data.Delay or 0


        -- Sequential display
        if sequential then
            textDelay = textDelay + ((i - 1) * delay)
        end


        local showTime = startTime + textDelay


        chapter:AddInstruction("ShowText", {

            Time = showTime,

            Name = name,

            Text = data.Text,

            Markup = data.Markup,

            Dimension = dimension,

            Position = data.Position or Vector(0.5, 0.5, 0),


            PositionRelativeToScreen =
                data.PositionRelativeToScreen ~= nil
                and data.PositionRelativeToScreen
                or dimension == "2D",


            Horizontal = data.Horizontal or TEXT_ALIGN_CENTER,

            Vertical = data.Vertical or TEXT_ALIGN_CENTER,

            TextAlignment = data.TextAlignment or TEXT_ALIGN_CENTER,


            Length = data.FadeIn or 0.5,


            ParentTo = data.ParentTo or nil,


            LocalizeText = data.LocalizeText ~= false

        })


        tAdd = math.max(
            tAdd,
            textDelay + length
        )

    end



    -- Group cleanup
    if not parameters.KeepText then

        local hideTime = startTime + length


        for _, name in ipairs(TextNames) do

            chapter:AddInstruction("HideText", {

                Time = hideTime,

                Length =
                    parameters.InstantHide
                    and 0
                    or (parameters.FadeOut or 0.5),

                Name = name

            })

        end

    end


    return tAdd
end

--[[

example how  to  use  this:

chapter2:AddInstruction("Showtexts", {
    Time = 2.5,
    Length = 4,
    Delay = 0.5,
    Sequential = true,
    InstantHide = true,
    Texts = {
        {Name = "ore1", Text = "Aluminum Ore",  Dimension = "3D", Position = Vector(-50, 50, 60),},
        {Name = "ore2", Text = "Copper Ore", Dimension = "3D", Position = Vector(-80, 50, 50)},
        {Name = "ore3", Text = "Gold Ore", Dimension = "3D", Position = Vector(50, 50, 60)},
        {Name = "ore4", Text = "Platinum Ore", Dimension = "3D", Position = Vector(80, 50, 60)},
    }
})


---2nd example how to use 2D text line last line (157), yes you can mix 3D and 2D showtexts:

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

]]