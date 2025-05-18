--- COM1 Radio Handler with Visual Interface
require "graphics"

dataref("COM1", "sim/cockpit2/radios/actuators/com1_standby_frequency_hz_833", "writable")
dataref("COM1_POWER", "sim/cockpit2/radios/actuators/com1_power", "writable")

dataref("COM1_active", "sim/cockpit2/radios/actuators/com1_frequency_hz_833", "writable")

local com1_queue1=COM1_active
local com1_queue3=COM1_active

local com1_fix1="129525"
local com1_fix1_name="München Rad"

local com1_fix2="126175"
local com1_fix2_name="München Rad (APP S)"

local com1_fix3="120840"
local com1_fix3_name="Leipzig Arr S"

local com1_fix4="121105"
local com1_fix4_name="Leipzig Twr S"

local com1_fix5="121805"
local com1_fix5_name="Leipzig Gnd"

local com_toggle

local COM1_STATION_NAME = ""

-- Bildschirmgröße
local interface_width = 150 --original 100
local interface_height = 50
local interface_x = SCREEN_WIDTH - interface_width-50
local interface_y = 0+100
local offset_queue1=60
local offset_queue3=120
local offset_fix1=200
local offset_fix2=260
local offset_fix3=320
local offset_fix4=380
local offset_fix5=440

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

function draw_little_radio2()
    -- Init Graphics
    XPLMSetGraphicsState(0, 0, 0, 1, 1, 0, 0)

    -- Hintergrund zeichnen
    graphics.set_color(0.1, 0.1, 0.1, 0.8)  -- weniger transparentes Grau
    graphics.draw_rectangle(interface_x, interface_y+offset_queue1, interface_x + interface_width, interface_y +offset_queue1+ interface_height)

    -- Power-Indikator zeichnen
    if COM1_POWER == 0 then
        graphics.set_color(0.5, 0, 0, 0.8)  -- Rot bei AUS
    else
        graphics.set_color(0, 1, 0, 0.8)    -- Grün bei EIN
    end
    graphics.draw_rectangle(interface_x, interface_y+offset_queue1, interface_x + 8, interface_y+offset_queue1 + interface_height)

    -- Rahmen zeichnen
    graphics.set_color(1, 1, 1, 1)  -- Weißer Rahmen
    graphics.draw_line(interface_x, interface_y+offset_queue1, interface_x, interface_y +offset_queue1+ interface_height)  -- links
    graphics.draw_line(interface_x, interface_y +offset_queue1+ interface_height, interface_x + interface_width, interface_y+offset_queue1 + interface_height)  -- unten
    graphics.draw_line(interface_x + interface_width, interface_y +offset_queue1+ interface_height, interface_x + interface_width, interface_y+offset_queue1)  -- rechts
    graphics.draw_line(interface_x + interface_width, interface_y+offset_queue1, interface_x, interface_y+offset_queue1)  -- oben

    -- Text anzeigen
    graphics.set_color(1, 1, 1, 1)
    draw_string_Helvetica_12(interface_x + 10, interface_y +offset_queue1+ 30, "Variable 1")
    draw_string_Helvetica_18(interface_x + 10, interface_y +offset_queue1+ 05, string.format("%3.3f", com1_queue1 / 1000))
    --draw_string_Helvetica_12(interface_x + 10, interface_y + 5+offset_queue1, "")
end

