local composer = require("composer")
local physics = require('physics')
local platform = require('platform')
local player = require('player')
local enemy = require('enemy')
local score = require( "score" )
local playerHealth = require('playerHealth')
local musicTrack
nextLevel = "level3"

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
    scoring_group = display.newGroup()
    entity_group = display.newGroup()
    platforms_group = display.newGroup()

    physics.start()

    --[[ local scoreText = score.init(
{
    fontSize = 10,
    --font = "CoolCustomFont.ttf",
    x = 20,
    y = 5,
    maxDigits = 4,
    leadingZeros = true
})
    scoring_group:insert(scoreText) 


    local playerHealthText = playerHealth.init(
{
    fontSize = 10,
    --font = "CoolCustomFont.ttf",
    x = 200,
    y = 5,
    maxDigits = 1,
    leadingZeros = true
})
    scoring_group:insert(playerHealthText)
]]

	musicTrack = audio.loadStream("Background.mp3")
    
end

-- "scene:show()"
function scene:show( event )

local sceneGroup = self.view
local phase = event.phase

if ( phase == "will" ) then
    local background = display.newImage('vein_background.png')
    background:toBack()
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    sceneGroup:insert(background)
    
    local menuBtn = display.newImage('virus_button.png')
    menuBtn:scale(0.05, 0.05)
    menuBtn.x = display.contentWidth - 10
    menuBtn.y = 20
    sceneGroup:insert(menuBtn)
    function myTap( event ) 
        composer.gotoScene("levelSelect")
    end
    menuBtn:addEventListener( "tap", myTap )

    local floor = platform:new({x=display.contentCenterX, y=display.actualContentHeight, w=display.actualContentWidth, h=20})
    local land1 = platform:new({x=150, y=135, w=180, h=5})
    local land2 = platform:new({x=150, y=165, w=5, h=60})
    local land3 = platform:new({x=50, y=70, w=80, h=5})
    
    platforms_group:insert(floor.shape)
    platforms_group:insert(land1.shape)
    platforms_group:insert(land2.shape)
    platforms_group:insert(land3.shape)

    sceneGroup:insert(platforms_group)
    
    -- Called when the scene is still off screen (but is about to come on screen).
elseif ( phase == "did" ) then
    
    guy = player:new({x=10, y=160})
    entity_group:insert(guy.shape)

    badGuy1 = enemy:new({x=100,y=120,w=20,h=20,health=4}) 
    entity_group:insert(badGuy1.shape)
    
    badGuy2 = enemy:new({x=260,y=150,w=20,h=30,health=4}) 
    entity_group:insert(badGuy2.shape)

    badGuy3 = enemy:new({x=60,y=30,w=20,h=30,health=4}) 
    entity_group:insert(badGuy3.shape)
	
	audio.play(musicTrack, {channel=1, loops=-1})
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
    
    for i = platforms_group.numChildren, 1, -1 do 
        child = platforms_group[i]
        child.pp:delete()
    end
    for i = entity_group.numChildren, 1, -1 do 
        child = entity_group[i]
        child.pp:delete()
    end

elseif ( phase == "did" ) then

    platforms_group = display.newGroup()
    sceneGroup = display.newGroup()
	audio.stop( 1 )
    print('done')
    -- Called immediately after scene goes off screen.
end
end

-- "scene:destroy()"
function scene:destroy( event )

local sceneGroup = self.view

sceneGroup:removeSelf()
sceneGroup = nil
audio.dispose( musicTrack )
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