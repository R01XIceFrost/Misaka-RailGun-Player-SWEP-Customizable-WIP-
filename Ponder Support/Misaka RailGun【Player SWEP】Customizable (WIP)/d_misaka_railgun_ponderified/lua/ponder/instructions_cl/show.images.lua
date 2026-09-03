--[[

Aug 4, 2026

(Generated and debugged with ChatGPT's assistance)

** Take this plugin with a grain of salt until it's reviewed by an experienced GLua programmer.

Issue: image stay stuck on your screen when playback is interrupted during tutorial, 
let it finish to clean up the image then you can exit Ponder 
or type console command lua_run_cl hook.Remove("HUDPaint", "PonderImage_...")

Issue 2: images is darkish, would be nice if we can show the image a bit bright.
]]

local ShowImages = Ponder.API.NewInstruction("ShowImages")

ShowImages.Length = 2

function ShowImages:First(playback)

    local id = "PonderImages_" .. tostring(self)

    self.HookID = id

    local images = self.Images or {}

    local startTime = self.Time or 0
    local sequential = self.Sequential or false

    local start = CurTime()

    hook.Add("HUDPaint", id, function()

        local currentTime = CurTime() - start


        for index, data in ipairs(images) do

            local show = true


            -- Sequential mode
            if sequential then

                local delay = (index - 1) * (self.Delay or 1)

                if currentTime < delay then
                    show = false
                end

            end


            if show then

                local mat = Material(data.Path or "vgui/white")

                if mat then

                    surface.SetMaterial(mat)

                    surface.SetDrawColor(
                        255,
                        255,
                        255,
                        data.Alpha or 255
                    )


                    local w = data.W or 256
                    local h = data.H or 256


                    local x = (data.X or 0.5) * ScrW() - w / 2
                    local y = (data.Y or 0.5) * ScrH() - h / 2


                    if data.ComeFrom then
                        x = x + data.ComeFrom.x
                        y = y + data.ComeFrom.y
                    end


                    surface.DrawTexturedRect(
                        x,
                        y,
                        w,
                        h
                    )

                end

            end

        end

    end)

end


function ShowImages:Last(playback)

    if self.HookID then
        hook.Remove("HUDPaint", self.HookID)
    end

end

--[[

example  how to use this:

chapter2:AddInstruction("ShowImages", { 
    Time  = 5,
    Sequential = true,
    Delay = 0.2,

    Images = {
        
       {Name = "ore1", Path = "materials/ez_resource_icons/aluminum ore.png", X = 0.63, Y = 0.42, W = 70, H = 70},
       {Name = "ore2", Path = "materials/ez_resource_icons/copper ore.png", X = 0.33, Y = 0.42, W = 70, H = 70},
    }
})



]]