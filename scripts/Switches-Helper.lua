--- Switch-Handler for
--- Strobe Light, Landing Light, Taxi Light, Beacon Light, Runway-Turnoff-Light, Seatbelt_Sign
--[[
    This script handles the toggling of various lights and switches in the aircraft.
    It uses datarefs to read and write the state of the lights and switches.
    The script also includes mouse click and wheel event handlers for user interaction.
]]



require "graphics"




dataref("COM1", "sim/cockpit2/radios/actuators/com1_standby_frequency_hz_833", "writable")
dataref("COM1_POWER", "sim/cockpit2/radios/actuators/com1_power", "writable")

dataref("COM1_active", "sim/cockpit2/radios/actuators/com1_frequency_hz_833", "writable")

local com1_queue1=COM1_active
local com1_queue3=COM1_active

local com1_fix1=129525--"129525"
local com1_fix1_name="München Rad"


-- Bildschirmgröße
local interface_width = 150 
local interface_height = 50
local interface_x = SCREEN_WIDTH - interface_width-50
local interface_y = 0+100


function draw_little_radio()
    -- Init Graphics
    XPLMSetGraphicsState(0, 0, 0, 1, 1, 0, 0)

    -- Hintergrund zeichnen
    graphics.set_color(0.1, 0.1, 0.1, 0.8)  -- weniger transparentes Grau
    graphics.draw_rectangle(interface_x, interface_y, interface_x + interface_width, interface_y + interface_height)

    -- Power-Indikator zeichnen
    if COM1_POWER == 0 then
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
    draw_string_Helvetica_12(interface_x + 10, interface_y + 30, "Standby")
    draw_string_Helvetica_18(interface_x + 10, interface_y + 5, string.format("%3.3f", COM1 / 1000))
    --draw_string_Helvetica_12(interface_x + 10, interface_y + 5, COM1_STATION_NAME)
end



do_every_draw("draw_little_radio()")


-- Maus-Klick-Handler
function little_radio_mouse_click_events()
    if MOUSE_STATUS ~= "down" then return end

    
	if MOUSE_X >= interface_x and MOUSE_X <= interface_x + interface_width and
       MOUSE_Y >= interface_y  and MOUSE_Y <= interface_y + interface_height then
       com_toggle=COM1_active
	   COM1_active= COM1
		
	   COM1 = com_toggle
	   
        

        -- Mausereignis beenden
        RESUME_MOUSE_CLICK = true
    end

end


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
