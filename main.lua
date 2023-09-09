local points = {}
local isRunning = false
local theme = 'menu'
local Background = require('Obj.Background')
local Music = require('Obj.Music')
local Block = require('Obj.Block')
local Lines = require('Obj.Lines')
local Menu = require('Obj.Menu')
local run = 0

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
    if theme ~= 'menu' and run == 0 then
        Music['menu']:stop()
        Background:load(theme)
        Music:load(theme)
        Block:load(theme)
        run = 1
    end
    isRunning = not Menu.state
    function love.keypressed(key)
        Music:update()
        Block:update(Lines, key)
        Lines:update(Block, key)

        points.text = Lines.points
    end
end

function love.draw()
    if isRunning then
        Background:draw()
        love.graphics.print(points.text, 130, 84)
        Block:draw()
        Lines:draw()
    else
        Menu:draw()
    end
end
