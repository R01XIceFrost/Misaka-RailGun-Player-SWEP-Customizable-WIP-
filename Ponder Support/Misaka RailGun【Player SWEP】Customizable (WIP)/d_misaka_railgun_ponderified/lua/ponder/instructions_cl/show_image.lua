--[[

Aug 2, 2026

(Generated and debugged with ChatGPT's assistance)

** Take this plugin with a grain of salt until it's reviewed by an experienced GLua programmer.

Issue: image stay stuck on your screen when playback is interrupted during tutorial, 
let it finish to clean up the image then you can exit Ponder 
or type console command lua_run_cl hook.Remove("HUDPaint", "PonderImage_...")

Issue 2: images is darkish, would be nice if we can show the image a bit bright.

]]
local ShowImage = Ponder.API.NewInstruction("ShowImage")

ShowImage.Length = 2

function ShowImage:First(playback)

    local id = "PonderImage_" .. tostring(self)

    local mat = Material(self.Path or "vgui/white")

    self.HookID = id

    local StartPos = self.ComeFrom or Vector(0, 0, 0)

    hook.Add("HUDPaint", id, function()

        if not mat then return end

        surface.SetMaterial(mat)
        surface.SetDrawColor(255, 255, 255, self.Alpha or 255)

        local w = self.W or 256
        local h = self.H or 256

        local x = (self.X or 0.5) * ScrW() - w / 2
        local y = (self.Y or 0.5) * ScrH() - h / 2

        -- Apply offset
        x = x + StartPos.x
        y = y + StartPos.y

        surface.DrawTexturedRect(x, y, w, h)

    end)

end


function ShowImage:Last(playback)

    if self.HookID then
        hook.Remove("HUDPaint", self.HookID)
    end

end



--[[

example how to use this:

chapter1:AddInstruction("ShowImage", { -- Image will show on the centre/center of your screen

    Path = "materials/ez_resource_icons/geothermal.png",
    X = 0.5,
    Y = 0.5,
    W = 400,
    H = 400,
    Time = 4,
    Length = 5
})
    
]]