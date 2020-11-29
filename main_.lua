physics = require('physics')
platform = require('platform')
player = require('player')
physics.start()

stage = platform:new({x=display.contentWidth/2, y=display.contentHeight, w=display.contentWidth, h=25})

floating = platform:new({x=150, y=40, w=50, h=5})

guy = player:new({x=50, y=30})



