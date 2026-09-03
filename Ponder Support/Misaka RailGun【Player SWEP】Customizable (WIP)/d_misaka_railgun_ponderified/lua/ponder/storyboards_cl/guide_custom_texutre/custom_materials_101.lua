--August 17, 2026 |R-0-1-X|Ice Frost STEAM_0:0:48074921
local storyboard = Ponder.API.NewStoryboard("Misaka", "Guide-Custom-Texture", "Texture")
storyboard:WithMenuName("Materials/Textures")
storyboard:WithPlaybackName("LVL5 Railgun")
storyboard:WithModelIcon("models/props_combine/combine_intmonitor003.mdl")
storyboard:WithDescription("It's not complicated I swear! Plug & Play!")
storyboard:SetPrimaryLanguage("en")
storyboard:WithBaseEntity(nil)  -- No grid model

-- Chapter 1: Introduction
local chapter1 = storyboard:Chapter("Getting the Material/Texture")


chapter1:AddInstruction("Caption", {
    Text = "Open up Q-Menu and search tool named Material",
    Time = 1,
    TextLength = 6,
    Length = 6,
})


chapter1:AddInstruction("PlacePanel", {
    Name = "q_menu",
    Type = "DImage",
    Time = 4,
    Length = 5,
    Calls = {
        {Method = "SetSize", Args = {477, 1021}},
        {Method = "SetImage", Args = {"materials/random_pictures/tool_material_menu.jpg"}}, -- example material
        {Method = "CenterHorizontal", Args = {0.5}},
        {Method = "CenterVertical", Args = {0.5}},
    },

})


chapter1:AddDelay(7)
chapter1:AddInstruction("Caption", {
    Text = "Pick material you like to use for your beam, o-ring, thunder visuals etc",
    Time = 0,
    TextLength = 4,
    Length = 5,
})


chapter1:AddInstruction("ShowText", {
    Name = "step_1",
    Text = "e.g right click on this material\n then Copy to Clipboard (left click to copy).",
    Time = 5,
    Position = Vector(-30, 0, 5)
})

chapter1:AddDelay(8)


local chapter2 = storyboard:Chapter("Changing Railgun Visuals")

chapter2:AddInstruction("HideText", {
    Name = "step_1",         -- Name of the text to hide
    Time = 0,                  -- When to start this instruction
    Length = 0.5               -- How long the fade-out should take
})


chapter2:AddInstruction("Caption", {
    Text = "save that copied material somewhere\ne.g paste it in the game chat/console",
    Time = 1,
    TextLength = 4,
    Length = 5,
})


chapter2:AddInstruction("RemovePanel", {Name = "q_menu", Time = 5, Length = 1,})

chapter2:AddInstruction("PlacePanel", {
    Name = "console",
    Type = "DImage",
    Time = 5,
    Length = 2,
    Calls = {
        {Method = "SetSize", Args = {1067, 790}},
        {Method = "SetImage", Args = {"materials/random_pictures/console.jpg"}}, -- example material
        {Method = "CenterHorizontal", Args = {0.5}},
        {Method = "CenterVertical", Args = {0.5}},
    },

})

chapter2:AddDelay(5)
chapter2:AddInstruction("Caption", {
    Text = "pick what visual you like to change\ne.g d_misakarailgun_visuals_beam_texture",
    Time = 0,
    TextLength = 4,
    Length = 5,
})

chapter2:AddDelay(5)
chapter2:AddInstruction("Caption", {
    Text = "now paste what you copied material before in the console command\n",
    Time = 0,
    TextLength = 2,
    Length = 2,
})

chapter2:AddInstruction("ShowText", {
    Name = "step_2",
    Text = "e.g d_misakarailgun_visuals_beam_texture models/props_combine/combine_interface_disp\nthen hit enter on the keyboard to change visual.",
    Time = 3,
    Position = Vector(130, 0, -45)
})


local chapter3 = storyboard:Chapter("Console Command")

chapter3:AddDelay(4)
chapter3:AddInstruction("Caption", {
    Text = "Results may vary, especially with third party materials/textures",
    Time = 0,
    TextLength = 4,
    Length = 5,
})


chapter3:AddInstruction("HideText", {
    Name = "step_2",         -- Name of the text to hide
    Time = 0,                  -- When to start this instruction
    Length = 0.5               -- How long the fade-out should take
})


local chapter4 = storyboard:Chapter("Restoring Previous Visual")

chapter4:AddDelay(0.5)
chapter4:AddInstruction("Caption", {
    Text = "To restore the previous visual e.g beam texture",
    Time = 0,
    TextLength = 4,
    Length = 5,
})

chapter4:AddInstruction("ShowText", {
    Name = "step_3",
    Text = "just type qutotation marks twice \"\" after the command\ne.g d_misakarailgun_visuals_beam_texture \"\" and hit enter!",
    Time = 0,
    Position = Vector(130, 0, -45)
})