function draw_little_radio3()
    -- Init Graphics
    XPLMSetGraphicsState(0, 0, 0, 1, 1, 0, 0)

    -- Hintergrund zeichnen
    graphics.set_color(0.1, 0.1, 0.1, 0.8)  -- weniger transparentes Grau
    graphics.draw_rectangle(interface_x, interface_y+offset_queue3, interface_x + interface_width, interface_y +offset_queue3+ interface_height)

    -- Power-Indikator zeichnen
    if COM1_POWER == 0 then
        graphics.set_color(0.5, 0, 0, 0.8)  -- Rot bei AUS
    else
        graphics.set_color(0, 1, 0, 0.8)    -- Grün bei EIN
    end
    graphics.draw_rectangle(interface_x, interface_y+offset_queue3, interface_x + 8, interface_y+offset_queue3 + interface_height)

    -- Rahmen zeichnen
    graphics.set_color(1, 1, 1, 1)  -- Weißer Rahmen
    graphics.draw_line(interface_x, interface_y+offset_queue3, interface_x, interface_y +offset_queue3+ interface_height)  -- links
    graphics.draw_line(interface_x, interface_y +offset_queue3+ interface_height, interface_x + interface_width, interface_y+offset_queue3 + interface_height)  -- unten
    graphics.draw_line(interface_x + interface_width, interface_y +offset_queue3+ interface_height, interface_x + interface_width, interface_y+offset_queue3)  -- rechts
    graphics.draw_line(interface_x + interface_width, interface_y+offset_queue3, interface_x, interface_y+offset_queue3)  -- oben

    -- Text anzeigen
    graphics.set_color(1, 1, 1, 1)
    draw_string_Helvetica_12(interface_x + 10, interface_y +offset_queue3+ 30, "Variable 2")
    draw_string_Helvetica_18(interface_x + 10, interface_y +offset_queue3+ 05, string.format("%3.3f", com1_queue3 / 1000))
    --draw_string_Helvetica_12(interface_x + 10, interface_y + 5+offset_queue3, "")
end


function draw_little_radio_fix1()
    -- Init Graphics
    XPLMSetGraphicsState(0, 0, 0, 1, 1, 0, 0)

    -- Hintergrund zeichnen
    graphics.set_color(0.1, 0.1, 0.1, 0.8)  -- weniger transparentes Grau
    graphics.draw_rectangle(interface_x, interface_y+offset_fix1, interface_x + interface_width, interface_y +offset_fix1+ interface_height)

    -- Power-Indikator zeichnen
    if COM1_POWER == 0 then
        graphics.set_color(0.5, 0, 0, 0.8)  -- Rot bei AUS
    else
        graphics.set_color(0, 1, 0, 0.8)    -- Grün bei EIN
    end
    graphics.draw_rectangle(interface_x, interface_y+offset_fix1, interface_x + 8, interface_y+offset_fix1 + interface_height)

    -- Rahmen zeichnen
    graphics.set_color(1, 1, 1, 1)  -- Weißer Rahmen
    graphics.draw_line(interface_x, interface_y+offset_fix1, interface_x, interface_y +offset_fix1+ interface_height)  -- links
    graphics.draw_line(interface_x, interface_y +offset_fix1+ interface_height, interface_x + interface_width, interface_y+offset_fix1 + interface_height)  -- unten
    graphics.draw_line(interface_x + interface_width, interface_y +offset_fix1+ interface_height, interface_x + interface_width, interface_y+offset_fix1)  -- rechts
    graphics.draw_line(interface_x + interface_width, interface_y+offset_fix1, interface_x, interface_y+offset_fix1)  -- oben

    -- Text anzeigen
    graphics.set_color(1, 1, 1, 1)
    draw_string_Helvetica_12(interface_x + 10, interface_y +offset_fix1+ 30, com1_fix1_name)
    draw_string_Helvetica_18(interface_x + 10, interface_y +offset_fix1+ 05, string.format("%3.3f", com1_fix1 / 1000))
    --draw_string_Helvetica_12(interface_x + 10, interface_y + 5+offset_fix1, "")
end

function draw_little_radio_fix2()
    -- Init Graphics
    XPLMSetGraphicsState(0, 0, 0, 1, 1, 0, 0)

    -- Hintergrund zeichnen
    graphics.set_color(0.1, 0.1, 0.1, 0.8)  -- weniger transparentes Grau
    graphics.draw_rectangle(interface_x, interface_y+offset_fix2, interface_x + interface_width, interface_y +offset_fix2+ interface_height)

    -- Power-Indikator zeichnen
    if COM1_POWER == 0 then
        graphics.set_color(0.5, 0, 0, 0.8)  -- Rot bei AUS
    else
        graphics.set_color(0, 1, 0, 0.8)    -- Grün bei EIN
    end
    graphics.draw_rectangle(interface_x, interface_y+offset_fix2, interface_x + 8, interface_y+offset_fix2 + interface_height)

    -- Rahmen zeichnen
    graphics.set_color(1, 1, 1, 1)  -- Weißer Rahmen
    graphics.draw_line(interface_x, interface_y+offset_fix2, interface_x, interface_y +offset_fix2+ interface_height)  -- links
    graphics.draw_line(interface_x, interface_y +offset_fix2+ interface_height, interface_x + interface_width, interface_y+offset_fix2 + interface_height)  -- unten
    graphics.draw_line(interface_x + interface_width, interface_y +offset_fix2+ interface_height, interface_x + interface_width, interface_y+offset_fix2)  -- rechts
    graphics.draw_line(interface_x + interface_width, interface_y+offset_fix2, interface_x, interface_y+offset_fix2)  -- oben

    -- Text anzeigen
    graphics.set_color(1, 1, 1, 1)
    draw_string_Helvetica_12(interface_x + 10, interface_y +offset_fix2+ 30, com1_fix2_name)
    draw_string_Helvetica_18(interface_x + 10, interface_y +offset_fix2+ 05, string.format("%3.3f", com1_fix2 / 1000))
    --draw_string_Helvetica_12(interface_x + 10, interface_y + 5+offset_fix2, "")
