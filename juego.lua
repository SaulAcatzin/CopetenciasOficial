------------------------------------------------------------
-- Universidad Tecnológica de San Juan del Río
-- Saúl Acatzin López Roque
-- 31/Marzo/2015
------------------------------------------------------------
--Juego "COPETENCIAS"

local storyboard = require ("storyboard")
local scene = storyboard.newScene()
local sonido = audio.loadSound("sonidoinicio.mp3")

--Se insertan las diferentes imageenes(objetos).
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
	
	botonjugari = display.newImageRect( "btnjugari.png", 500, 475 )
	botonjugari.x = 570
	botonjugari.y = 250
	screenGroup:insert(botonjugari)
	
	botonopcionesi = display.newImageRect( "btnopcionesi.png", 600, 500  )
	botonopcionesi.x = 300
	botonopcionesi.y = 370
	screenGroup:insert(botonopcionesi)
	
	botonsaliri = display.newImageRect( "btnsaliri.png", 700, 575 )
	botonsaliri.x = 700
	botonsaliri.y = 180
	screenGroup:insert(botonsaliri)
	
	audio.play(sonido)
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