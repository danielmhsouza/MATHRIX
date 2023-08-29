local bloco = {}
local linhas = {}
local pontos = {}
local musicas = {}
local fundos = {}
function love.load()
    fundos.ilha = love.graphics.newImage("asset/sprites/backisland.png")
    fundos.oriental = love.graphics.newImage("asset/sprites/backisland.png")

    bloco.sprite = love.graphics.newImage("asset/sprites/sp_blocos_ilha.png")
    bloco.sprite2 = love.graphics.newImage("asset/sprites/sp_blocos_oriental.png")

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

    bloco.x = 64 * 2
    bloco.y = 64 * 2
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
    math.randomseed(os.time())
    while pos % 64 ~= 0 do
        pos = math.random(0, (896 - 64))
    end

    bloco.pos = pos
    bloco.x = 64 * 2
    bloco.y = 64 * 2

    quad = love.graphics.newQuad(bloco.pos, 0, 64, 64, bloco.sprite:getDimensions())
end

function wallCollision()
    if bloco.x < 0 then
        bloco.x = 0
    end
    if (bloco.x + bloco.width) > 320 then
        bloco.x = bloco.x - bloco.width
    end

    if bloco.y < bloco.height * 2 then
        bloco.y = bloco.height * 2
    end
    if (bloco.y + bloco.height) > (640 - bloco.height) then
        bloco.y = 640 - bloco.height * 2
    end
end

function blocoCollision()
    for i, bl in ipairs(linhas) do
        if bloco.x == bl.x and bloco.y == bl.y then
            return true
        end
    end
    return false
end

function love.update(dt)
    wallCollision()

    function love.keypressed(key)
        musicas.mover:play()

        if key == "space" then
            if bloco.y ~= 128 then
                geraBloco()
            end
        end

        if key == "up" then
            bloco.y = bloco.y - bloco.height
            if blocoCollision() then
                bloco.y = bloco.y + bloco.height
            end
        elseif key == 'down' then
            bloco.y = bloco.y + bloco.height
            if blocoCollision() then
                bloco.y = bloco.y - bloco.height
            end
        end

        if key == "left" then
            bloco.x = bloco.x - bloco.width
            if blocoCollision() then
                bloco.x = bloco.x + bloco.width
            end
        elseif key == 'right' then
            bloco.x = bloco.x + bloco.width
            if blocoCollision() then
                bloco.x = bloco.x - bloco.width
            end
        end
    end
end

function love.draw()
    love.graphics.draw(fundos.ilha, 0, 0)
    love.graphics.print(pontos.text, 130, 84)
    love.graphics.draw(bloco.sprite, quad, bloco.x, bloco.y)

    for i, bl in ipairs(linhas) do
        love.graphics.draw(bl.sprite, bl.quad, bl.x, bl.y)
    end
end
