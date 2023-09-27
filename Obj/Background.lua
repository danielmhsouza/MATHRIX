local Background = {}
Background.backgrounds = {}

function Background:load(theme)
    self.backgrounds['island'] = love.graphics.newImage("asset/sprites/backisland.png")
    self.backgrounds['oriental'] = love.graphics.newImage("asset/sprites/backoriental.png")
    self.backgrounds['space'] = love.graphics.newImage("asset/sprites/backspace.png")
    self.theme = theme
end

function Background:draw()
    love.graphics.draw(self.backgrounds[self.theme], 0, 0)
end

return Background