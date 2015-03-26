------------------------------------------------------------
-- Universidad Tecnológica de San Juan del Río
-- Saúl Acatzin López Roque
-- 24/Marzo/2015
------------------------------------------------------------
--Juego "COPETENCIAS"

local storyboard = require ("storyboard")
local scene = storyboard.newScene()
local sonido = audio.loadSound("sonidoinicio.mp3")

--Se insertan las imagenes a la pantalla con sus respectivos movimientos
function scene:createScene(event)
	local screenGroup = self.view
	
	fondocarrera = display.newImageRect( "carrerafondo.png", 850, 477 )
	fondocarrera.x = 300
	fondocarrera.y = 240
	screenGroup:insert(fondocarrera)

	epnover = display.newImageRect( "epnover.png", 400, 300 )
	epnover.x = 460
	epnover.y = 320
	screenGroup:insert(epnover)

	gameover = display.newImageRect( "gameover.png", 500, 400  )
	gameover.x = 180
	gameover.y = 180
	screenGroup:insert(gameover)

	textoover = display.newImageRect( "txtepn.png", 500, 375 )
	textoover.x = 600
	textoover.y = 100
	audio.play(textoover)
end

function start(event)
	if event.phase == "began" then
	 storyboard.gotoScene("game", "fade", 400)
	end
end

function scene:enterScene(event)
	fondoi:addEventListener("touch", start)
end

function scene:exitScene(event)
	fondoi:removeEventListener("touch", start)
end

function scene:destroyScene(event)

end

scene:addEventListener("createScene", scene)
scene:addEventListener("enterScene", scene)
scene:addEventListener("exitScene", scene)
scene:addEventListener("destroyScene", scene)

return scene