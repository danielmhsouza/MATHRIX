local blocks = {
    newBlock = function (block)

        local newBlock = {
            sprite = block.sprite,
            x = block.x,
            y = block.y,
            width = block.width,
            height = block.height,
            quad = block.quad
        }

        local pos = 1
        math.randomseed(os.time())
        while pos % 64 ~= 0 do
            pos = math.random(0, (896 - 64))
        end
        local bpos = pos
        local x = 64 * 2
        local y = 64 * 2
        local quad = love.graphics.newQuad(bpos, 0, 64, 64, block.sprite:getDimensions())

        return newBlock, x, y, quad
    end
}

return blocks