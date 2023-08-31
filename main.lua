local points = {}
local isRunning = false
local theme = 'island'
local Background = require('Obj.Background')
local Music = require('Obj.Music')
local Block = require('Obj.Block')
local Lines = require('Obj.Lines')
local Menu = require('Obj.Menu')

function love.load()

    Menu:load()

    Background:load(theme)
    Music:load(theme)

    points.font = love.graphics.newFont(24)
    points.text = "0000"
    love.graphics.setFont(points.font)

    Block:load(theme)
end

function love.update(dt)
    Menu:update()
    isRunning = not Menu.state
    function love.keypressed(key)
        Music:update()
        Block:update(Lines, key)
        Lines:update(Block, key)
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
