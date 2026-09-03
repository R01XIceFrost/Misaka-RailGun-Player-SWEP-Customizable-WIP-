--[[

Aug 2, 2026

(Generated and debugged with ChatGPT's assistance)

** Take this plugin with a grain of salt until it's reviewed by an experienced GLua programmer.

]]

local PlaySoundBurst = Ponder.API.NewInstruction("PlaySoundBurst")

PlaySoundBurst.Volume = 1
PlaySoundBurst.Pitch = 100

function PlaySoundBurst:First(playback)

    if not self.Sounds or #self.Sounds == 0 then return end

    self.Sound = self.Sounds[math.random(#self.Sounds)]

    self.Length = math.Rand(
        self.MinLength or 1,
        self.MaxLength or 5
    )

    print("Selected:", self.Sound)
    print("Burst Length:", self.Length)

    local mdlSound = playback.Environment:CreateSound(LocalPlayer(), self.Sound)

    self.ActiveSound = mdlSound

    mdlSound:PlayEx(self.Volume, self.Pitch)

end

function PlaySoundBurst:Last()

    if self.ActiveSound then
        self.ActiveSound:Stop()
    end

end

--[[

example how to use this:

chapter1:AddInstruction("PlaySoundBurst", {
    Sounds = {
        "tfc/talk.wav",
        "npc/combine_soldier/vo/off1.wav",
        "tfc/r_tele1.wav",
        "bot/area_secure.wav"
    },

    Volume = 1,
    Pitch = 100,
    MinLength = 1,
    MaxLength = 4
})
    
]]