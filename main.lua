local points = {}
local isRunning = false
local theme = 'menu'
local Background = require('Obj.Background')
local Music = require('Obj.Music')
local Block = require('Obj.Block')
local Lines = require('Obj.Lines')
local Menu = require('Obj.Menu')
local run = 0
local debug = false
local jsonm = require('Obj.json')

function love.load()
    Menu:load()

    Background:load(theme)
    Music:load(theme)

    points.font = love.graphics.newFont(24)
    points.text = Lines.points
    love.graphics.setFont(points.font)

    Block:load(theme)
end

function love.update(dt)
    Menu:update()
    theme = Menu.theme
    isRunning = not Menu.state

    if theme ~= 'menu' and run == 0 then
        Music['menu']:stop()
        Background:load(theme)
        Music:load(theme)
        Block:load(theme)
        run = 1
    end

    if theme == 'menu' and run == 1 then
        Music['space']:stop()
        Music['island']:stop()
        Music['oriental']:stop()
        Music['menu']:play()
        Lines.points = '0000'
        Lines.blocks = {}
        run = 0
    end

    function love.keypressed(key)
        Music:update()
        Block:update(Lines, key)
        Lines:update(Block, key)

        points.text = Lines.points
    end

    if tonumber(Lines.points) > tonumber(Menu.record) then
        local json_record = 'json_record.json'
        local file = io.open(json_record, 'w')
        if file then
            local data = {
                record = Lines.points
            }
            local jsonString = jsonm.encode(data)
            file:write(jsonString)
            file:close()
        end
    end
end

function love.draw()
    if isRunning then
        Background:draw()
        love.graphics.print(points.text, 130, 84)
        Block:draw()
        Lines:draw()
        Menu:drawOptions()

        if debug then
            love.graphics.print('-------------', 200, 10)
            love.graphics.print(Menu.theme, 200, 30)
        end

        if Lines.msg then
            love.graphics.print("VOCÊ PERDEU! APERTE r.", 10, 290)
        end
    else
        Menu:draw()
    end
end
