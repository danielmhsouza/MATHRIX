local Lines = {}
Lines.blocks = {}
Lines.points = 0

Lines.positionsY = {
    [192] = 0,
    [256] = 0,
    [320] = 0,
    [384] = 0,
    [448] = 0,
    [512] = 0,
}
Lines.positionsX = {
    column1 = { qtd = 0, pos = 0 },
    column2 = { qtd = 0, pos = 0 },
    column3 = { qtd = 0, pos = 0 },
    column4 = { qtd = 0, pos = 0 },
    column5 = { qtd = 0, pos = 0 },
}


function Lines:newBlock(block)
    local pos = 1
    math.randomseed(os.time())
    while pos % 64 ~= 0 do
        pos = math.random(0, (896 - 64))
    end
    local newBlock = block:create()
    local bpos = pos
    local x = 64 * 2
    local y = 64 * 2
    local quad = love.graphics.newQuad(bpos, 0, 64, 64, newBlock.sprite:getDimensions())
    return newBlock, x, y, quad, bpos
end

function Lines:verifyBlocks()
    -- verificando se ha linhas completas
    for i, ps in pairs(self.positionsY) do
        if ps == 5 then
            local bls = {}
            -- salvando valores dos blocos em uma lista
            for index, bl in ipairs(self.blocks) do
                if bl.y == i then
                    table.insert(bls, bl.value)
                end
            end
            -- pegando o menor valor
            table.sort(bls)
            local firstN = bls[1]

            -- verificando se valores são multiplos do menor
            local isMultiple = true
            for k = 1, #bls, 1 do
                if bls[k] % firstN ~= 0 then
                    isMultiple = false
                end
            end
            -- apagando blocos da linha
            if isMultiple then
                self.points = tonumber(self.points) + 1000
                self:destroyLine(i)
            end
        end
    end
end

function Lines:destroyLine(y)
    local i = #self.blocks
    self.positionsY[y] = 0
    while i > 0 do
        if self.blocks[i].y == y then
            table.remove(self.blocks, i)
        end
        i = i - 1
    end
end

function Lines:savePosition(newBlock)
    self.positionsY[newBlock.y] = self.positionsY[newBlock.y] + 1
end

function Lines:update(block, key)
    if key == 'r' then
        Lines.blocks = {}
        block.x, block.y, block.pos = 64 * 2, 64 * 2, 0
        block.quad = love.graphics.newQuad(block.pos, 0, 64, 64, block.sprite[block.theme]:getDimensions())
        self.points = 0000
        self.positionsY = {
            [192] = 0,
            [256] = 0,
            [320] = 0,
            [384] = 0,
            [448] = 0,
            [512] = 0,
        }
        self.positionsX = {
            column1 = { qtd = 0, pos = 0 },
            column2 = { qtd = 0, pos = 0 },
            column3 = { qtd = 0, pos = 0 },
            column4 = { qtd = 0, pos = 0 },
            column5 = { qtd = 0, pos = 0 },
        }
    end

    if key == "space" then
        if block.y ~= 128 then
            local newBlock = nil
            newBlock, block.x, block.y, block.quad, block.pos = self:newBlock(block)
            table.insert(self.blocks, newBlock)
            self:savePosition(newBlock)
            self:verifyBlocks()
        end
    end
end

function Lines:draw()
    for i, bl in ipairs(self.blocks) do
        love.graphics.draw(bl.sprite, bl.quad, bl.x, bl.y)
    end
end

return Lines
