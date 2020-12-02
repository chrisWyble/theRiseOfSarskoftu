local composer = require("composer")
local physics = require('physics')
local platform = require('platform')
local player = require('player')
local enemy = require('enemy')
local score = require( "score" )
local playerHealth = require('playerHealth')

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
    local land1 = platform:new({x=100, y=135, w=80, h=5})
    local land2 = platform:new({x=215, y=80, w=80, h=5})
    local land3 = platform:new({x=70, y=40, w=70, h=5})
    

    sceneGroup:insert(pauseBtn)
    
    stageGroup:insert(floor.shape)
    stageGroup:insert(land1.shape)
    stageGroup:insert(land2.shape)
    stageGroup:insert(land3.shape)

    sceneGroup:insert(stageGroup)

    function myTap( event ) 
        composer.gotoScene("levelSelect")
    end

    pauseBtn:addEventListener( "tap", myTap )


    local scoreText = score.init(
{
    fontSize = 10,
    --font = "CoolCustomFont.ttf",
    x = 20,
    y = 5,
    maxDigits = 4,
    leadingZeros = true
})
    sceneGroup:insert(scoreText)


    local playerHealthText = playerHealth.init(
{
    fontSize = 10,
    --font = "CoolCustomFont.ttf",
    x = 200,
    y = 5,
    maxDigits = 1,
    leadingZeros = true
})
    sceneGroup:insert(playerHealthText)

    guy = player:new({x=10, y=160})
    sceneGroup:insert(guy.shape)

    badGuy1 = enemy:new({x=100,y=120,w=20,h=20,health=4}) 
    sceneGroup:insert(badGuy1.shape)
    
    badGuy2 = enemy:new({x=200,y=50,w=20,h=30,health=4}) 
    sceneGroup:insert(badGuy2.shape)



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
sceneGroup:removeSelf()
sceneGroup = nil
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