Class AOC2021.Day22 Extends AOC2021.Base
{

Parameter InputFile = "d22.txt";

// d ##class(AOC2021.Day22).Run()

ClassMethod Part1(verbose = 0) As %String [ Private ]
{
	set stream=..GetInput(..#InputFile)
    set line=0
	while 'stream.AtEnd {
		set line=line+1
		set record=stream.ReadLine()
		set recordsArr(line)=record
	}
	set Answer="",Line=""
	for {
		set Line=$order(recordsArr(Line)) quit:Line=""
		set Record=recordsArr(Line)
		set fromX=+$piece(Record,"=",2),toX=+$piece(Record,"..",2)
		set fromY=+$piece(Record,"=",3),toY=+$piece(Record,"..",3)
		set fromZ=+$piece(Record,"=",4),toZ=+$piece(Record,"..",4)
		set opp=$piece(Record," ",1)
		set:fromX<-50 fromX=-50
		set:toX>50 toX=50
		continue:toX<fromX
		set:fromY<-50 fromY=-50
		set:toY>50 toY=50
		continue:toY<fromY
		set:fromZ<-50 fromZ=-50
		set:toZ>50 toZ=50
		continue:toZ<fromZ
		if verbose write !,fromX,"..",toX,",",fromY,"..",toY,",",fromZ,"..",toZ
		for x=fromX:1:toX {
			for y=fromY:1:toY {
				for z=fromZ:1:toZ {
					set cubes(x,y,z)=opp
				}
			}
		}
	}
	set total=0,x=""
	for  {
		set x=$order(cubes(x)) quit:x=""
		set y=""
		for  {
			set y=$order(cubes(x,y)) quit:y=""
			set z=""
			for  {
				set z=$order(cubes(x,y,z)) quit:z=""
				if cubes(x,y,z)="on" set total=total+1
			}
		}
	}
	set Answer=total

	quit Answer
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
	set Answer="",Line=""
	for {
		set Line=$order(recordsArr(Line)) quit:Line=""
		set Record=recordsArr(Line)
		set fromX=+$piece(Record,"=",2),toX=+$piece(Record,"..",2)
		set fromY=+$piece(Record,"=",3),toY=+$piece(Record,"..",3)
		set fromZ=+$piece(Record,"=",4),toZ=+$piece(Record,"..",4)
		set opp=$piece(Record," ",1)
		set inst($increment(inst))=$listbuild(fromX,toX,fromY,toY,fromZ,toZ,opp)
	}
	set total=0
	for i=1:1:inst {
		set data=inst(i) continue:$list(data,7)="off"
		set total=total+..GetTotal(data,i,.inst)
		if verbose zwrite data write total,!
	}
	set Answer=total
	quit Answer
}

ClassMethod GetTotal(data, i, ByRef inst) As %Integer [ Private ]
{
	set fromX=$list(data,1),toX=$list(data,2),fromY=$list(data,3),toY=$list(data,4),fromZ=$list(data,5),toZ=$list(data,6)
	set total=(toX-fromX+1)*(toY-fromY+1)*(toZ-fromZ+1)
	set toCheck=0
	for j=i+1:1:inst {
		set data=inst(j),opp=$list(data,7)
		set currFromX=$list(data,1),currToX=$list(data,2)
		set currFromY=$list(data,3),currToY=$list(data,4)
		set currFromZ=$list(data,5),currToZ=$list(data,6)
		set opp=$list(data,7)
		continue:currToX<fromX
		continue:currFromX>toX
		continue:currToY<fromY
		continue:currFromY>toY
		continue:currToZ<fromZ
		continue:currFromZ>toZ
		set:fromX>currFromX currFromX=fromX
		set:toX<currToX currToX=toX
		set:fromY>currFromY currFromY=fromY
		set:toY<currToY currToY=toY
		set:fromZ>currFromZ currFromZ=fromZ
		set:toZ<currToZ currToZ=toZ
		set toCheck($increment(toCheck))=$listbuild(currFromX,currToX,currFromY,currToY,currFromZ,currToZ,opp)
	}
	for j=1:1:toCheck {
		set total=total-..GetTotal(toCheck(j),j,.toCheck)
	}
	quit total
}

}

