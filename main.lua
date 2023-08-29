local block = {}
local lines = {}
local pontos = {}
local musicas = {}
local fundos = {}
local collision = require('./scripts/collision')
local blocks = require('./scripts/blocks')

function love.load()
    fundos.ilha = love.graphics.newImage("asset/sprites/backisland.png")
    fundos.oriental = love.graphics.newImage("asset/sprites/backisland.png")

    block.sprite = love.graphics.newImage("asset/sprites/sp_blocks_ilha.png")
    block.sprite2 = love.graphics.newImage("asset/sprites/sp_blocks_oriental.png")

    musicas.ilha = love.audio.newSource("asset/songs/coconut-island.mp3", 'stream')
    musicas.oriental = love.audio.newSource("asset/songs/oriental-adventure.mp3", 'stream')
    musicas.space = love.audio.newSource("asset/songs/space-blocs.mp3", 'stream')
    musicas.mover = love.audio.newSource("asset/songs/move-bloc.mp3", 'stream')
    musicas.ilha:setLooping(true)
    -- musicas.mover:setLooping(false)
    musicas.ilha:play()

    pontos.font = love.graphics.newFont(24)
    pontos.text = "0000"
    love.graphics.setFont(pontos.font)

    block.x = 64 * 2
    block.y = 64 * 2
    block.width = 64
    block.height = 64
    block.pos = 0
    block.quad = love.graphics.newQuad(block.pos, 0, 64, 64, block.sprite:getDimensions())
end

function love.update(dt)
    collision.wall(block)

    function love.keypressed(key)
        musicas.mover:play()

        if key == "space" then
            if block.y ~= 128 then
                local newBlock = nil
                newBlock, block.x, block.y, block.quad = blocks.newBlock(block)
                table.insert(lines, newBlock)
            end
        end

        if key == "up" then
            block.y = block.y - block.height
            if collision.blocks(block, lines) then
                block.y = block.y + block.height
            end
        elseif key == 'down' then
            block.y = block.y + block.height
            if collision.blocks(block, lines) then
                block.y = block.y - block.height
            end
        end

        if key == "left" then
            block.x = block.x - block.width
            if collision.blocks(block, lines) then
                block.x = block.x + block.width
            end
        elseif key == 'right' then
            block.x = block.x + block.width
            if collision.blocks(block, lines) then
                block.x = block.x - block.width
            end
        end
    end
end

function love.draw()
    love.graphics.draw(fundos.ilha, 0, 0)
    love.graphics.print(pontos.text, 130, 84)
    love.graphics.draw(block.sprite, block.quad, block.x, block.y)

    for i, bl in ipairs(lines) do
        love.graphics.draw(bl.sprite, bl.quad, bl.x, bl.y)
    end
end
