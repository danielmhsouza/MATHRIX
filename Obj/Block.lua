local Block = {}
Block.mapValues = {
    [0] = 2,
    [64] = 3,
    [128] = 4,
    [192] = 5,
    [256] = 6,
    [320] = 8,
    [384] = 9,
    [448] = 10,
    [512] = 12,
    [576] = 14,
    [640] = 15,
    [704] = 16,
    [768] = 18,
    [832] = 20
}
function Block:load(theme)
    self.sprite = {
        ['menu'] = love.graphics.newImage("asset/sprites/sp_blocks_island.png"),
        ['island'] = love.graphics.newImage("asset/sprites/sp_blocks_island.png"),
        ['oriental'] = love.graphics.newImage("asset/sprites/sp_blocks_oriental.png")
    }
    self.x = 64 * 2
    self.y = 64 * 2
    self.width = 64
    self.height = 64
    self.pos = 0
    self.value = 2
    self.quad = love.graphics.newQuad(self.pos, 0, 64, 64, self.sprite[theme]:getDimensions())
    self.theme = theme
end

function Block:create()
    self.value = self.mapValues[self.pos]

    return {
        sprite = self.sprite[self.theme],
        x = self.x,
        y = self.y,
        width = self.width,
        height = self.height,
        quad = self.quad,
        value = self.value
    }
end

function Block:collisionBlocksOnLines(lines)
    for i, bl in ipairs(lines.blocks) do
        if self.x == bl.x and self.y == bl.y then
            return true
        end
    end
    return false
end

function Block:update(lines, key)
    if key == "up" then
        self.y = self.y - self.height
        if self:collisionBlocksOnLines(lines) then
            self.y = self.y + self.height
        end
    elseif key == 'down' then
        self.y = self.y + self.height
        if self:collisionBlocksOnLines(lines) then
            self.y = self.y - self.height
        end
    end

    if key == "left" then
        self.x = self.x - self.width
        if self:collisionBlocksOnLines(lines) then
            self.x = self.x + self.width
        end
    elseif key == 'right' then
        self.x = self.x + self.width
        if self:collisionBlocksOnLines(lines) then
            self.x = self.x - self.width
        end
    end

    if self.x < 0 then
        self.x = 0
    end
    if (self.x + self.width) > 320 then
        self.x = self.x - self.width
    end

    if self.y < self.height * 2 then
        self.y = self.height * 2
    end
    if (self.y + self.height) > (640 - self.height) then
        self.y = 640 - self.height * 2
    end
end

function Block:draw()
    love.graphics.draw(self.sprite[self.theme], self.quad, self.x, self.y)
end

return Block
