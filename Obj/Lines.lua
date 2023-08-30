local Lines = {}
Lines.blocks = {}

function Lines:newBlock(block)
    local newBlock = block:create()

    local pos = 1
    math.randomseed(os.time())
    while pos % 64 ~= 0 do
        pos = math.random(0, (896 - 64))
    end
    local bpos = pos
    local x = 64 * 2
    local y = 64 * 2
    local quad = love.graphics.newQuad(bpos, 0, 64, 64, newBlock.sprite:getDimensions())

    return newBlock, x, y, quad
end

function Lines:update(block, key)
    if key == 'r' then
        Lines.blocks = {}
        block.x, block.y, block.pos = 64 * 2, 64 * 2, 0
        block.quad = love.graphics.newQuad(block.pos, 0, 64, 64, block.sprite[block.theme]:getDimensions())
    end

    if key == "space" then
        if block.y ~= 128 then
            local newBlock = nil
            newBlock, block.x, block.y, block.quad = self:newBlock(block)
            table.insert(self.blocks, newBlock)
        end
    end
end

function Lines:draw()
    for i, bl in ipairs(self.blocks) do
        love.graphics.draw(bl.sprite, bl.quad, bl.x, bl.y)
    end
end

return Lines
