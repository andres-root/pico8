pico-8 cartridge // http://www.pico-8.com
version 18
__lua__


local entity
local coin_entity
local score

function _init()
    score = 0
    entity = {
        x = 64,
        y = 64,
        width = 8,
        height = 8,
        radius = 4,
        move_speed = 2,
        is_horizontally_aligned = false,
        is_vertically_aligned = false,
        update = function(self)
            if btn(0) then
                self.x -= 1
            end
        
            if btn(1) then
                self.x += 1
            end
        
            if btn(2) then
                self.y -= 1
            end
        
            if btn(3) then
                self.y += 1
            end
        
            if btnp(4) then
                sfx(0)
            end
        end,
        draw = function(self)
            spr(1, self.x - 4, self.y - 4)
            circ(self.x, self.y, self.radius, 7)
            -- rect(self.x, self.y, self.x + self.width, self.y + self.height, 7)
            -- print(self.is_vertically_aligned and self.is_horizontally_aligned, self.x + 10, self.y + 7)
        end,
        check_collision = function(self, coin)
            -- Check alignment with coin
            local entity_left = self.x
            local entity_right = self.x + self.width
            local entity_top = self.y
            local entity_bottom = self.y + self.height

            local coin_left = coin.x
            local coin_right = coin.x + coin.width
            local coin_top = coin.y
            local coin_bottom = coin.y + coin.height

            -- Collect the coin
            -- if not coin.is_collected and rects_overlapping(entity_left, entity_top, entity_right, entity_bottom, coin_left, coin_top, coin_right, coin_bottom) then
            if not coin.is_collected and circles_overlapping(self.x, self.y, self.radius, coin.x, coin.y, coin.radius) then
                coin.is_collected = true
                score += 1
            end
        end
    }

    coins = {
        make_coin(25, 30),
        make_coin(40, 20),
        make_coin(30, 60),
        make_coin(70, 80),
        make_coin(90, 50),
        make_coin(20, 40)
    }
end

function _update()
    entity:update()

    local coin

    for coin in all(coins) do
        coin:update()
        entity:check_collision(coin)
    end
end

function _draw()
    cls()
    print(score, 5, 5, 7)
    entity:draw()
    
    local coin
    
    for coin in all(coins) do
        coin:draw()
    end
end

function make_coin(x, y)
    coin_entity = {
        x = x,
        y = y,
        width = 6,
        height = 7,
        radius = 3,
        is_collected = false,
        update = function(self)
        end,
        draw = function(self)
            if not self.is_collected then
                spr(2, self.x - 3, self.y - 3)
                circ(self.x, self.y, self.radius, 12)
            -- rect(self.x, self.y, self.x + self.width, self.y + self.height, 12)
            end
        end,
    }

    return coin_entity
end

function is_point_in_rect(x, y, left, right, top, bottom)
    local is_horizontally_aligned = (top < y and y < bottom)
    local is_vertically_aligned = (left < x and x < right)

    return (is_horizontally_aligned and is_vertically_aligned)
end

function lines_overlapping(min1, max1, min2, max2)
    return (max1 > min2 and max2 > min1)
end

function rects_overlapping(left1, top1, right1, bottom1, left2, top2, right2, bottom2)
    return (lines_overlapping(left1, right1, left2, right2) and lines_overlapping(top1, bottom1, top2, bottom2))
end

function circles_overlapping(x1, y1, r1, x2, y2, r2)
    local dx = x2 - x1
    local dy = y2 - y1
    local dist = sqrt((dx * dx) + (dy * dy))

    return dist < (r1 + r2)
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000f000f0009aa00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070000ffffff09aaaa0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700000f1fff109aaaa0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700000effffe09aaaa0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000ccc0009aaaa0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000011100009aa00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000f0f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
01110000180551a0551c05524050240402403024020240100000026700257002470023700017000e7001270000000027000170000000000000000000000000000000000000000000000000000000000000000000
