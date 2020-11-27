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

-- Initialize the scene here.
-- Example: add display objects to "sceneGroup", add touch listeners, etc.

local selectGroup = display.newGroup()

local levelOneText = display.newText("1", 160, 280, native.systemFont, 60)
local levelTwoText = display.newText("2", 660, 280, native.systemFont, 60)
local levelThreeText = display.newText("3", 160, 980, native.systemFont, 60)
local levelFourText = display.newText("4", 660, 980, native.systemFont, 60)

levelOneText:setFillColor( 1, 0, 0 )
levelTwoText:setFillColor( 1, 0, 0 )
levelThreeText:setFillColor( 1, 0, 0 )
levelFourText:setFillColor( 1, 0, 0 )


local myBox1 = display.newRect(160, 340, 320, 320)
local myBox2 = display.newRect(645, 340, 320, 320)
local myBox3 = display.newRect(160, 1040, 320, 320)
local myBox4 = display.newRect(645, 1040, 320, 320)

-- We could chunck this code in for loops for less lines
-- I'm just being a little lazy rn

myBox1:setFillColor( 0.2, 1, 1)
myBox2:setFillColor( 0.2, 1, 1)
myBox3:setFillColor( 0.2, 1, 1)
myBox4:setFillColor( 0.2, 1, 1)

selectGroup:insert(myBox1)
selectGroup:insert(myBox2)
selectGroup:insert(myBox3)
selectGroup:insert(myBox4)
selectGroup:insert(levelOneText)
selectGroup:insert(levelTwoText)
selectGroup:insert(levelThreeText)
selectGroup:insert(levelFourText)

sceneGroup:insert(selectGroup)

function goToLevel1( event ) 
    composer.gotoScene("level1")
end

function goToLevel2( event ) 
    composer.gotoScene("level2")
end

function goToLevel3( event ) 
    composer.gotoScene("level3")
end

function goToLevel4( event ) 
    composer.gotoScene("level4")
end

myBox1: addEventListener( "tap", goToLevel1 )
myBox2: addEventListener( "tap", goToLevel2 )
myBox3: addEventListener( "tap", goToLevel3 )
myBox4: addEventListener( "tap", goToLevel4 )

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