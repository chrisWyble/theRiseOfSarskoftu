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

squaureSize = math.sqrt(display.contentWidth*display.contentHeight)/5
deltax = display.contentWidth/4
startx = 0 + deltax/2
starty = display.contentHeight/2

local myBox1 = display.newRect(startx, starty, squaureSize, squaureSize)
local myBox2 = display.newRect(startx + deltax, starty, squaureSize, squaureSize)
local myBox3 = display.newRect(startx + deltax*2, starty, squaureSize, squaureSize)
local myBox4 = display.newRect(startx + deltax*3, starty, squaureSize, squaureSize)

myBox1:setFillColor( 0.2, 1, 1)
myBox2:setFillColor( 0.2, 1, 1)
myBox3:setFillColor( 0.2, 1, 1)
myBox4:setFillColor( 0.2, 1, 1)

myBox1.strokeWidth = 3
myBox2.strokeWidth = 3
myBox3.strokeWidth = 3
myBox4.strokeWidth = 3

myBox1:setStrokeColor(0.5,0.5,1)
myBox2:setStrokeColor(0.5,0.5,1)
myBox3:setStrokeColor(0.5,0.5,1)
myBox4:setStrokeColor(0.5,0.5,1)

selectGroup:insert(myBox1)
selectGroup:insert(myBox2)
selectGroup:insert(myBox3)
selectGroup:insert(myBox4)

local levelOneText = display.newText("1", myBox1.x, myBox1.y, native.systemFont, 60)
local levelTwoText = display.newText("2", myBox2.x, myBox2.y, native.systemFont, 60)
local levelThreeText = display.newText("3", myBox3.x, myBox3.y, native.systemFont, 60)
local levelFourText = display.newText("4", myBox4.x, myBox4.y, native.systemFont, 60)

levelOneText:setFillColor( 0.2, 0.5, 1 )
levelTwoText:setFillColor( 0.2, 0.5, 1 )
levelThreeText:setFillColor( 0.2, 0.5, 1)
levelFourText:setFillColor( 0.2, 0.5, 1 )

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