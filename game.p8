pico-8 cartridge // http://www.pico-8.com
version 18
__lua__


local entity


function _init()
    entity = {
        x = 64,
        y= 64,
    }
end

function _update()
    if btn(0) then
        entity.x -= 1
    end

    if btn(1) then
        entity.x += 1
    end

    if btn(2) then
        entity.y -= 1
    end

    if btn(3) then
        entity.y += 1
    end

    if btnp(4) then
        sfx(0)
    end
end

function _draw()
    cls()
    -- pal(15, 4)
    spr(1, entity.x, entity.y)
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000f000f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070000ffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700000f1fff10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700000effffe0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000ccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000f0f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
01110000180551a0551c05524050240402403024020240100000026700257002470023700017000e7001270000000027000170000000000000000000000000000000000000000000000000000000000000000000
