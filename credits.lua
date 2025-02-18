local composer = require( "composer" )
local scene = composer.newScene()
local musicTrack

---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------

-- local forward references should go here

---------------------------------------------------------------------------------

-- "scene:create()"
function scene:create( event )

local sceneGroup = self.view

    finalScreen = display.newRect(0,0,2*display.contentWidth+60,display.contentWidth+125)
    finalScreen:setFillColor(0,0,0) -- Completly dark
    text = display.newText("YOU WIN", 150, 100, native.systemFont, 40)
    text:setFillColor(1,1,1)

-- Initialize the scene here.
-- Example: add display objects to "sceneGroup", add touch listeners, etc.
	musicTrack = audio.loadStream("Credits.mp3")
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
	audio.play(musicTrack, {channel = 1, loops=-1})
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
	audio.stop(1)
end
end

-- "scene:destroy()"
function scene:destroy( event )

local sceneGroup = self.view

-- Called prior to the removal of scene's view ("sceneGroup").
-- Insert code here to clean up the scene.
-- Example: remove display objects, save state, etc.
	audio.dispose(musicTrack)
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene