local block = {}
local lines = {}
local points = {}
local musics = {}
local backgrounds = {}
local theme = 'oriental'
local collision = require('./scripts/collision')
local blocks = require('./scripts/blocks')

function love.load()
    backgrounds['island'] = love.graphics.newImage("asset/sprites/backisland.png")
    backgrounds['oriental'] = love.graphics.newImage("asset/sprites/backoriental.png")

    musics['island'] = love.audio.newSource("asset/songs/coconut-island.mp3", 'stream')
    musics['oriental'] = love.audio.newSource("asset/songs/oriental-adventure.mp3", 'stream')
    musics['space'] = love.audio.newSource("asset/songs/space-blocs.mp3", 'stream')
    musics.mover = love.audio.newSource("asset/songs/move-bloc.mp3", 'stream')

    musics[theme]:setLooping(true)
    musics[theme]:play()

    points.font = love.graphics.newFont(24)
    points.text = "0000"
    love.graphics.setFont(points.font)

    block.sprite = {
        ['island'] = love.graphics.newImage("asset/sprites/sp_blocks_island.png"),
        ['oriental'] = love.graphics.newImage("asset/sprites/sp_blocks_oriental.png")
    }
    block.x = 64 * 2
    block.y = 64 * 2
    block.width = 64
    block.height = 64
    block.pos = 0
    block.quad = love.graphics.newQuad(block.pos, 0, 64, 64, block.sprite[theme]:getDimensions())
end

function love.update(dt)
    collision.wall(block)

    function love.keypressed(key)
        musics.mover:play()

        if key == "space" then
            if block.y ~= 128 then
                local newBlock = nil
                newBlock, block.x, block.y, block.quad = blocks.newBlock(block, theme)
                table.insert(lines, newBlock)
            end
        end

        if key == 'r' then
            lines = {}
            block.x, block.y, block.pos = 64*2, 64*2, 0
            block.quad = love.graphics.newQuad(block.pos, 0, 64, 64, block.sprite[theme]:getDimensions())
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
    love.graphics.draw(backgrounds[theme], 0, 0)
    love.graphics.print(points.text, 130, 84)
    love.graphics.draw(block.sprite[theme], block.quad, block.x, block.y)

    for i, bl in ipairs(lines) do
        love.graphics.draw(bl.sprite, bl.quad, bl.x, bl.y)
    end
end
