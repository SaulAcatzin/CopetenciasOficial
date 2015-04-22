------------------------------------------------------------
-- Universidad Tecnológica de San Juan del Río
-- Saúl Acatzin López Roque
-- 20/Abril/2015
------------------------------------------------------------
--Juego "COPETENCIAS"
local sprite = require "sprite"
local fisica = require "physics"
fisica.start()
local baseline = 280
local storyboard = require ("storyboard")
local scene = storyboard.newScene()
local sonidofondo = audio.loadSound ("sonidofondo.mp3")
local sfin = audio.loadSound ("gameover.mp3")
local backgroundSpeed = 4
local mydata = require( "mydata" )
mydata.score = 0
--fisica.setDrawMode("hybrid")

--Se crea el evento
function scene:createScene(event)
	--Se insertan las imagenes a la pantalla con sus respectivos movimientos
	local screenGroup = self.view
	
	audio.play(sonidofondo)
    fondocarrera1 = display.newImageRect("fondocarrera.png" , 850, 477)
    fondocarrera1.x = 400
    fondocarrera1.y = 240
    fondocarrera1.speed = backgroundSpeed
    screenGroup:insert(fondocarrera1)

    fondocarrera2 = display.newImageRect("fondocarrera.png" , 850, 477)
    fondocarrera2.x = 1250
    fondocarrera2.y = 240
    fondocarrera2.speed = backgroundSpeed
    screenGroup:insert(fondocarrera2)
	
	elements = display.newGroup()
	elements.anchorChildren = true
	elements.anchorX = 0
	elements.anchorY = 1
	elements.x = 0
	elements.y = 0
	screenGroup:insert(elements)
	
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
	
	suelo = display.newRect(display.contentWidth/2, display.contentHeight, display.contentWidth , 1)
	fisica.addBody(suelo, "static")
	screenGroup:insert(suelo)
	
	sheet2 = sprite.newSpriteSheet( "greenman.png", 128, 128 )
	spriteSet2 = sprite.newSpriteSet(sheet2, 1, 15)
	sprite.add( spriteSet2, "man", 1, 15, 500, 0 ) 
	instance2 = sprite.newSprite( spriteSet2 )
	instance2.x = 1 * display.contentWidth / 4 + 10
	instance2.y = baseline + 120
	instance2.x = baseline - 250
	instance2:prepare("man")
	fisica.addBody(instance2, "static", {density=.1, bounce=0.1, friction=1})
	instance2:applyForce(0, -300, instance2.x, instance2.y)
	instance2:play()
	screenGroup:insert(instance2)
	
	scoreText = display.newText(mydata.score,display.contentCenterX,
	150, "pixelmix", 58)
	scoreText:setFillColor(0,0,0)
	scoreText.alpha = 0
	screenGroup:insert(scoreText)
	
	audio.play(sonidofondo)
	
end
---------------------------------------------------------------------------------
function onCollision( event )
print("on collision...")
	if (event.object1 ~= suelo and event.phase == "began") then
		print("Game over")
		storyboard.gotoScene ("gameOver")
	end
	--if ( event.phase == "began" ) then
		--storyboard.gotoScene( "gameOver" )	
	--end
end
-----------------------------------------------------------------------------
local gameStarted = false

function correr(event) 
if event.phase == "began" then
	instance2:applyForce(0,-300,instance2.x,instance2.y)
	 if gameStarted == false then
		 instance2.bodyType="dynamic"
		 scoreText.alpha = 1
		 gameStarted = true
		
	 else
		
	 end
	 
	 end

end
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
function moveObstaculos()
--Velocidad a la que se mueve
		for a = elements.numChildren,1,-1  do
			if(elements[a].x < display.contentCenterX - 170) then
				if elements[a].scoreAdded == false then
					mydata.score = mydata.score + 1
					scoreText.text = mydata.score
					elements[a].scoreAdded = true
				end
			end
			if(elements[a].x > -100) then
				elements[a].x = elements[a].x - 5
			else 
				elements:remove(elements[a])
			end	
		end
end
-----------------------------------------------------------------------------
local obstacleNames= {
 "carmen.png",
 "brozo.png",
 "gasolina.png",
 "paulina.png",
 "pau.png",
 "reportero.png"
 }

function addobstaculos()
	index = math.random(1,6)
	print(index)
	obstaculo1 = display.newImageRect( obstacleNames[index], 400, 300 )
	if (obstaculo1 == nill) then
		return
	end
	obstaculo1.anchorX = .5
	obstaculo1.anchorY = 1
	fisica.addBody(obstaculo1, "static", {density=1, bounce=0.1, friction=.2, radius=87})
	obstaculo1.x = display.contentWidth 
	obstaculo1.y = display.contentHeight +79
	elements:insert(obstaculo1)
	
end
-------------------------------------------------------------------------------
 


------------------------------------------------------------------------------
--Funcion para mover ciudad

function moverCiudad(self,event)
	if self.x < -400 then
		self.x = 800
	else
	self.x = self.x - self.speed
	end
end

--evento que recibe el toque de la pantalla

----------------------------------------

--Todos los eventos que tenemos en pantalla
function scene:enterScene(event)
	print ("prueba")
		instance2.bodyType="dynamic"
		addObstaculoTimer=timer.performWithDelay(7000, addobstaculos, -1)
		--Velocidad a la que se insertan
		moveObstaculoTimer=timer.performWithDelay(60, moveObstaculos, -1)
	
	Runtime:addEventListener("touch", correr)
	
	fondocarrera1.enterFrame = moverCiudad
    Runtime:addEventListener("enterFrame", fondocarrera1)

    fondocarrera2.enterFrame = moverCiudad
    Runtime:addEventListener("enterFrame", fondocarrera2)
	
	Runtime:addEventListener("collision", onCollision)


end

-- Eliminar todos los eventos
function scene:exitScene(event)
	
	Runtime:removeEventListener("touch", correr)
	Runtime:removeEventListener("touch", touchScreen)
	Runtime:removeEventListener("enterFrame", fondocarrera1)
	Runtime:removeEventListener("enterFrame", fondocarrera2)
	Runtime:removeEventListener("collision", onCollision)
	timer.cancel(addObstaculoTimer)
	timer.cancel(moveObstaculoTimer)

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