local GUI = {}
local Button = {}
function Button:create(x, y, width, height, text, fn)
    return {
        x = x,
        y = y,
        width = width,
        height = height,
        text = text,
        hovered = false,
        fn = fn
    }
end

function Button:isHovered(mx, my, b)
    return mx >= b.x and mx <= b.x + b.width and
        my >= b.y and my <= b.y + b.height
end

function GUI:init()
    self.buttons = {}
    self.opbuttons = {}
end

function GUI:newButton(x, y, width, height, text, fn)
    table.insert(self.buttons, Button:create(x, y, width, height, text, fn))
end
function GUI:newOpButton(x, y, width, height, text, fn)
    table.insert(self.opbuttons, Button:create(x, y, width, height, text, fn))
end

function GUI:update()
    local mouseX, mouseY = love.mouse.getPosition()

    for i, btn in ipairs(self.buttons) do
        self.buttons[i].hovered = Button:isHovered(mouseX, mouseY, btn)

        if self.buttons[i].hovered and love.mouse.isDown(1) then
            self.buttons[i].fn()
        end
    end
    for i, btn in ipairs(self.opbuttons) do
        self.opbuttons[i].hovered = Button:isHovered(mouseX, mouseY, btn)

        if self.opbuttons[i].hovered and love.mouse.isDown(1) then
            self.opbuttons[i].fn()
        end
    end
end

function GUI:draw()
    for i, button in ipairs(self.buttons) do
        love.graphics.setColor(1.0, 1.0, 1.0, 0.1)
        if button.hovered then
            love.graphics.setColor(0.2, 0.2, 0.2, 0.2)
        end
        love.graphics.rectangle("fill", button.x, button.y, button.width, button.height)

        love.graphics.setColor(1, 1, 1)
        local font = love.graphics.getFont()
        local textX = button.x + (button.width - font:getWidth(button.text)) / 2
        local textY = button.y + (button.height - font:getHeight()) / 2
        love.graphics.print(button.text, textX, textY)
    end
end

function GUI:drawOptions()
    for i, button in ipairs(self.opbuttons) do
        love.graphics.setColor(1.0, 1.0, 1.0, 0.1)
        if button.hovered then
            love.graphics.setColor(0.2, 0.2, 0.2, 0.2)
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