end

function draw_little_radio_fix3()
    -- Init Graphics
    XPLMSetGraphicsState(0, 0, 0, 1, 1, 0, 0)

    -- Hintergrund zeichnen
    graphics.set_color(0.1, 0.1, 0.1, 0.8)  -- weniger transparentes Grau
    graphics.draw_rectangle(interface_x, interface_y+offset_fix3, interface_x + interface_width, interface_y +offset_fix3+ interface_height)

    -- Power-Indikator zeichnen
    if COM1_POWER == 0 then
        graphics.set_color(0.5, 0, 0, 0.8)  -- Rot bei AUS
    else
        graphics.set_color(0, 1, 0, 0.8)    -- Grün bei EIN
    end
    graphics.draw_rectangle(interface_x, interface_y+offset_fix3, interface_x + 8, interface_y+offset_fix3 + interface_height)

    -- Rahmen zeichnen
    graphics.set_color(1, 1, 1, 1)  -- Weißer Rahmen
    graphics.draw_line(interface_x, interface_y+offset_fix3, interface_x, interface_y +offset_fix3+ interface_height)  -- links
    graphics.draw_line(interface_x, interface_y +offset_fix3+ interface_height, interface_x + interface_width, interface_y+offset_fix3 + interface_height)  -- unten
    graphics.draw_line(interface_x + interface_width, interface_y +offset_fix3+ interface_height, interface_x + interface_width, interface_y+offset_fix3)  -- rechts
    graphics.draw_line(interface_x + interface_width, interface_y+offset_fix3, interface_x, interface_y+offset_fix3)  -- oben

    -- Text anzeigen
    graphics.set_color(1, 1, 1, 1)
    draw_string_Helvetica_12(interface_x + 10, interface_y +offset_fix3+ 30, com1_fix3_name)
    draw_string_Helvetica_18(interface_x + 10, interface_y +offset_fix3+ 05, string.format("%3.3f", com1_fix3 / 1000))
    --draw_string_Helvetica_12(interface_x + 10, interface_y + 5+offset_fix3, "")
end

function draw_little_radio_fix4()
    -- Init Graphics
    XPLMSetGraphicsState(0, 0, 0, 1, 1, 0, 0)

    -- Hintergrund zeichnen
    graphics.set_color(0.1, 0.1, 0.1, 0.8)  -- weniger transparentes Grau
    graphics.draw_rectangle(interface_x, interface_y+offset_fix4, interface_x + interface_width, interface_y +offset_fix4+ interface_height)

    -- Power-Indikator zeichnen
    if COM1_POWER == 0 then
        graphics.set_color(0.5, 0, 0, 0.8)  -- Rot bei AUS
    else
        graphics.set_color(0, 1, 0, 0.8)    -- Grün bei EIN
    end
    graphics.draw_rectangle(interface_x, interface_y+offset_fix4, interface_x + 8, interface_y+offset_fix4 + interface_height)

    -- Rahmen zeichnen
    graphics.set_color(1, 1, 1, 1)  -- Weißer Rahmen
    graphics.draw_line(interface_x, interface_y+offset_fix4, interface_x, interface_y +offset_fix4+ interface_height)  -- links
    graphics.draw_line(interface_x, interface_y +offset_fix4+ interface_height, interface_x + interface_width, interface_y+offset_fix4 + interface_height)  -- unten
    graphics.draw_line(interface_x + interface_width, interface_y +offset_fix4+ interface_height, interface_x + interface_width, interface_y+offset_fix4)  -- rechts
    graphics.draw_line(interface_x + interface_width, interface_y+offset_fix4, interface_x, interface_y+offset_fix4)  -- oben

    -- Text anzeigen
    graphics.set_color(1, 1, 1, 1)
    draw_string_Helvetica_12(interface_x + 10, interface_y +offset_fix4+ 30, com1_fix4_name)
    draw_string_Helvetica_18(interface_x + 10, interface_y +offset_fix4+ 05, string.format("%3.3f", com1_fix4 / 1000))
    --draw_string_Helvetica_12(interface_x + 10, interface_y + 5+offset_fix4, "")
