local bloco = {}
local linhas = {}

function love.load()
    bloco.sprite = love.graphics.newImage("asset/sprites/sp_blocos_oriental.png")
    bloco.x = 64*2
    bloco.y = 64*2
    bloco.width = 64
    bloco.height = 64
    bloco.pos = 0
    quad = love.graphics.newQuad(bloco.pos, 0, 64, 64, bloco.sprite:getDimensions())
end

function geraBloco()
    
    local newBloco = {
        sprite = bloco.sprite,
        x = bloco.x,
        y = bloco.y,
        width = bloco.width,
        height = bloco.height,
        quad = love.graphics.newQuad(bloco.pos, 0, 64, 64, bloco.sprite:getDimensions())
    }

    table.insert(linhas, newBloco)

    local pos = 1
    while pos % 64 ~= 0 do
        pos = math.random(0, (896 - 64))
    end

    bloco.pos = pos
    bloco.x = 64*2
    bloco.y = 64*2

    quad = love.graphics.newQuad(bloco.pos, 0, 64, 64, bloco.sprite:getDimensions())
end
function wallCollision()
    if bloco.x < 0 then
        bloco.x = 0
    end
    if (bloco.x + bloco.width) > 320 then
        bloco.x = bloco.x - bloco.width
    end

    if bloco.y < bloco.height*2 then
        bloco.y = bloco.height*2
    end
    if (bloco.y + bloco.height) > (640-bloco.height) then
        bloco.y = 640 - bloco.height*2
    end
end

function love.update(dt)
    wallCollision()

    function love.keypressed(key)
        if key == "space" then
            geraBloco()
        end

        if key == "up" then
            bloco.y = bloco.y - bloco.height
        elseif key == 'down' then
            bloco.y = bloco.y + bloco.height
        end
        if key == "left" then
            bloco.x = bloco.x - bloco.width
        elseif key == 'right' then
            bloco.x = bloco.x + bloco.width
        end
    end
end

function love.draw()
    love.graphics.draw(bloco.sprite, quad, bloco.x, bloco.y)

    for i, bl in ipairs(linhas) do
        love.graphics.draw(bl.sprite, bl.quad, bl.x, bl.y)
    end
end