local centerX = display.contentCenterX
local centerY = display.contentCenterY
local _W = display.contentWidth
local _H = display.contentHeight


------------------------------------------------------------------
--LIBRARIES
------------------------------------------------------------------

local storyboard = require("storyboard")
local scene = storyboard.newScene()
 
local mydata = require( "mydata" )
local physics = require("physics")
physics.start()
--physics.setDrawMode( "hybrid" )
physics.setGravity(0,0) 

mydata.score = 0
local player
local bkg
local group
local groupBkg
local timerCont
local normDeltaY
local timeText
local point = 0
local textPoint
local normDeltaX
local velEnemy = 20
local velPlayer = 300
local enemies = {}
local alvo
local alvoDir=0


  local function onLocalCollision( self, event )
     
    if ( event.phase == "began" ) then
      if ( event.other.myName == "player") then --print ( "encostado" )
        --mydata.score = tonumber( timeText.text )
        mydata.score = point
        timeText.text = mydata.score
        timer.cancel(timerMove)
        timer.cancel(timerID)
        timer.cancel(timerLoop)
        enemies = nil
        player:removeEventListener( onLocalCollision , player )
        Runtime:removeEventListener( "touch" , playerTouched )
        --Runtime:removeEventListener(playerTouched , Runtime )
        --Runtime:removeEventListener( "playerTouched", nil )
        storyboard.gotoScene( "restart")

       end
     
       
   
   
    end
    end


    local function hasCollided( obj1, obj2 )
    if ( obj1 == nil ) then  -- Make sure the first object exists
        return false
    end
    if ( obj2 == nil ) then  -- Make sure the other object exists
        return false
    end

    local left = obj1.contentBounds.xMin <= obj2.contentBounds.xMin and obj1.contentBounds.xMax >= obj2.contentBounds.xMin
    local right = obj1.contentBounds.xMin >= obj2.contentBounds.xMin and obj1.contentBounds.xMin <= obj2.contentBounds.xMax
    local up = obj1.contentBounds.yMin <= obj2.contentBounds.yMin and obj1.contentBounds.yMax >= obj2.contentBounds.yMin
    local down = obj1.contentBounds.yMin >= obj2.contentBounds.yMin and obj1.contentBounds.yMin <= obj2.contentBounds.yMax

    return (left or right) and (up or down)
end
 
 
 
 
 
 
------------------------------------------------------------------
--GAME FUNCTIONS
------------------------------------------------------------------


function alvoPos()


if ( alvoDir == 0 ) then -- Vai p direita
 print(alvoDir)
 alvo.x = _W - 35
 alvo.y = math.random(0,_H)
 alvoDir = 1
 return alvoDir
end


if ( alvoDir == 1 ) then -- Vai p esq
print(alvoDir)
 alvo.x = 35
 alvo.y = math.random(0,_H)
alvoDir=0
return alvoDir

end

return alvoDir

end




