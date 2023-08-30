local Music = {}

function  Music:load(theme)
    self['island'] = love.audio.newSource("asset/songs/coconut-island.mp3", 'stream')
    self['oriental'] = love.audio.newSource("asset/songs/oriental-adventure.mp3", 'stream')
    self['space'] = love.audio.newSource("asset/songs/space-blocs.mp3", 'stream')
    self.mover = love.audio.newSource("asset/songs/move-bloc.mp3", 'stream')

    self[theme]:setLooping(true)
    self[theme]:play()
end

function Music:update()
    self.mover:play()
end


return Music