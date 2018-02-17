local r = require("robot")

level = 0

function moveAndDig ()
	r.swing()
	r.forward()
	r.swingUp()
	r.swingDown()
end

function sixteen ()
	for i=0,15 do
		moveAndDig()
	end
end

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

function levelDown()
	for i=1,3 do
		r.swingDown()
		r.down()
	end
	level = level + 1
end

function dropInventory ()
	for i=1,level do
		r.up()
		r.up()
		r.up()
	end
	r.turnAround()
	for i=1,16 do
		r.select(i)
		r.drop()
	end
	r.turnAround()
	for i=1,level do
		r.down()
		r.down()
		r.down()
	end
	os.sleep(10)
end
	

function digLevels (levels)
	for i=1,levels do
		sixteenBySixteen()
		dropInventory()
		levelDown()
		level = level + 1
	end
	
end


level = 0
digLevels(15)