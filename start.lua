------------------------------------------------------------
-- Universidad Tecnológica de San Juan del Río
-- Saúl Acatzin López Roque
-- 24/Marzo/2015
-- Clase donde se tienen los botones de inicio opciones y salir
------------------------------------------------------------
--Juego "COPETENCIAS"

local storyboard = require ("storyboard")
local scene = storyboard.newScene()
local sonido = audio.loadSound("sonidoinicio.mp3")

function scene:createScene(event)
	local screenGroup = self.view
	
	fondoi = display.newImageRect( "fondoinicio.png", 850,477 )
	fondoi.x = 400
	fondoi.y = 240
	screenGroup:insert(fondoi)
	
	enriquei = display.newImageRect( "epninicio.png", 650, 450 )
	enriquei.x = 695
	enriquei.y = 250
	screenGroup:insert(enriquei)
	
	audio.play(sonido)
end

function start(event)
	if event.phase == "began" then
	 storyboard.gotoScene("juego", "fade", 400)
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