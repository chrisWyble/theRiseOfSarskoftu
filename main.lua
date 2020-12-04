local composer = require("composer")
_G.numEnemies = 0
_G.nextLevel = " "

display.setStatusBar(display.HiddenStatusBar)

audio.reserveChannels(1)
audio.setVolume(0.5, { channel=1})

composer.gotoScene("levelSelect")

local options = {
	effect = "fade",
	time = 200
}

local function update()
	if numEnemies == 0 then
		composer.gotoScene(nextLevel, options)
	end
end

timer.performWithDelay(1500, update, 0)