end

function draw_little_radio_fix5()
    -- Init Graphics
    XPLMSetGraphicsState(0, 0, 0, 1, 1, 0, 0)

    -- Hintergrund zeichnen
    graphics.set_color(0.1, 0.1, 0.1, 0.8)  -- weniger transparentes Grau
    graphics.draw_rectangle(interface_x, interface_y+offset_fix5, interface_x + interface_width, interface_y +offset_fix5+ interface_height)

    -- Power-Indikator zeichnen
    if COM1_POWER == 0 then
        graphics.set_color(0.5, 0, 0, 0.8)  -- Rot bei AUS
    else
        graphics.set_color(0, 1, 0, 0.8)    -- Grün bei EIN
    end
    graphics.draw_rectangle(interface_x, interface_y+offset_fix5, interface_x + 8, interface_y+offset_fix5 + interface_height)

    -- Rahmen zeichnen
    graphics.set_color(1, 1, 1, 1)  -- Weißer Rahmen
    graphics.draw_line(interface_x, interface_y+offset_fix5, interface_x, interface_y +offset_fix5+ interface_height)  -- links
    graphics.draw_line(interface_x, interface_y +offset_fix5+ interface_height, interface_x + interface_width, interface_y+offset_fix5 + interface_height)  -- unten
    graphics.draw_line(interface_x + interface_width, interface_y +offset_fix5+ interface_height, interface_x + interface_width, interface_y+offset_fix5)  -- rechts
    graphics.draw_line(interface_x + interface_width, interface_y+offset_fix5, interface_x, interface_y+offset_fix5)  -- oben

    -- Text anzeigen
    graphics.set_color(1, 1, 1, 1)
    draw_string_Helvetica_12(interface_x + 10, interface_y +offset_fix5+ 30, com1_fix5_name)
    draw_string_Helvetica_18(interface_x + 10, interface_y +offset_fix5+ 05, string.format("%3.3f", com1_fix5 / 1000))
    --draw_string_Helvetica_12(interface_x + 10, interface_y + 5+offset_fix5, "")
end


