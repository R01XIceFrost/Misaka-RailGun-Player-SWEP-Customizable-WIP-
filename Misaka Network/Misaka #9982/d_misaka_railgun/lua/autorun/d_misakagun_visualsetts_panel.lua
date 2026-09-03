
if ( SERVER ) then

end

if ( CLIENT ) then


    D_MisakaRailGun_VisualSett_Panel = D_MisakaRailGun_VisualSett_Panel or nil

    function D_MisakaRailGun_OpenVisualSettingsPanel()

        if ( IsValid(D_MisakaRailGun_VisualSett_Panel) ) then
            return
        end

        D_MisakaRailGun_VisualSett_Panel = vgui.Create("DFrame")
        local f = D_MisakaRailGun_VisualSett_Panel
        f:SetSize( ScrW() * 850/1920, ScrH() * 550/1080 )
        f:Center()
        f:MakePopup()
        
        function f:Paint(w,h)

            draw.RoundedBox( 8, 0, 0, w, h, Color(15,15,15,255))
            draw.RoundedBox( 8, 0, 0, w, ScrH() * 35/1080, Color(35,35,35,255))
            draw.DrawText( "Misaka Railgun: Visual Settings", "TargetIDSmall", ScrW() * 20/1920, ScrH() * 30/1080, Color(255,65,25,255), TEXT_ALIGN_LEFT )

        end

        


    end



end