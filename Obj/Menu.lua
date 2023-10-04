local Menu = {}
local GUI = require('modules.GUI.gui')

function Menu:load()
    self.state = true
    self.btnW = 195
    self.btnH = 63
    self.theme = 'menu'
    self.background = love.graphics.newImage("asset/sprites/backmenu.png")
    self.btnBack = love.graphics.newImage('asset/sprites/btn-back.png')

    GUI:init()
    GUI:newButton(63, 195, self.btnW, self.btnH, '', function()
        self.theme = 'oriental'
        Menu.state = false
    end)

    GUI:newButton(63, 315, self.btnW, self.btnH, '', function()
        self.theme = 'island'
        Menu.state = false
    end)

    GUI:newButton(63, 435, self.btnW, self.btnH, '', function()
        self.theme = 'space'
        Menu.state = false
    end)

    GUI:newOpButton(10, 10, 32, 32, '', function()
        self.theme = 'menu'
        Menu.state = true
    end)
end

function Menu:update()
    GUI:update()
end

function Menu:setTheme(theme)
    self.theme = theme
end

function Menu:draw()
    love.graphics.draw(self.background, 0, 0)
    love.graphics.print('000000', 118, 100)
    GUI:draw()
end

function Menu:drawOptions()
    love.graphics.draw(self.btnBack, 10, 10)
    GUI:drawOptions()
end

return Menu
