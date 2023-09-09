local Menu = {}
local GUI = require('modules.GUI.gui')
local Background = require('Obj.Background')

function Menu:load()
    self.state = true
    self.btns = {}
    self.btnW = 200
    self.btnH = 60
    self.theme = 'menu'
    self.background = love.graphics.newImage("asset/sprites/backmenu.png")

    GUI:init()
    GUI:newButton(63, 195, 195, 63, '', function ()
        self.theme = 'oriental'
        Menu.state = false
    end)

    GUI:newButton(63, 315, 195, 63, '', function ()
        self.theme = 'island'
        Menu.state = false
    end)
end

function Menu:update()
    GUI:update()
end

function Menu:draw()
    love.graphics.draw(self.background, 0, 0)
    GUI:draw()
end

return Menu
