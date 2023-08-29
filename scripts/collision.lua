local collision = {
    wall = function(block)
        if block.x < 0 then
            block.x = 0
        end
        if (block.x + block.width) > 320 then
            block.x = block.x - block.width
        end

        if block.y < block.height * 2 then
            block.y = block.height * 2
        end
        if (block.y + block.height) > (640 - block.height) then
            block.y = 640 - block.height * 2
        end
    end,

    blocks = function(block, lines)
        for i, bl in ipairs(lines) do
            if block.x == bl.x and block.y == bl.y then
                return true
            end
        end
        return false
    end
}

return collision
