Class AOC2021.Day11 Extends AOC2021.Base
{

Parameter InputFile = "d11.txt";

// d ##class(AOC2021.Day11).Run()

ClassMethod Part1(verbose = 0) As %String [ Private ]
{
	set stream=..GetInput(..#InputFile)
    set line=0
	while 'stream.AtEnd {
		set line=line+1
		set record=stream.ReadLine()
		set recordsArr(line)=record
	}
	merge Grid=recordsArr
	set Total=0
	for I=1:1:100 {
		set Total=Total+..ChangeGrid(.Grid)
		if verbose write !!,I,! do ..PrintGrid(.Grid)
	}
	set Answer=Total
	quit Answer
}

ClassMethod PrintGrid(ByRef Grid) [ Private ]
{
	set Line="" for  {
		set Line=$order(Grid(Line)) quit:Line=""
		write !,Grid(Line)
	}
}

ClassMethod ChangeGrid(Output Grid) As %Integer [ Private ]
{
	set Y="" for  {
		set Y=$order(Grid(Y)) quit:Y=""
		for I=1:1:$length(Grid(Y)) {
			do ..ChangePos(.Grid,.Flashes,I,Y)
		}
	}
	set Total=0
	set Y="" for  {
		set Y=$order(Flashes(Y)) quit:Y=""
		set X=""
		for  {
			set X=$order(Flashes(Y,X)) quit:X=""
			set Total=Total+1
		}
	}
	quit Total
}

ClassMethod ChangePos(Output Grid, Output Flashes, X, Y) [ Private ]
{
	quit:$data(Flashes(Y,X))
	set Energy=$extract($get(Grid(Y)),X)
	quit:'$length(Energy)
	set Energy=Energy+1
	if Energy<10 {
		set $extract(Grid(Y),X)=Energy
	}
	else {
		set $extract(Grid(Y),X)=0
		set Flashes(Y,X)=""
		do ..ChangePos(.Grid,.Flashes,X-1,Y-1)
		do ..ChangePos(.Grid,.Flashes,X,Y-1)
		do ..ChangePos(.Grid,.Flashes,X+1,Y-1)
		do ..ChangePos(.Grid,.Flashes,X-1,Y)
		do ..ChangePos(.Grid,.Flashes,X+1,Y)
		do ..ChangePos(.Grid,.Flashes,X-1,Y+1)
		do ..ChangePos(.Grid,.Flashes,X,Y+1)
		do ..ChangePos(.Grid,.Flashes,X+1,Y+1)
	}
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
	merge Grid=recordsArr
	set Total=0,Size=$order(recordsArr(""),-1)*$length(recordsArr(1))
	for I=1:1 {
		set Total=..ChangeGrid(.Grid)
		quit:Total=Size
		if verbose write !!,I,! do ..PrintGrid(.Grid)
	}
	set Answer=I
	quit Answer
}

}

