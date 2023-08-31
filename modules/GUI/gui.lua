local GUI = {}
local Button = {}
function Button:create(x, y, width, height, text, fn)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.text = text
    self.hovered = false
    self.fn = fn

    return self
end

function Button:isHovered(x, y)
    return x >= self.x and x <= self.x + self.width and
        y >= self.y and y <= self.y + self.height
end

function GUI:init()
    self.buttons = {}
end

function GUI:newButton(x, y, width, height, text, fn)
    table.insert(self.buttons, Button:create(x, y, width, height, text, fn))
end

function GUI:update()
    local mouseX, mouseY = love.mouse.getPosition()

    for i, btn in ipairs(self.buttons) do
        btn.hovered = btn:isHovered(mouseX, mouseY)

        if btn.hovered and love.mouse.isDown(1) then
            btn.fn()
        end
    end
end

function GUI:draw()
    love.graphics.setColor(0.5, 0.5, 0.5)
    for i, button in ipairs(self.buttons) do
        if button.hovered then
            love.graphics.setColor(0.7, 0.7, 0.7)
        end
        love.graphics.rectangle("fill", button.x, button.y, button.width, button.height)

        love.graphics.setColor(1, 1, 1)
        local font = love.graphics.getFont()
        local textX = button.x + (button.width - font:getWidth(button.text)) / 2
        local textY = button.y + (button.height - font:getHeight()) / 2
        love.graphics.print(button.text, textX, textY)
    end
end

return GUI