do_every_draw("draw_little_radio()")
do_every_draw("draw_little_radio2()")
do_every_draw("draw_little_radio3()")
do_every_draw("draw_little_radio_fix1()")
do_every_draw("draw_little_radio_fix2()")
do_every_draw("draw_little_radio_fix3()")
do_every_draw("draw_little_radio_fix4()")
do_every_draw("draw_little_radio_fix5()")

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


	if MOUSE_X >= interface_x and MOUSE_X <= interface_x + interface_width and
       MOUSE_Y >= interface_y +offset_queue1 and MOUSE_Y <= interface_y +offset_queue1+ interface_height then
       
	   COM1=COM1_active
		
	   COM1_active = com1_queue1
       COM1_active = math.max(118000, math.min(com1_queue1, 136970))
	   com1_queue1 = COM1
        

        -- Mausereignis beenden
        RESUME_MOUSE_CLICK = true
    end

	if MOUSE_X >= interface_x and MOUSE_X <= interface_x + interface_width and
       MOUSE_Y >= interface_y +offset_queue3 and MOUSE_Y <= interface_y +offset_queue3+ interface_height then
       
	   COM1=COM1_active
		
	   COM1_active = com1_queue3
       COM1_active = math.max(118000, math.min(com1_queue3, 136970))
	   com1_queue3 = COM1
        

        -- Mausereignis beenden
        RESUME_MOUSE_CLICK = true
    end


	
	if MOUSE_X >= interface_x and MOUSE_X <= interface_x + interface_width and
       MOUSE_Y >= interface_y +offset_fix1 and MOUSE_Y <= interface_y +offset_fix1+ interface_height then
       
	   COM1=COM1_active
		
	   COM1_active = com1_fix1
       COM1_active = math.max(118000, math.min(com1_fix1, 136970))
	   

        -- Mausereignis beenden
        RESUME_MOUSE_CLICK = true
    end
	


	if MOUSE_X >= interface_x and MOUSE_X <= interface_x + interface_width and
       MOUSE_Y >= interface_y +offset_fix2 and MOUSE_Y <= interface_y +offset_fix2+ interface_height then
       
	   COM1=COM1_active
		
	   COM1_active = com1_fix2
       COM1_active = math.max(118000, math.min(com1_fix2, 136970))
	   

        -- Mausereignis beenden
        RESUME_MOUSE_CLICK = true
    end


	if MOUSE_X >= interface_x and MOUSE_X <= interface_x + interface_width and
       MOUSE_Y >= interface_y +offset_fix3 and MOUSE_Y <= interface_y +offset_fix3+ interface_height then
       
	   COM1=COM1_active
		
	   COM1_active = com1_fix3
       COM1_active = math.max(118000, math.min(com1_fix3, 136970))
	   

        -- Mausereignis beenden
        RESUME_MOUSE_CLICK = true
    end


	if MOUSE_X >= interface_x and MOUSE_X <= interface_x + interface_width and
       MOUSE_Y >= interface_y +offset_fix4 and MOUSE_Y <= interface_y +offset_fix4+ interface_height then
       
	   COM1=COM1_active
		
	   COM1_active = com1_fix4
       COM1_active = math.max(118000, math.min(com1_fix4, 136970))
	   

        -- Mausereignis beenden
        RESUME_MOUSE_CLICK = true
    end


	if MOUSE_X >= interface_x and MOUSE_X <= interface_x + interface_width and
       MOUSE_Y >= interface_y +offset_fix5 and MOUSE_Y <= interface_y +offset_fix5+ interface_height then
       
	   COM1=COM1_active
		
	   COM1_active = com1_fix5
       COM1_active = math.max(118000, math.min(com1_fix5, 136970))
	   

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

	if MOUSE_X >= interface_x+60 and MOUSE_X <= interface_x + interface_width  and MOUSE_Y >= interface_y+offset_queue1 and MOUSE_Y <= interface_y +offset_queue1+ interface_height then
        com1_queue1 = com1_queue1 + MOUSE_WHEEL_CLICKS * 5
        com1_queue1 = math.max(118000, math.min(com1_queue1, 136970))
        RESUME_MOUSE_WHEEL = true
    end
	if MOUSE_X >= interface_x and MOUSE_X <= interface_x + 60  and MOUSE_Y >= interface_y +offset_queue1 and MOUSE_Y <= interface_y +offset_queue1+ interface_height then
        com1_queue1 = com1_queue1 + MOUSE_WHEEL_CLICKS * 1000
        com1_queue1 = math.max(118000, math.min(com1_queue1, 136970))
        RESUME_MOUSE_WHEEL = true
    end





	if MOUSE_X >= interface_x+60 and MOUSE_X <= interface_x + interface_width  and MOUSE_Y >= interface_y+offset_queue3 and MOUSE_Y <= interface_y +offset_queue3+ interface_height then
        com1_queue3 = com1_queue3 + MOUSE_WHEEL_CLICKS * 5
        com1_queue3 = math.max(118000, math.min(com1_queue3, 136970))
        RESUME_MOUSE_WHEEL = true
    end
	if MOUSE_X >= interface_x and MOUSE_X <= interface_x + 60  and MOUSE_Y >= interface_y +offset_queue3 and MOUSE_Y <= interface_y +offset_queue3+ interface_height then
        com1_queue3 = com1_queue3 + MOUSE_WHEEL_CLICKS * 1000
        com1_queue3 = math.max(118000, math.min(com1_queue3, 136970))
        RESUME_MOUSE_WHEEL = true
    end



end

do_on_mouse_wheel("little_radio_wheel_events()")
