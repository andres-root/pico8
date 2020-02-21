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
            spr(1, self.x, self.y)
            rect(self.x, self.y, self.x + self.width, self.y + self.height, 7)
            -- print(self.is_vertically_aligned and self.is_horizontally_aligned, self.x + 10, self.y + 7)
        end,
        check_collision = function(self, coin)
            -- Check alignment with coin
            local left = self.x
            local right = self.x + self.width
            local top = self.y
            local bottom = self.y + self.height

            -- Collect the coin
            if is_point_in_rect(coin.x, coin.y, left, right, top, bottom) and not coin.is_collected then
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
        is_collected = false,
        update = function(self)
        end,
        draw = function(self)
            if not self.is_collected then
                spr(2, self.x, self.y)
                rect(self.x, self.y, self.x + self.width, self.y + self.height, 12)
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
