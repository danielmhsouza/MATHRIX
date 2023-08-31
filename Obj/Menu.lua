local Menu = {}
local GUI = require('modules.GUI.gui')

function Menu:load()
    self.state = true
    self.btns = {}
    self.btnW = 200
    self.btnH = 60

    GUI:init()
    GUI:newButton(100, 50, 100, 64, 'Start', function ()
        Menu.state = false
    end)
end

function Menu:update()
    GUI:update()
end

function Menu:draw()
    GUI:draw()
end

return Menu
