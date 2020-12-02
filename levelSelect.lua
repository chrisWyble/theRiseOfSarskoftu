local composer = require( "composer" )
local widget = require("widget")
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

    local background = display.newImage('virus_background.png')
    background:toBack()
    background:scale(0.3,0.3)
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    sceneGroup:insert(background)

    local selectGroup = display.newGroup()

    sceneGroup:insert(selectGroup)

    function goToLevel(event)
        composer.gotoScene("level"..event.target.num)
    end

    squaureSize = math.sqrt(display.contentWidth*display.contentHeight)/5
    deltax = display.contentWidth/4
    startx = 0 + deltax/2
    starty = display.contentHeight/2

    for i=0, 3 do 
        box = display.newRect(startx + deltax*i, starty, squaureSize, squaureSize)
        box:setFillColor( 0.3, 0.2, 0.25)
        box.strokeWidth = 3
        box:setStrokeColor(0.1,0.1,0.1)
        box.num = i+1
        selectGroup:insert(box)
        text = display.newText(tostring(i+1), box.x, box.y, native.systemFont, 60)
        text:setFillColor(1,1,1)
        selectGroup:insert(text)
        box: addEventListener( "tap", goToLevel )
    end

end


-- "scene:show()"
function scene:show( event )

local sceneGroup = self.view
local phase = event.phase

if ( phase == "will" ) then
    -- Called when the scene is still off screen (but is about to come on screen).
elseif ( phase == "did" ) then
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