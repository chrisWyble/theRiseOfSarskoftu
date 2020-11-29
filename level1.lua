local composer = require("composer")
local physics = require('physics')
local platform = require('platform')
local player = require('player')
local scene = composer.newScene()

---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------

-- local forward references should go here

---------------------------------------------------------------------------------

-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view
    stageGroup = display.newGroup()

    squaureSize = math.sqrt(display.contentWidth*display.contentHeight)/10
    local pauseBtn = display.newRect(display.contentWidth, 10, squaureSize, squaureSize)
    
    physics.start()

    local floor = platform:new({x=display.contentCenterX, y=display.actualContentHeight, w=display.actualContentWidth, h=20})
    local land = platform:new({x=100, y=150, w=50, h=5})
    local land = platform:new({x=180, y=100, w=50, h=5})
    local land = platform:new({x=110, y=40, w=50, h=5})

    sceneGroup:insert(pauseBtn)
    
    stageGroup:insert(floor.shape)
    stageGroup:insert(land.shape)
 
    sceneGroup:insert(stageGroup)

    function myTap( event ) 
        composer.gotoScene("levelSelect")
    end

    pauseBtn:addEventListener( "tap", myTap )

end

-- "scene:show()"
function scene:show( event )

local sceneGroup = self.view
local phase = event.phase

if ( phase == "will" ) then
    -- Called when the scene is still off screen (but is about to come on screen).
elseif ( phase == "did" ) then
    guy = player:new({x=10, y=160})

    -- Called when the scene is now on screen.
    -- Insert code here to make the scene come alive.
    -- Example: start timers, begin animation, play audio, etc.
end
end

-- "scene:hide()"
function scene:hide( event )

local sceneGroup = self.view
local phase = event.phase

if ( phase == "will" ) then
    -- Called when the scene is on screen (but is about to go off screen).
    -- Insert code here to "pause" the scene.
    -- Example: stop timers, stop animation, stop audio, etc.
elseif ( phase == "did" ) then
    -- Called immediately after scene goes off screen.
end
end

-- "scene:destroy()"
function scene:destroy( event )

local sceneGroup = self.view

-- Called prior to the removal of scene's view ("sceneGroup").
-- Insert code here to clean up the scene.
-- Example: remove display objects, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene