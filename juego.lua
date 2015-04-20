------------------------------------------------------------
-- Universidad Tecnológica de San Juan del Río
-- Saúl Acatzin López Roque
-- 31/Marzo/2015
------------------------------------------------------------
--Juego "COPETENCIAS"

local storyboard = require ("storyboard")
local scene = storyboard.newScene()
local sonido = audio.loadSound("sonidoinicio.mp3")

--Se insertan las diferentes imagenes(objetos).

function titleTransitionDown()
	downTransition = transition.to(titleGroup,{time=400, y=titleGroup.y+20,onComplete=titleTransitionUp})
	
end

function titleTransitionUp()
	upTransition = transition.to(titleGroup,{time=400, y=titleGroup.y-20, onComplete=titleTransitionDown})
	
end

function titleAnimation()
	titleTransitionDown()
end

function scene:createScene(event)
	local screenGroup = self.view
	
	fondoi = display.newImageRect( "fondoinicio.png", 850,477 )
	fondoi.x = 400
	fondoi.y = 240
	screenGroup:insert(fondoi)
	
	title = display.newImageRect( "epninicio.png", 650, 450 )
	title.anchorX = 0.5
	title.anchorY = 0.5
	title.x = display.contentCenterX - 80
	title.y = display.contentCenterY
	screenGroup:insert(title)
	
--	botonopcionesi = display.newImageRect( "btnopcionesi.png", 600, 500  )
--	botonopcionesi.x = 300
--	botonopcionesi.y = 370
--	screenGroup:insert(botonopcionesi)
	
--	botonsaliri = display.newImageRect( "btnsaliri.png", 700, 575 )
--	botonsaliri.x = 700
--	botonsaliri.y = 180
--	screenGroup:insert(botonsaliri)

	start = display.newImageRect( "btnjugari.png", 500, 475 )
	start.x = 570
	start.y = 250
	screenGroup:insert(start)

	titleGroup = display.newGroup()
	titleGroup.anchorChildren = true
	titleGroup.anchorX = 0.05
	titleGroup.anchorY = 0.5
	titleGroup.x = display.contentCenterX 
	titleGroup.y = display.contentCenterY - 10
	titleGroup:insert(title)
	screenGroup:insert(titleGroup)
	titleAnimation()
	
	--audio.play(sonido)
end
		
function startgame(event)
	if event.phase == "began" then
	 storyboard.gotoScene("game", "fade", 400)
	end
end

function scene:enterScene(event)
	fondoi:addEventListener("touch", startgame)
end

function scene:exitScene(event)
	fondoi:removeEventListener("touch", startgame)
	transition.cancel(downTransition)
	transition.cancel(upTransition)
end

function scene:destroyScene(event)

end

scene:addEventListener("createScene", scene)
scene:addEventListener("enterScene", scene)
scene:addEventListener("exitScene", scene)
scene:addEventListener("destroyScene", scene)

return scene