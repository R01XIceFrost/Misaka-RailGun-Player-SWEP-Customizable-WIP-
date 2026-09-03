--[[

Aug 2, 2026

(Generated and debugged with ChatGPT's assistance)

** Take this plugin with a grain of salt until it's reviewed by an experienced GLua programmer.

]]

local PlayRandomSound = Ponder.API.NewInstruction("PlayRandomSound")

PlayRandomSound.Volume = 1
PlayRandomSound.Pitch = 100

function PlayRandomSound:First(playback)

    if not self.Sounds or #self.Sounds == 0 then return end

    self.Sound = self.Sounds[math.random(#self.Sounds)]

    print("Selected:", self.Sound)

    local mdlSound = playback.Environment:CreateSound(LocalPlayer(), self.Sound)

    self.ActiveSound = mdlSound

    mdlSound:PlayEx(self.Volume, self.Pitch)

end

function PlayRandomSound:Last()

    if self.ActiveSound then
        self.ActiveSound:Stop()
    end

end

--[[
example how to use this:

chapter1:AddInstruction("PlayRandomSound", {
    Sounds = {
        "tfc/talk.wav",
        "npc/combine_soldier/vo/off1.wav",
        "tfc/r_tele1.wav",
        "bot/area_secure.wav"
    },
    
    Volume = 1,
    Pitch = 100,
    Length = 5
})
    
]]