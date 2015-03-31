------------------------------------------------------------
-- Universidad Tecnológica de San Juan del Río
-- Saúl Acatzin López Roque
-- 31/Marzo/2015
------------------------------------------------------------
--Juego "COPETENCIAS"

local fisica = require "physics"
fisica.start()

local storyboard = require ("storyboard")
local scene = storyboard.newScene()
local sonidofondo = audio.loadSound ("sonidofondo.mp3")
local sfin = audio.loadSound ("gameover.mp3")

--Se crea el evento
function scene:createScene(event)
	--Se insertan las imagenes a la pantalla con sus respectivos movimientos
	local screenGroup = self.view
	audio.play(sonidofondo)
    fondocarrera1 = display.newImageRect("fondocarrera.png" , 850, 477)
    fondocarrera1.x = 400
    fondocarrera1.y = 240
    fondocarrera1.speed = 1
    screenGroup:insert(fondocarrera1)

    fondocarrera2 = display.newImageRect("fondocarrera.png" , 850, 477)
    fondocarrera2.x = 1250
    fondocarrera2.y = 240
    fondocarrera2.speed = 1
    screenGroup:insert(fondocarrera2)
	
	
	puntaje1 = display.newImageRect( "puntaje1.png", 400, 300 )
	puntaje1.x = 750
	puntaje1.y = 38
	fisica.addBody(puntaje1, "static")
	screenGroup:insert(puntaje1)
	
	puntaje2 = display.newImageRect( "puntaje2.png", 450, 300 )
	puntaje2.x = 570
	puntaje2.y = 70
	fisica.addBody(puntaje2, "static")
	screenGroup:insert(puntaje2)
	
	pausa = display.newImageRect( "pausa.png", 400, 300 )
	pausa.x = 1
	pausa.y = 38
	fisica.addBody(pausa, "static")
	screenGroup:insert(pausa)
	
	obstaculo1 = display.newImageRect( "obstaculo1.png", 400, 300  )
	obstaculo1.x = 250
	obstaculo1.y = 420
	fisica.addBody(obstaculo1, "static")
	screenGroup:insert(obstaculo1)
	
	obstaculo3 = display.newImageRect( "obstaculo3.png", 400, 300  )
    obstaculo3.x = 700
    obstaculo3.y = 420
	fisica.addBody(obstaculo3, "static")
	screenGroup:insert(obstaculo3)
	
	
    
end
---------------------------------------
--Funcion para mover ciudad
function moverCiudad(self,event)
	if self.x < -400 then
		self.x = 800
	else
	self.x = self.x - self.speed
	end
end

--evento que recibe el toque de la pantalla


function gameOver()
   storyboard.gotoScene("gameover", "fade", 400)
end

----------------------------------------


--Todos los eventos que tenemos en pantalla
function scene:enterScene(event)

	storyboard.purgeScene("start")
	storyboard.purgeScene("restart")

	--Runtime:addEventListener("touch", touchScreen)

	fondocarrera1.enterFrame = moverCiudad
    Runtime:addEventListener("enterFrame", fondocarrera1)

    fondocarrera2.enterFrame = moverCiudad
    Runtime:addEventListener("enterFrame", fondocarrera2)


end

-- Eliminar todos los eventos
function scene:exitScene(event)

	Runtime:removeEventListener("touch", touchScreen)
	Runtime:removeEventListener("enterFrame", fondocarrera1)
	Runtime:removeEventListener("enterFrame", fondocarrera2)

end

--funcion de destruccion de la pantalla
function scene:destroyScene(event)

end

--añadimos todos los eventos
scene:addEventListener("createScene", scene)
scene:addEventListener("enterScene", scene)
scene:addEventListener("exitScene", scene)
scene:addEventListener("destroyScene", scene)

return scene