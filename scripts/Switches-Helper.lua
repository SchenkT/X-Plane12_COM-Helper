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



-- get/set-funktions
--ändern zwar die schalter, nicht aber die Funktion!
--[[
ckpt/oh/taxiLight/anim
ckpt/oh/ladningLightLeft/anim (0 oder 2)
ckpt/oh/ladningLightRight/anim (0 oder 2)
ckpt/oh/rwyTurnOff/anim
ckpt/oh/seatbelts/anim
ckpt/flapMain/anim (0,0.25, 0.5, 0.75, 1)
ckpt/speedbrake/anim (0,0.25, 0.5, 0.75, 1)
ckpt/speedbrakeUp/anim (0=disarmed 1 = armed)
ckpt/radar/sys/anim 0=1an, 1=aus, 2=2an
ckpt/fped/radar/mode/anim 0=wx 1=wx+t
--hopefully working get/set-funktions
AirbusFBW/TerrainSelectedND1
AirbusFBW/TerrainSelectedND2
AirbusFBW/WXSwitchPWS 0=aus, 2=an
]]

--dataref("OHP", "AirbusFBW/OHPLightSwitches", "writable", 32)
-- Direktzugriff ohne Array-Initialisierung




local ohp_raw = get("AirbusFBW/OHPLightSwitches")
print("OHP Raw Data: " .. tostring(ohp_raw))

-- Funktion zur Umwandlung in eine 32-Bit-Bitfolge
local function to_bit_string(value)
    local bits = ""
    for i = 31, 0, -1 do
        bits = bits .. tostring(bit.band(bit.rshift(value, i), 1))
    end
    return bits
end

-- Binäre Darstellung von ohp_raw
local bit_string = to_bit_string(ohp_raw)
print("OHP Raw Data (Binary): " .. bit_string)

-- Ausgabe der einzelnen Bits
for i = 0, 31 do
    local bit_value = bit.band(bit.rshift(ohp_raw, i), 1)
    print("Bit " .. i .. ": " .. tostring(bit_value))
end














StrobeLight_Status= get ("ckpt/oh/strobeLight/anim")
--StrobeLight_Status= get ("sim/cockpit/electrical/strobe_lights_on")

dataref("Strobe_Switch_new", "sim/cockpit/electrical/strobe_lights_on", "writable")
--dataref("StrobeLight_Status", "AirbusFBW/StrobeLight", "writable")
--local com1_queue1=COM1_active
--better?
--Strobe_Switch_new=get("sim/cockpit2/switches/strobe_lights_on")-- --0=off, 1=on
-- Initialisierungen
local click_processed = false


-- Bildschirmgröße
local interface_width = 500--50
local interface_height = 50
local interface_x = 200--SCREEN_WIDTH - interface_width-50
local interface_y = SCREEN_HIGHT - interface_height-30--0+100


function draw_little_radio()
    -- Init Graphics
    XPLMSetGraphicsState(0, 0, 0, 1, 1, 0, 0)

    -- Hintergrund zeichnen
    graphics.set_color(0.1, 0.1, 0.1, 0.8)  -- weniger transparentes Grau
    graphics.draw_rectangle(interface_x, interface_y, interface_x + interface_width, interface_y + interface_height)

   
--[0,0,0,0,0,0,0,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    -- Rahmen zeichnen
    graphics.set_color(1, 1, 1, 1)  -- Weißer Rahmen
    graphics.draw_line(interface_x, interface_y, interface_x, interface_y + interface_height)  -- links
    graphics.draw_line(interface_x, interface_y + interface_height, interface_x + interface_width, interface_y + interface_height)  -- unten
    graphics.draw_line(interface_x + interface_width, interface_y + interface_height, interface_x + interface_width, interface_y)  -- rechts
    graphics.draw_line(interface_x + interface_width, interface_y, interface_x, interface_y)  -- oben

    -- Text anzeigen
    graphics.set_color(1, 1, 1, 1)
    Strobe_Switch_new=get("sim/cockpit/electrical/strobe_lights_on")
    --OHP=get("AirbusFBW/OHPLightSwitches")
    draw_string_Helvetica_12(interface_x + 10, interface_y + 30, Strobe_Switch_new)--"Strobe")
    --draw_string_Helvetica_12(interface_x + 100, interface_y + 30, OHP)--"Strobe")
    draw_string_Helvetica_18(interface_x + 15, interface_y + 5, string.format("%1.0f", StrobeLight_Status ))
    
    --draw_string_Helvetica_12(interface_x + 200, interface_y + 30, "StrobeLightSwitch")
    --draw_string_Helvetica_18(interface_x + 200, interface_y + 5, string.format("%1.0f", StrobeLightSwitch ))

    --draw_string_Helvetica_12(interface_x + 10, interface_y + 5, COM1_STATION_NAME)


     -- Power-Indikator zeichnen
    if StrobeLight_Status == 0 then
        graphics.set_color(0.1, 0.1, 0.1, 0.8)  -- dunkelgrau AUS
    elseif StrobeLight_Status == 1 then
        graphics.set_color(0.6, 0.6, 0.6, 0.8)    -- hellgrau bei AUTO
            
    else
        graphics.set_color(1, 1, 1, 0.8)    -- weiß bei EIN
    end
    graphics.draw_rectangle(interface_x, interface_y, interface_x + 8, interface_y + interface_height-1)
