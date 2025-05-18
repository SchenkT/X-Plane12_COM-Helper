--- Switch-Handler for
--- Strobe Light, Landing Light, Taxi Light, Beacon Light, Runway-Turnoff-Light, Seatbelt_Sign
--[[
    This script handles the toggling of various lights and switches in the aircraft.
    It uses datarefs to read and write the state of the lights and switches.
    The script also includes mouse click and wheel event handlers for user interaction.
]]



require "graphics"

--AirbusFBW/StrobeLight 
--AirbusFBW/StrobeLightSwitch

--toliss_airbus/lightcommands/StrobeLightDown
-- toliss_airbus/lightcommands/StrobeLightUp
 --toliss_airbus/lightcommands/NoseLightDown
-- toliss_airbus/lightcommands/NoseLightUp

--dataref("StrobeLightUp", "toliss_airbus/lightcommands/StrobeLightUp", "readonly")
--dataref("StrobeLightDown", "toliss_airbus/lightcommands/StrobeLightDown", "readonly")



--initial settings
--StrobelightsDown=1
--StrobelightsDown=0
--StrobelightsDown=1
--StrobelightsDown=0


Status_of_Switch = get ("ckpt/oh/strobeLight/anim")

local StrobeLight_Status=0
--local com1_queue1=COM1_active

-- Initialisierungen
local click_processed = false


-- Bildschirmgröße
local interface_width = 500 
local interface_height = 50
local interface_x = 200--SCREEN_WIDTH - interface_width-50
local interface_y = SCREEN_HIGHT - interface_height-40--0+100


function draw_little_radio()
    -- Init Graphics
    XPLMSetGraphicsState(0, 0, 0, 1, 1, 0, 0)

    -- Hintergrund zeichnen
    graphics.set_color(0.1, 0.1, 0.1, 0.8)  -- weniger transparentes Grau
    graphics.draw_rectangle(interface_x, interface_y, interface_x + interface_width, interface_y + interface_height)

    -- Power-Indikator zeichnen
    if StrobeLight == 0 then
        graphics.set_color(0.5, 0, 0, 0.8)  -- Rot bei AUS
    else
        graphics.set_color(0, 1, 0, 0.8)    -- Grün bei EIN
    end
    graphics.draw_rectangle(interface_x, interface_y, interface_x + 8, interface_y + interface_height)

    -- Rahmen zeichnen
    graphics.set_color(1, 1, 1, 1)  -- Weißer Rahmen
    graphics.draw_line(interface_x, interface_y, interface_x, interface_y + interface_height)  -- links
    graphics.draw_line(interface_x, interface_y + interface_height, interface_x + interface_width, interface_y + interface_height)  -- unten
    graphics.draw_line(interface_x + interface_width, interface_y + interface_height, interface_x + interface_width, interface_y)  -- rechts
    graphics.draw_line(interface_x + interface_width, interface_y, interface_x, interface_y)  -- oben

    -- Text anzeigen
    graphics.set_color(1, 1, 1, 1)
    draw_string_Helvetica_12(interface_x + 10, interface_y + 30, Strobe)
    draw_string_Helvetica_18(interface_x + 15, interface_y + 5, string.format("%1.0f", StrobeLight_Status ))
    
    --draw_string_Helvetica_12(interface_x + 200, interface_y + 30, "StrobeLightSwitch")
    --draw_string_Helvetica_18(interface_x + 200, interface_y + 5, string.format("%1.0f", StrobeLightSwitch ))

    --draw_string_Helvetica_12(interface_x + 10, interface_y + 5, COM1_STATION_NAME)
end



do_every_draw("draw_little_radio()")


-- Maus-Klick-Handler
function little_radio_mouse_click_events()
    if MOUSE_STATUS == "down" and not click_processed then 
        -- Bereich für Down (unteres Feld, verringern)
        if MOUSE_X >= interface_x and MOUSE_X <= interface_x + interface_width and
           MOUSE_Y >= interface_y and MOUSE_Y <= interface_y + (interface_height/2) then
            StrobelightsDown = 1
            StrobelightsDown = 0
            StrobeLight_Status = StrobeLight_Status - 1
            StrobeLight_Status=math.max(0, math.min(StrobeLight_Status, 2))
            set ("ckpt/oh/strobeLight/anim", StrobeLight_Status)
            click_processed = true
            RESUME_MOUSE_CLICK = true
        end

        -- Bereich für Up (oberes Feld, erhöhen)
        if MOUSE_X >= interface_x and MOUSE_X <= interface_x + interface_width and
           MOUSE_Y >= interface_y + (interface_height/2) and MOUSE_Y <= interface_y + interface_height then
            StrobelightsUp = 1
            StrobelightsUp = 0
            StrobeLight_Status = StrobeLight_Status + 1
            StrobeLight_Status=math.max(0, math.min(StrobeLight_Status, 2))
            set ("ckpt/oh/strobeLight/anim", StrobeLight_Status)
            click_processed = true
            RESUME_MOUSE_CLICK = true
        end
    end

    -- Rücksetzen, wenn die Maus losgelassen wird
    if MOUSE_STATUS == "up" then
        click_processed = false
    end
end

-- Nur einmalige Registrierung des Klick-Handlers
do_on_mouse_click("little_radio_mouse_click_events()")



-- Mausrad-Handler
function little_radio_wheel_events()
	
	if MOUSE_X >= interface_x+60 and MOUSE_X <= interface_x + interface_width  and MOUSE_Y >= interface_y and MOUSE_Y <= interface_y + interface_height then
        COM1 = COM1 + MOUSE_WHEEL_CLICKS * 5
        COM1 = math.max(118000, math.min(COM1, 136970))
        RESUME_MOUSE_WHEEL = true
    end
	if MOUSE_X >= interface_x and MOUSE_X <= interface_x + 60  and MOUSE_Y >= interface_y and MOUSE_Y <= interface_y + interface_height then
        COM1 = COM1 + MOUSE_WHEEL_CLICKS * 1000
        COM1 = math.max(118000, math.min(COM1, 136970))
        RESUME_MOUSE_WHEEL = true
    end



end

do_on_mouse_wheel("little_radio_wheel_events()")
