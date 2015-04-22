------------------------------------------------------------
-- Universidad Tecnológica de San Juan del Río
-- Saúl Acatzin López Roque
-- 20/Abril/2015
------------------------------------------------------------
--Juego "COPETENCIAS"

local storyboard = require ("storyboard")
local scene = storyboard.newScene()
local sonido = audio.loadSound("sonidoinicio.mp3")
local mydata = require( "mydata" )

function showStart()
	startTransition = transition.to(restart,{time=200, alpha=1})
	scoreTextTransition = transition.to(scoreText,{time=600, alpha=1})
	scoreTextTransition = transition.to(bestText,{time=600, alpha=1})
end

function showScore()
	scoreTransition = transition.to(scoreBg,{time=600, y=display.contentCenterY,onComplete=showStart})
	
end

function showGameOver()
	fadeTransition = transition.to(gameOver,{time=600, alpha=1,onComplete=showScore})
end

function loadScore()
	local prevScore = score.load()
	if prevScore ~= nil then
		if prevScore <= mydata.score then
			score.set(mydata.score)
		else 
			score.set(prevScore)	
		end
	else 
		score.set(mydata.score)	
		score.save()
	end
end

function saveScore()
	score.save()
end

--Se insertan las imagenes a la pantalla con sus respectivos movimientos
function scene:createScene(event)
	local screenGroup = self.view
	
	fondocarrera = display.newImageRect( "fondocarrera.png", 1050, 477 )
	fondocarrera.x = 300
	fondocarrera.y = 240
	screenGroup:insert(fondocarrera)

	epnover = display.newImageRect( "epnover.png", 400, 300 )
	epnover.x = 530
	epnover.y = 320
	screenGroup:insert(epnover)

	gameover = display.newImageRect( "gameover.png", 500, 400  )
	gameover.x = 180
	gameover.y = 180
	screenGroup:insert(gameover)

	textoover = display.newImageRect( "txtepn.png", 500, 375 )
	textoover.x = 700
	textoover.y = 100
	screenGroup:insert(textoover)
	audio.play(textoover)
end

function restartGame(event)
     if event.phase == "ended" then
	 
		storyboard.gotoScene("juego")
     end
end

function start(event)
	fondocarrera:addEventListener("touch", restartGame)
end

function scene:enterScene(event)
	storyboard.removeScene("game")
	fondocarrera:addEventListener("touch", restartGame)
	showGameOver()
	loadScore()
end

function scene:exitScene(event)
	fondocarrera:removeEventListener("touch", restartGame)
	transition.cancel(fadeTransition)
	transition.cancel(scoreTransition)
	transition.cancel(scoreTextTransition)
	transition.cancel(startTransition)
end

function scene:destroyScene(event)

end

scene:addEventListener("createScene", scene)
scene:addEventListener("enterScene", scene)
scene:addEventListener("exitScene", scene)
scene:addEventListener("destroyScene", scene)

return scene