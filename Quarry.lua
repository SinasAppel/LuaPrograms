-- This program assumes the following scenerio to be true:
-- Behind the starting place of the robot is a inventory in which to deposit the mined product
-- Next to the starting place is a charging station to recharge the energy of the robot
-- Inventory slot 16 has stone inside of it


local r = require("robot")

level = 0

-- Digs and moves the robot one place
-- Robot will try to not mine any stone that it finds above and below it
-- (See "isNotStone")
function moveAndDig ()
	r.swing()
	r.forward()
	if isNotStone(1) then
		r.swingUp()
	end
	if isNotStone(2) then
		r.swingDown()
	r.swingDown()
	end
end

-- 1 = up, 2 = down
-- returns true if the detected block is stone
-- returns false if the detected block is not stone
function isNotStone (upOrDown)
	r.select(16)
	
	if upOrDown == 1 then
		if r.compareUp() then
			return false
		end
	end
	
	if upOrDown == 2 then
		if r.compareDown() then
			return false
		end
	end
	
	return false
end

-- Moves and digs the robot 16 places
function sixteen ()
	for i=0,15 do
		moveAndDig()
	end
end

-- Digs a 16x2 pattern
function sixteenByTwo ()
	sixteen()
	r.turnRight()
	moveAndDig()
	r.turnRight()
	sixteen()
	r.turnLeft()
	moveAndDig()
	r.turnLeft()
end

-- Digs a 16x16 pattern
function sixteenBySixteen ()
	sixteenByTwo()
	sixteenByTwo()
	sixteenByTwo()
	sixteenByTwo()
	sixteenByTwo()
	sixteenByTwo()
	sixteenByTwo()
	sixteenByTwo()
	r.turnLeft()
	for i=0,15 do
		r.forward()
	end
	r.turnRight()
end

-- Lets the robot go down a "level" (3 y levels down)
function levelDown()
	for i=1,3 do
		r.swingDown()
		r.down()
	end
	level = level + 1
end

-- Drop inventory in the chest at the starting place
function dropInventory ()
	for i=1,level do
		r.up()
		r.up()
		r.up()
	end
	r.turnAround()
	for i=1,15 do
		r.select(i)
		r.drop()
	end
	r.select(1)
	r.turnAround()
	for i=1,level do
		r.down()
		r.down()
		r.down()
	end
	os.sleep(10)
end
	
-- Input is amount of "levels" (each level is 3 y levels) the robot needs to dig
function digLevels (levels)
	for i=1,levels do
		sixteenBySixteen()
		dropInventory()
		levelDown()
	end
	
end

-- Start of program
digLevels(15)