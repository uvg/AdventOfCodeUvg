Class AOC2021.Day17 Extends AOC2021.Base
{

Parameter InputFile = "d17.txt";

// d ##class(AOC2021.Day17).Run()

ClassMethod Part1(verbose = 0) As %String [ Private ]
{
	set stream=..GetInput(..#InputFile)
    set line=0
	while 'stream.AtEnd {
		set line=line+1
		set record=stream.ReadLine()
		set recordsArr(line)=record
	}
	set target=recordsArr(1)
	set x1=+$piece(target,"x=",2),x2=+$piece(target,"..",2),y1=+$piece(target,"y=",2),y2=+$piece(target,"..",3)
	if verbose write !,target
	set maxy=0
	for velx=0:1:x2 {
		for vely=0:1:-y1 {
			set (x,y)=0,tempMaxY=0,sw=0,currVelX=velx,currVelY=vely
			for  {
				do ..SetNewPos(.x,.y,.currVelX,.currVelY)
				set:y>tempMaxY tempMaxY=y
				if x>=x1,x<=x2,y>=y1,y<=y2 set sw=1 quit
				if (x>x2)||(y<y1) quit
			}
			if sw,tempMaxY>maxy set maxy=tempMaxY
		}
	}
	set Answer=maxy

	quit Answer
}

ClassMethod SetNewPos(ByRef x, ByRef y, ByRef currVelX, ByRef currVelY) [ Private ]
{
	set x=x+currVelX,y=y+currVelY
	set:currVelX currVelX=currVelX-1
	set currVelY=currVelY-1
}

ClassMethod Part2(verbose = 0) As %String [ Private ]
{
	set stream=..GetInput(..#InputFile)
    set line=0
	while 'stream.AtEnd {
		set line=line+1
		set record=stream.ReadLine()
		set recordsArr(line)=record
	}
	set target=recordsArr(1)
	set x1=+$piece(target,"x=",2),x2=+$piece(target,"..",2),y1=+$piece(target,"y=",2),y2=+$piece(target,"..",3)
	if verbose write !,target
	set counter=0
	for velx=0:1:x2 {
		for vely=y1:1:-y1 {
			set (x,y)=0,sw=0,currVelX=velx,currVelY=vely
			for  {
				do ..SetNewPos(.x,.y,.currVelX,.currVelY)
				if x>=x1,x<=x2,y>=y1,y<=y2 set sw=1 quit
				if (x>x2)||(y<y1) quit
			}
			set:sw counter=counter+1
		}
	}
	set Answer=counter
	quit Answer
}

}

