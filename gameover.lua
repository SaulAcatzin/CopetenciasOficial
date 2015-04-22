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

-- function showStart()
	-- startTransition = transition.to(restart,{time=200, alpha=1})
	-- scoreTextTransition = transition.to(scoreText,{time=600, alpha=1})
	-- scoreTextTransition = transition.to(bestText,{time=600, alpha=1})
-- end

-- function showScore()
	-- scoreTransition = transition.to(scoreBg,{time=600, y=display.contentCenterY,onComplete=showStart})
	
-- end

-- function showGameOver()
	-- fadeTransition = transition.to(gameOver,{time=600, alpha=1,onComplete=showScore})
-- end

-- function loadScore()
	-- local prevScore = score.load()
	-- if prevScore ~= nil then
		-- if prevScore <= mydata.score then
			-- score.set(mydata.score)
		-- else 
			-- score.set(prevScore)	
		-- end
	-- else 
		-- score.set(mydata.score)	
		-- score.save()
	-- end
-- end

-- function saveScore()
	-- score.save()
-- end

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
	
	-- scoreBg = display.newImageRect("menuBg.png",480,393)
	-- scoreBg.anchorX = 0.5
	-- scoreBg.anchorY = 0.5
    -- scoreBg.x = display.contentCenterX
    -- scoreBg.y = display.contentHeight + 500
    -- screenGroup:insert(scoreBg)
	
	-- restart = display.newImageRect("start_btn.png",300,65)
	-- restart.anchorX = 0.5
	-- restart.anchorY = 1
	-- restart.x = display.contentCenterX
	-- restart.y = display.contentCenterY + 400
	-- restart.alpha = 0
	-- screenGroup:insert(restart)
	
	-- scoreText = display.newText(mydata.score,display.contentCenterX + 110,
	-- display.contentCenterY - 60, native.systemFont, 50)
	-- scoreText:setFillColor(0,0,0)
	-- scoreText.alpha = 0 
	-- screenGroup:insert(scoreText)
		
	-- bestText = score.init({
	-- fontSize = 50,
	-- font = "Helvetica",
	-- x = display.contentCenterX + 70,
	-- y = display.contentCenterY + 85,
	-- maxDigits = 7,
	-- leadingZeros = false,
	-- filename = "scorefile.txt",
	-- })
	-- bestScore = score.get()
	-- bestText.text = bestScore
	-- bestText.alpha = 0
	-- bestText:setFillColor(0,0,0)
	-- screenGroup:insert(bestText)
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
	--showGameOver()
	--loadScore()
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