function playerTouched(event)
--[[ if ( event.phase=="began" or event.phase == "moved" ) then
 -- Tentar isso tambem if(event.phase == "began" or event.phase == "moved") then
 display.getCurrentStage():setFocus(player)
 player:setLinearVelocity(0,0)
 
 elseif event.phase == "ended" then
 
player:applyLinearImpulse(((event.xStart - event.x)/10 *-1) , ((event.yStart - event.y)/10 *-1 ) , player.x , player.y )
 display.getCurrentStage():setFocus(nil)
 
 end
 --]]


  display.getCurrentStage():setFocus( self ) 

 
  if ( event.phase=="began"  ) then

   -- print(event.x)
    --print(event.y)
    --print(player.x)
    --print(player.y)

 --[[ 
--deltaX = player.x - event.x
--deltaY = player.y - event.y
deltaX = event.x - player.x
deltaY = event.y - player.y

normDeltaX = deltaX / math.sqrt(math.pow(deltaX,2) + math.pow(deltaY,2))
normDeltaY = deltaY / math.sqrt(math.pow(deltaX,2) + math.pow(deltaY,2))
  
  
 player:applyLinearImpulse( normDeltaX * 10 , normDeltaY * 10 , player.x , player.y)
 
   end
  
  --]]

 
 --[[
 
 if ( player.y > event.y and player.x > event.x )then -- en desce e en direita

--print("1")
--player:applyLinearImpulse( -3 , -3 ,  player.x , player.y )
player:setLinearVelocity( -velPlayer , -velPlayer )
end

if ( player.y > event.y and player.x < event.x )then -- en desce e en esquerda--ok

--print("2")
--player:applyLinearImpulse( 3 , -3 ,  player.x , player.y )--ok
player:setLinearVelocity( velPlayer , -velPlayer )
end

if ( player.y < event.y and player.x < event.x )then -- en sobe e en esquerda

--print("3")
--player:applyLinearImpulse( -3 , 3 ,  player.x , player.y )
player:setLinearVelocity( velPlayer , velPlayer )
end

if ( player.y < event.y and player.x > event.x )then-- en sobe e en direita

--print("4")
--player:applyLinearImpulse( -3 , -3 ,  player.x , player.y )
player:setLinearVelocity( -velPlayer , velPlayer )
end

if ( player.y == event.y and player.x > event.x )then--   en direita apenas

--print("5")  
--player:applyLinearImpulse( 3 , 0 ,  player.x , player.y )
player:setLinearVelocity( -velPlayer , 0 )
end

if ( player.y == event.y and player.x < event.x )then --   en esq apenas

--print("6")  
--player:applyLinearImpulse( -3 , 0 ,  player.x , player.y )
player:setLinearVelocity( velPlayer , 0 )
end

if ( player.y > event.y and player.x == event.x )then --   en sobe apenas

--print("7")   
--player:applyLinearImpulse( 0 , -3 ,  player.x , player.y )
player:setLinearVelocity( 0, -velPlayer )
end

if ( player.y < event.y and player.x == event.x )then

--print("8")   
--player:applyLinearImpulse( 0 , -3 ,  player.x , player.y )
player:setLinearVelocity( 0, velPlayer )
end 

-]]



deltaX = event.x - player.x
deltaY = event.y - player.y
normDeltaX = deltaX / math.sqrt(math.pow(deltaX,2) + math.pow(deltaY,2))
normDeltaY = deltaY / math.sqrt(math.pow(deltaX,2) + math.pow(deltaY,2))

 player:setLinearVelocity( normDeltaX  * velPlayer, normDeltaY  * velPlayer )


 end
 
 end
 


function update()

textPoint.text = point

local colide = hasCollided( player , alvo )

if ( colide or dead == true ) then
point = point + 1
alvoPos()

 end 


 end 









-- Called when the scene's view does not exist:
function scene:createScene(event)

    --groupBkg = display.newGroup()

     group = self.view
    
     

display.setDefault( "background", 3, 5, 5 )
--bkg = display.newImage( "sky.png", display.contentCenterX, display.contentCenterY )
--bkg:addEventListener("touch", playerTouched )
--bkg = display.newImage( "sky.png", display.contentCenterX, display.contentCenterY ) 
--group:insert(bkg)
--groupBkg:insert(bkg)

textPoint = display.newText( "0", display.contentCenterX , 25 , native.systemFontBold, 26 )
timeText = display.newText( "0", display.contentCenterX  + 80 , 25 , native.systemFontBold, 26 )
timeText:setFillColor( 0 , 0, 0 )
textPoint:setFillColor( 0 , 0, 0 )
group:insert(timeText) 
group:insert(textPoint)


 local borderBottom = display.newRect( 0, _H , _W*2 , 20 )
borderBottom:setFillColor( "black")    -- make invisible
physics.addBody( borderBottom, "static", borderBodyElement )
group:insert(borderBottom)

 --display.newRect( x, y, width, height ) 
  
local borderTop1 = display.newRect( 0, 0, _W*2 , 20 )
borderTop1:setFillColor( "black")    -- make invisible
physics.addBody( borderTop1, "static", borderBodyElement ) 
group:insert(borderTop1)
 
 local borderLeft = display.newRect( 0, 0, 20 , _H*2 )
