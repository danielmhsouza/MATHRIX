local Menu = {}
local GUI = require('modules.GUI.gui')
local json = require('Obj.json')

function Menu:load()
    self.state = true
    self.btnW = 195
    self.btnH = 63
    self.theme = 'menu'
    self.record = '00000'
    self.table = ''
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

function Menu:loadRecord()
    local json_record = 'json_record.json'

    local file = io.open(json_record, 'r')

    if file then
        local jsonString = file:read('*all')
        file:close()

        self.table = json.decode(jsonString)
        self.record = self.table.record
    else
        file = io.open(json_record, 'w')
        if file then
            local data = {
                record = 0000
            }
            local jsonString = json.encode(data)
            file:write(jsonString)
            file:close()
        end
    end
end

function Menu:update()
    self:loadRecord()
    GUI:update()
end

function Menu:setTheme(theme)
    self.theme = theme
end

function Menu:draw()
    love.graphics.draw(self.background, 0, 0)
    love.graphics.print(tostring(self.record), 128, 100)
    GUI:draw()
end

function Menu:drawOptions()
    love.graphics.draw(self.btnBack, 10, 10)
    GUI:drawOptions()
end

return Menu