end



do_every_draw("draw_little_radio()")


-- Maus-Klick-Handler
function little_radio_mouse_click_events()
     
    if MOUSE_STATUS == "down" and not click_processed then 
        -- Bereich für Down (unteres Feld, verringern)
        if MOUSE_X >= interface_x and MOUSE_X <= interface_x + interface_width and
           MOUSE_Y >= interface_y and MOUSE_Y <= interface_y + (interface_height/2) then
            --StrobelightsDown = 1
            --StrobelightsDown = 0
            StrobeLight_Status = StrobeLight_Status - 1
            StrobeLight_Status=math.max(0, math.min(StrobeLight_Status, 2))
            set ("ckpt/oh/strobeLight/anim", StrobeLight_Status)
            --local current_value = get("AirbusFBW/OHPLightSwitches[7]")
            for i = 0, 31 do
                print("OHP[" .. i .. "]: " .. tostring(OHP[i]))
            end
            print("OHP (entire array) (direct get): " .. tostring(get("AirbusFBW/OHPLightSwitches")))
            print("OHP as table: " .. tostring(type(OHP)))

            print("OHP (entire array): " .. tostring(OHP))
            print("OHP as table: " .. tostring(type(OHP)))
            print("Type of OHP: " .. type(OHP))  -- Erwartet: table
            print("OHP[7]: " .. tostring(OHP[7])) -- Sollte existieren, wenn OHP ein Array ist
            print("OHP[7] vor Änderung: " .. tostring(OHP[7]))
            OHP[7] = StrobeLight_Status
            print("OHP[7] nach Änderung: " .. tostring(OHP[7]))

            --OHP[7]=StrobeLight_Status
            if StrobeLight_Status == 2 then
                set("sim/cockpit/electrical/strobe_lights_on",1)
                Strobe_Switch_new=1

            else
                set("sim/cockpit/electrical/strobe_lights_on",0)
                Strobe_Switch_new=0
            end
            
            click_processed = true
            RESUME_MOUSE_CLICK = true
        end

        -- Bereich für Up (oberes Feld, erhöhen)
        if MOUSE_X >= interface_x and MOUSE_X <= interface_x + interface_width and
           MOUSE_Y >= interface_y + (interface_height/2) and MOUSE_Y <= interface_y + interface_height then
            --StrobelightsUp = 1
            --StrobelightsUp = 0
            StrobeLight_Status = StrobeLight_Status + 1
            StrobeLight_Status=math.max(0, math.min(StrobeLight_Status, 2))
            set ("ckpt/oh/strobeLight/anim", StrobeLight_Status)
            --local current_value = get("AirbusFBW/OHPLightSwitches[7]")
            for i = 0, 31 do
                print("new OHP current_value [" .. i .. "]: " .. tostring(current_value[i]))
            end
            print("OHP (entire array) (direct get): " .. tostring(get("AirbusFBW/OHPLightSwitches")))
            print("OHP as table: " .. tostring(type(OHP)))      
            print("OHP (entire array): " .. tostring(OHP))
            print("OHP as table: " .. tostring(type(OHP)))
            print("Type of OHP: " .. type(OHP))  -- Erwartet: table
            print("OHP[7]: " .. tostring(OHP[7])) -- Sollte existieren, wenn OHP ein Array ist
            print("OHP[7] vor Änderung: " .. tostring(OHP[7]))
            OHP[7] = StrobeLight_Status
            print("OHP[7] nach Änderung: " .. tostring(OHP[7]))

            --OHP[7]=StrobeLight_Status
            if StrobeLight_Status == 2 then
                set("sim/cockpit/electrical/strobe_lights_on",1)
                Strobe_Switch_new=1
            else
                set("sim/cockpit/electrical/strobe_lights_on",0)
                Strobe_Switch_new=0
            end
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