borderLeft:setFillColor("black" )    -- make invisible
physics.addBody( borderLeft, "static", borderBodyElement )
group:insert(borderLeft)


local borderRight = display.newRect( _W , 20, 20, _H*2 )
borderRight:setFillColor("black")   -- make invisible
physics.addBody( borderRight, "static", borderBodyElement )
group:insert(borderRight)


 


for  i = 1 , 10 do  

 local enemy = display.newCircle(100,100, 30)
 physics.addBody( enemy , "dynamic", { density = 1.0 , friction = 0 , bounce = 0 , radius = 30 })
 enemy.isFixedRotation = true
 group:insert(enemy) -- Insere no display pra controla-lo visualmente
 --enemy.isSensor=true
 enemy:setFillColor(  0.8 )
 enemy.myName = "inimigo"
 enemy.collision = onLocalCollision
 enemy:addEventListener( "collision", enemy )

table.insert( enemies , enemy) -- Usa o array para controlar logicamente os objetos


end
 
 player = display.newCircle(centerX,centerY, 30)
 physics.addBody( player , "dynamic", { density = 1.0 , friction = 0 , bounce = 0 , radius = 30 })
 player.isFixedRotation = true
 player:setFillColor( 0.2 )
 player.myName = "player"
player.collision = onLocalCollision
group:insert(player)
player:addEventListener( "collision", player )
--print(player.x)


alvo = display.newRect( 20 , math.random(0,_H ) ,  35 , 35)
alvo:setFillColor( "black" )
group:insert(alvo)


--bkg:addEventListener("touch",playerTouched)
Runtime:addEventListener("touch", playerTouched )
 
 
end







function move()
--transition.to( enemy , { time=math.random(500,1500) , x= math.random(0,_W), y = math.random(0,_H) , onComplete=move } )


--enemy:setLinearVelocity(math.random(-500,500), math.random(-500,500));
--[[
enemy:setLinearVelocity( 500 , 0 );

if ( enemy.x >= _W*2 ) then enemy:setLinearVelocity( -500 ,0 ) end

if ( enemy.x <= 0 ) then enemy:setLinearVelocity( 500 ,0 ) end

if ( enemy.y >= _H ) then enemy:setLinearVelocity( 0 , -500 ) end

if ( enemy.y <= 0 ) then enemy:setLinearVelocity( 0 , 500 ) end

--]]


--enemy:applyLinearImpulse( math.random(-_W,_W) , math.random(-_H,_H)  , enemy.x , enemy.y )
for i=1, 10 do 
enemy=enemies[i]
--enemy:applyLinearImpulse( math.random( -30, 30) , math.random( -30, 30)  , enemy.x , enemy.y )
enemy:applyLinearImpulse( math.random( -velEnemy, velEnemy ) , math.random( -velEnemy, velEnemy )  , enemy.x , enemy.y )
end

end





local function text( event )
         
  cont = event.count

  
  timeText.text = cont

 
    
end

 

 
 
---------------------------------------------------------------------------------
-- STORYBOARD FUNCTIONS
---------------------------------------------------------------------------------
 

 

 
-- Called immediately after scene has moved onscreen:
function scene:enterScene(event)
 
 group = display.newGroup()
 --group = self.view
 
 storyboard.removeScene("menu")


timerID = timer.performWithDelay( 700, text, -1 )
timerMove = timer.performWithDelay( 500 , move , -1)
timerLoop = timer.performWithDelay(1,update,-1)
 
 
 
end
 
 
-- Called when scene is about to move offscreen:
function scene:exitScene(event)
    local group = group
  
    --storyboard.removeAll()
    --storyboard.purgeAll()
 
 
end
 

 
 
-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene(event)
    local group = self.view
 
end


 
 
 
---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
 
scene:addEventListener("createScene", scene)
scene:addEventListener("enterScene", scene)
scene:addEventListener("exitScene", scene)
scene:addEventListener("destroyScene", scene)

 

 
---------------------------------------------------------------------------------
 
return scene